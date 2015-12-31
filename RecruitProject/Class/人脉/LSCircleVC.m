//
//  LSCircleVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/24.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSCircleVC.h"
#import "LSSendPostVC.h"
#import "LSCircleMessageVC.h"
#import "LSCircleCell.h"
#import "YcKeyBoardView.h"
@interface LSCircleVC ()<UISearchBarDelegate,YcKeyBoardViewDelegate>
{
    UIButton *sendBtn;
    UISearchBar *_searchBar;
}
@property (nonatomic,strong)YcKeyBoardView *key;
@property (nonatomic,assign) CGFloat keyBoardHeight;
@property (nonatomic,assign) CGRect originalKey;
@property (nonatomic,assign) CGRect originalText;

@end
@implementation LSCircleVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isAppearRefresh = YES;
    self.offset = 10;
    [self addHeaderAndFooterRefresh];
    [self creatTableView:@"LSCircleCell"];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,40,0);
    [self addHeaderAndFooterRefresh];
  
    WeakSelf;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.tableViewKit.configureCellBlock = ^(LSCircleCell *cell,LSCircleModel *item,NSIndexPath *index)
    {
        cell.commentBtn.actionBlock = ^(UIButton *btn)
        {  //回复
            if(self.key==nil){
                weakSelf.key=[[YcKeyBoardView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-44, SCREEN_WIDTH, 44)];
            }
            weakSelf.key.delegate=weakSelf;
            [weakSelf.key.textView becomeFirstResponder];
            weakSelf.key.textView.returnKeyType = UIReturnKeySend;
            [weakSelf.view addSubview:weakSelf.key];
            weakSelf.key.postID = item.post_id;
            weakSelf.key.index = index;
          
        };
        cell.detailBtn.actionBlock = ^(UIButton *btn)
        {
            item.isShow = !item.isShow;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        if (cell.moreBtn) {
            cell.moreBtn.actionBlock = ^(UIButton *btn)
            {   
                item.isShowReply = !item.isShowReply;
                [weakSelf.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
        }
    };

    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return [LSCircleCell GetCellH:self.dataListArr[indexPath.row]];
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        if (section== 0) {
            return 50;
        }
         return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
         return 0.01;
    }];
    
    //搜索条
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.backgroundColor = [UIColor clearColor];
    [_searchBar setKeyboardType:UIKeyboardTypeDefault];
    _searchBar.placeholder = @"搜索帖子";
    _searchBar.frame = CGRectMake(0, 5, SCREEN_WIDTH-0, 40);


    _searchBar.barTintColor = color_bg;
    CALayer *layer=[_searchBar layer];
    //是否设置边框以及是否可见
    [layer setMasksToBounds:YES];
    //设置边框圆角的弧度
    [layer setCornerRadius:0.0];
    [layer setBorderWidth:1];
    //设置边框线的颜色
    [layer setBorderColor:[color_bg CGColor]];    //想要的颜色
    [self.tableView addSubview:_searchBar];
  
    //圈子详情
    UIButton *btn = [UIButton buttonWithImage:@"btn_screening_wihte" action:^(UIButton *btn) {
        if(self.isAdd)
        {
            LSCircleMessageVC *circleMessageVC = [[LSCircleMessageVC alloc] init];
            circleMessageVC.title = @"圈子详情";
            circleMessageVC.circle_id = self.circle_id;
            [self.navigationController pushViewController:circleMessageVC animated:YES];
        }else
        {
            [SVProgressHUD showInfoWithStatus:@"还没加入该圈子"];
        }
    }];
    btn.frame = CGRectMake(0, 0, 30, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    sendBtn = [UIButton buttonWithTitle:@"我要发帖" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
        if([btn.titleLabel.text isEqual:@"我要发帖"])
        {
            LSSendPostVC *sendpostVC = [[LSSendPostVC alloc] init];
            sendpostVC.title = @"发表帖子";
            sendpostVC.circle_id = self.circle_id;
            [self.navigationController pushViewController:sendpostVC animated:YES];
        }
        
        if([btn.titleLabel.text isEqual:@"申请加入"])
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.circle_id forKey:@"circle_id"];
            [LSHttpKit getMethod:@"c=Circle&a=joinCircle" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [SVProgressHUD showSuccessWithStatus:@"加入成功!"];
                self.isAdd = YES;
                [self refeshBtn];
            }];
        }
    }];
    [self.view addSubview:sendBtn];
    [self refeshBtn];
    sendBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 60 - 40, SCREEN_WIDTH, 40);
    [sendBtn setCornerRadius:3];
    [self addHeaderAndFooterRefresh];
    [self addObserverIndex:@"exitCircle"];
}

-(void)notification:(NSNotification *)noti
{
    if ([noti.name isEqual:@"exitCircle"]) {
        self.isAdd = NO;
        [self refeshBtn];
    }
}

-(void)refeshBtn
{
    if (self.isAdd) {
        [sendBtn setTitle:@"我要发帖" forState:UIControlStateNormal];
    }else
    {
         [sendBtn setTitle:@"申请加入" forState:UIControlStateNormal];
    }
}

#pragma mark -请求
-(void)httpRequest
{
        //圈子帖子
        [self.parDic setObject:[NSString stringWithFormat:@"%ld",(long)self.offset] forKey:@"size"];
        //个人详情
        [self.parDic setObject:self.circle_id forKey:@"circle_id"];
        if(self.keyword)
        {
           [self.parDic setObject:self.keyword forKey:@"keyword"];
        }
        [LSHttpKit getMethod:@"c=Circlepost&a=circlePost" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [self endRefresh];
           if (self.page == 1) {
                [self.dataListArr removeAllObjects];
          }
         NSArray *circleArr = responseObject[@"data"][@"circlepost_list"];
         for (NSDictionary *dic in circleArr) {
             LSCircleModel *model  = [LSCircleModel objectWithKeyValues:dic];
             [self.dataListArr addObject:model];
            }
            [self.tableView reloadData];
            if (circleArr.count < 10) {
                [self.tableView.footer endRefreshingWithNoMoreData];
            }
         }];
}

#pragma mark -  评论
-(void)keyBoardViewHide:(YcKeyBoardView *)keyBoardView textView:(UITextView *)contentView
{
    [contentView resignFirstResponder];
    //接口请求  评论
    if (contentView.text.length>=1) {
        WeakSelf;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:keyBoardView.postID  forKey:@"date_id"];
        [dic setObject:contentView.text forKey:@"txt"];
        
        [LSHttpKit getMethod:@"c=Comment&a=addComment" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //回复成功刷新
            LSCircleModel *model  =  [self.dataListArr objectAtIndex:keyBoardView.index.row];
            NSMutableDictionary *replyDic = [NSMutableDictionary dictionary];
            [replyDic setObject:APPDELEGETE.user.truename forKey:@"name"];
            [replyDic setObject:contentView.text forKey:@"txt"];
          
            NSMutableArray *arr = [NSMutableArray arrayWithArray:model.comment_list];
            [arr insertObject:replyDic atIndex:0];
            model.comment_list = arr;
          
            [weakSelf.tableView reloadRowsAtIndexPaths:@[keyBoardView.index] withRowAnimation:UITableViewRowAnimationNone];
           
        }];
    }
    
}

#pragma mark - 键盘显示与隐藏
-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY= keyBoardRect.size.height;
    NSLog(@"%f",deltaY);
    deltaY = 226;
    self.keyBoardHeight=deltaY;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.key.transform=CGAffineTransformMakeTranslation(0, - deltaY);
    }];
}
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.key.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        self.key.textView.text=@"";
        [self.key removeFromSuperview];
    }];
    
}


#pragma mark - 搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
     self.keyword = searchBar.text;
    [self httpRequest];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    self.keyword = searchBar.text;
    [self httpRequest];
    return YES;
}

@end

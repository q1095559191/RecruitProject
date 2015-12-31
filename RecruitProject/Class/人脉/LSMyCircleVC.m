//
//  LSMyCircleVC.m
//  RecruitProject
//
//  Created by sliu on 15/10/12.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSMyCircleVC.h"
#import "LSCreatCircleVC.h"
#import "LSCircleCell.h"
#import "LSCircleVC.h"
#import "LSIntersetedCell.h"
@interface LSMyCircleVC ()
{
    UIButton *creatBtn;
}
@end

@implementation LSMyCircleVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isAppearRefresh = YES;
    if (self.ismyCreat) {
      [self creatTableView:@"LSCircleListCell"];
        self.tableView.delegate = self;
        self.tableView.edge(0,0,40,0);
        [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
            return 80;
        } Header:^CGFloat(UITableView *view, NSInteger section) {
            return 0.01;
        } Footer:^CGFloat(UITableView *view, NSInteger section) {
            return 0.01;
        }];
   
        creatBtn = [UIButton buttonWithTitle:@"创建圈子" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
            LSCreatCircleVC *creatVC = [[LSCreatCircleVC alloc] init];
            [self.navigationController pushViewController:creatVC animated:YES];
        }];
        [creatBtn setImage:[UIImage imageNamed:@"btn_screening_wihte"] forState:UIControlStateNormal];
        [self.view addSubview:creatBtn];
        creatBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 60 - 40, SCREEN_WIDTH, 40);
        [creatBtn setCornerRadius:3];
        
    }else
    {
       [self creatTableView:@"LSIntersetedCell"];
        self.tableView.delegate = self;
        self.tableView.edge(0,0,0,0);
        [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
            return [LSIntersetedCell GetCellH:self.dataListArr[indexPath.row]];
        } Header:^CGFloat(UITableView *view, NSInteger section) {
            return 0.01;
        } Footer:^CGFloat(UITableView *view, NSInteger section) {
            return 0.01;
        }];
        
        WeakSelf;
        self.tableViewKit.configureCellBlock = ^(LSIntersetedCell *cell,LSInterstedModel *item,NSIndexPath *index)
        {
            cell.attentionBtn.actionBlock = ^(UIButton *btn)
            {
              //退出圈子
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:item.circle_id forKey:@"circle_id"];
              [LSHttpKit getMethod:@"c=Circleuser&a=exitCircle" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  [SVProgressHUD showSuccessWithStatus:@"成功退出圈子"];
                  [weakSelf httpRequest];
              }];
            };
        };
    }
 
    [self addHeaderAndFooterRefresh];
}

-(void)httpRequest
{
   //我创建的圈子
    NSString *methodStr = nil;
    if (!self.ismyCreat) {
      methodStr  = @" c=Circle&a=myJoinCircles";
    }else
    {
      methodStr  = @"c=Circle&a=myCreateCircles";
   
    }
  
     [LSHttpKit getMethod:methodStr parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
         [self endRefresh];
         if (self.page == 1) {
             [self.dataListArr removeAllObjects];
         }
      NSArray *arr = nil;
         if (self.ismyCreat) {
             arr = responseObject[@"data"][@"mycircle_list"];
             for (NSDictionary *dic in arr) {
                 LSCircleModel *model = [LSCircleModel objectWithKeyValues:dic];
                 [self.dataListArr addObject:model];
             }
         }else
         {
             arr = responseObject[@"data"][@"my_join_circles_list"];
             for (NSDictionary *dic in arr) {
                 LSInterstedModel *model = [LSInterstedModel objectWithKeyValues:dic];
                 model.fromType = @"3";
                 [self.dataListArr addObject:model];
             }
         }
         if (self.ismyCreat) {
          [self handleNilData:@"您还未创建任何圈子" image:nil];
         }else
         {
          [self handleNilData:@"您还未加入建任何圈子" image:nil];
         }
         [self.tableView reloadData];
     }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LSCircleModel *model  =  self.dataListArr[indexPath.row];
    if([model.tb_audit isEqualToString:@"1"])
    {
        LSCircleVC  *circleVC = [[LSCircleVC alloc] init];
        circleVC.title = model.tb_name;
        circleVC.circle_id = model.circle_id;
        circleVC.isAdd = YES;
        [self.navigationController pushViewController:circleVC animated:YES];
    }else
    {
        [SVProgressHUD showInfoWithStatus:@"圈子正在审核中"];
    }
}
@end

//
//  LSReceivedResumeVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSReceivedResumeVC.h"
#import "LSPositionApplyCell.h"
#import "LSPopListVIew.h"
#import "LSCheckResumeVC.h"
#import "LSApplyDetailVC.h"
@interface LSReceivedResumeVC ()<CMPopTipViewDelegate>
{
    LSPopListVIew *popTipView;
    NSString *type;
    UIButton *choiseBtn;
}
@end

@implementation LSReceivedResumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addHeaderAndFooterRefresh];
    self.isAppearRefresh = YES;
    [self creatTableView:@"LSPositionApplyCell"];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,0,0);
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return 60;
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 15;
    }];
    
    choiseBtn = [UIButton buttonWithTitle:@"全部" titleColor:color_white BackgroundColor:[UIColor orangeColor] action:^(UIButton *btn) {
        if (popTipView.showpop) {
            [popTipView dismissAnimated:YES];
        }else
        {
            [popTipView presentPointingAtBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
        }
    }];
    choiseBtn.frame = CGRectMake(0, 0, 70, 25);
    [choiseBtn setCornerRadius:3];
    [choiseBtn setfont:14];
    [choiseBtn setImage:[UIImage imageNamed:@"icon_angle_up_white"] forState:UIControlStateNormal];
    [choiseBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 55, 0, 0)];
    [choiseBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:choiseBtn];
    [self creatPopView];
    

    
}


-(void)creatPopView
{
    NSArray *titles = @[@"全部",@"已读",@"未读",@"已邀请",@"未邀请"];
    popTipView = [LSPopListVIew popListView:titles];
    popTipView.delegate = self;
}

-(void)chocisePOPView:(NSInteger)index
{
    //5全部，1已读，2未读，3已邀请，4未邀请
    NSArray *titles = @[@"全部",@"已读",@"未读",@"已邀请",@"未邀请"];
    
    if (index == 0) {
        type = @"5";
    }else
    {
        type = [NSString stringWithFormat:@"%li",(long)index];
    }
 
    [self httpRequest];
    [choiseBtn setTitle:titles[index] forState:UIControlStateNormal];
    
}

#pragma mark -LSPopListView代理
- (void)popTipViewWasDismissedByUser:(LSPopListVIew *)popView
{
    popView.showpop = NO;
}

-(void)popTipViewAction:(LSPopListVIew *)popView
{
    [self chocisePOPView:popView.index];
}

-(void)httpRequest
{
    //收到的简历
    if (!type) {
        type = @"5";
    }
    [self.parDic setObject:type forKey:@"the_flag"];
    [LSHttpKit getMethod:@"c=Company&a=ReceivedResume" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (self.page == 1) {
            [self.dataListArr removeAllObjects];
        }
        
        NSArray *listArr = responseObject[@"data"][@"list"];
        if (ISNOTNILARR(listArr)) {
            for (NSDictionary *dic in listArr) {
                LSPositionModel *model = [LSPositionModel objectWithKeyValues:dic];
                model.fromType = @"9";
                [self.dataListArr addObject:model];
            }
     }
     [self.tableView reloadData];
    
    }];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSPositionModel *modle  = self.dataListArr[indexPath.row];
    
    LSCheckResumeVC *resumeDetailVC = [[LSCheckResumeVC alloc] init];
    resumeDetailVC.title = modle.truename;
    resumeDetailVC.resumeID = modle.resumes_id;
    resumeDetailVC.apply_id = modle.apply_id;
    resumeDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:resumeDetailVC animated:YES];
    
}

@end

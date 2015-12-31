//
//  LSApplyForResumeVC.m
//  RecruitProject
//
//  Created by sliu on 15/10/25.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSApplyForResumeVC.h"
#import "LSPositionCell.h"
#import "LSPositionDetailVC.h"
#import "LSPopListVIew.h"
#import "LSPositionApplyCell.h"

@interface LSApplyForResumeVC ()<CMPopTipViewDelegate>
{
    NSString *type;
    LSPopListVIew *popTipView;
    BOOL showpop ;
}
@end

@implementation LSApplyForResumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatTableView:@"LSPositionApplyCell"];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,0,0);
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return  80;
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    }];
    
 
    UIButton *choiseBtn = [UIButton buttonWithTitle:@"全部" titleColor:color_white BackgroundColor:[UIColor orangeColor] action:^(UIButton *btn) {
        if (popTipView.showpop) {
            [popTipView dismissAnimated:YES];
                   }else
        {
        [popTipView presentPointingAtBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
          
        }
    }];
    choiseBtn.frame = CGRectMake(0, 0, 60, 25);
    [choiseBtn setCornerRadius:3];
    [choiseBtn setfont:14];
    [choiseBtn setImage:[UIImage imageNamed:@"icon_angle_up_white"] forState:UIControlStateNormal];
    
    [choiseBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 45, 0, 0)];
    [choiseBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:choiseBtn];
    [self creatPopView];
   
}


-(void)creatPopView
{
     NSArray *titles = @[@"全部",@"已读",@"未读"];
     popTipView = [LSPopListVIew popListView:titles];
     popTipView.delegate = self;
    
}

- (void)popTipViewWasDismissedByUser:(LSPopListVIew *)popView
{
    popView.showpop = NO;
    
}

-(void)popTipViewAction:(LSPopListVIew *)popView
{
   
    if (popTipView.index == 0) {
        type = @"3";
    }
    
    if (popTipView.index == 1) {
        type = @"1";
    }
    if (popTipView.index == 2) {
        type = @"0";
    }
    [self httpRequest];
}

-(void)httpRequest{

 if(ISNILSTR(type))
 {
  type = @"3";
 }
[self.parDic setObject:type forKey:@"tb_read"];
    
[LSHttpKit getMethod:@"c=Personal&a=JobCandidates" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
    if (self.page == 1) {
        [self.dataListArr removeAllObjects];
    }
    [self endRefresh];
    for (NSDictionary *dic in responseObject[@"data"][@"list"]) {
        LSPositionModel *model = [LSPositionModel objectWithKeyValues:dic];
        model.fromType = @"5";
        [self.dataListArr addObject:model];
    }
    [self.tableView reloadData];
}];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //职位详情
    LSPositionDetailVC *positionDetailVC = [[LSPositionDetailVC alloc] init];
    positionDetailVC.hidesBottomBarWhenPushed = YES;
    positionDetailVC.positionModel = self.dataListArr[indexPath.row];
    [self.navigationController pushViewController:positionDetailVC animated:YES];
}
@end

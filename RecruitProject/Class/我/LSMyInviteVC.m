//
//  LSMyInviteVC.m
//  RecruitProject
//
//  Created by sliu on 15/11/17.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSMyInviteVC.h"
#import "LSPositionCell.h"
#import "LSApplyDetailVC.h"

@implementation LSMyInviteVC
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self creatTableView:@"LSPositionCell"];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,0,0);
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return 60;
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 15;
    }];
    [self addHeaderAndFooterRefresh];
    
}

-(void)httpRequest
{

 if(APPDELEGETE.isCompany)
 {   //我的面试邀请
     [LSHttpKit getMethod:@"c=Company&a=getInviteInterviewlist" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
         [self endRefresh];
         if (self.page == 1) {
             [self.dataListArr removeAllObjects];
         }
         
         NSArray *listArr = responseObject[@"data"][@"list"];
         if (ISNOTNILARR(listArr)) {
             for (NSDictionary *dic in listArr) {
                 LSPositionModel *model = [LSPositionModel objectWithKeyValues:dic];
                 model.fromType = @"10";
                 [self.dataListArr addObject:model];
             }
         }
         [self handleNilData];
         [self.tableView reloadData];
     }];
 }else
 {   //面试管理
     [LSHttpKit getMethod:@"c=Personal&a=InterviewNotice" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
         [self endRefresh];
         [self.dataListArr removeAllObjects];      
         NSArray *listArr = responseObject[@"data"][@"list"];
         if (ISNOTNILARR(listArr)) {
             for (NSDictionary *dic in listArr) {
                 LSPositionModel *model = [LSPositionModel objectWithKeyValues:dic];
                 model.fromType = @"11";
                 [self.dataListArr addObject:model];
             }
         }
         [self handleNilData];
         [self.tableView reloadData];
     }];
   }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSPositionModel *model = self.dataListArr[indexPath.row];
    LSApplyDetailVC *VC  = [[LSApplyDetailVC alloc] init];
    VC.title = self.title;
    VC.model = [[LSMessageModel alloc] init];
    VC.model.otherDic = [model keyValues];
    [self.navigationController pushViewController:VC animated:YES];
    
}
@end

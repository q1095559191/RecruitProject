//
//  LSCompanyMessageVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/28.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSCompanyMessageVC.h"
#import "LSCompanyMessageCell.h"
#import "LSCompanyMessageDetailVC.h"
@interface LSCompanyMessageVC ()

@end
@implementation LSCompanyMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isAppearRefresh = YES;
    // Do any additional setup after loading the view.
   [self creatTableView:@"LSCompanyMessageCell"];
    self.tableView.edge(0,0,0,0);
    self.tableView.delegate = self;
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return 70;
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 15;
    }];
    
  
}


-(void)httpRequest
{
    [LSHttpKit getMethod:@"c=Message&a=companyMessage" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (self.page == 1) {
            [self.dataListArr removeAllObjects];
        }
        NSArray *list =  responseObject[@"data"][@"company_message_list"];
        if (ISNOTNILARR(list)) {
            for (NSDictionary *dic in list) {
            LSMessageModel *model  = [LSMessageModel objectWithKeyValues:dic];
            [self.dataListArr addObject:model];
            }
        }
         [self handleNilData:@"您没有任何企业消息" image:nil];
        [self.tableView reloadData];
    }];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSMessageModel *model = self.dataListArr[indexPath.row];
    LSCompanyMessageDetailVC *VC = [[LSCompanyMessageDetailVC alloc] init];
    VC.model = model;
    VC.title = model.truename;
    [self.navigationController pushViewController:VC animated:YES];

}

@end

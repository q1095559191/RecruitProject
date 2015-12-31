//
//  LSLogVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSLogVC.h"
#import "LSLogModel.h"

@interface LSLogVC ()

@end

@implementation LSLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatTableView:@"LSLogCell"];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,0,0);
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return 80;
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    }];
    
}

-(void)httpRequest
{
//财务日志  置顶信息
[LSHttpKit getMethod:@"c=Company&a=BusinessLog" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

    
    NSArray *listArr = responseObject[@"data"][@"list"];
    if (ISNOTNILARR(listArr)) {
        for ( NSDictionary *dic in listArr) {
            LSLogModel *model = [LSLogModel objectWithKeyValues:dic];
            [self.dataListArr addObject:model];
        }
        [self.tableView reloadData];
    }
    
}];



}

@end

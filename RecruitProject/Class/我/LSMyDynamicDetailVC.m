//
//  LSMyDynamicDetailVC.m
//  RecruitProject
//
//  Created by sliu on 15/11/6.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSMyDynamicDetailVC.h"


@interface LSMyDynamicDetailVC ()

@end

@implementation LSMyDynamicDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.dataListArr addObject:self.model];
    self.title = self.model.tb_title;
    [self creatTableView:@"LSPersonalDynamicCell"];
    self.tableView.edge(0,0,0,0);
    self.tableView.delegate = self;
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return [LSPersonalDynamicCell GetCellH:self.dataListArr[indexPath.row]];
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    }];
    WeakSelf;
    self.tableViewKit.configureCellBlock = ^(LSPersonalDynamicCell *cell,LSDynamicModel *item,NSIndexPath *index)
    {
        cell.deleBtn.actionBlock = ^(UIButton *btn)
        {
            [LSHttpKit getMethod:@"c=Dynamic&a=deleteDynamics" parameters:@{@"dynamic_id":item.dynamic_id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }];
        };
    };
}



@end

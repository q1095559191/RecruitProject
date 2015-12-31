//
//  LSSystemMessageVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/28.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSSystemMessageVC.h"
#import "LSMessageCell.h"
#import "LSSystemMessageDetailVC.h"
@interface LSSystemMessageVC ()

@end

@implementation LSSystemMessageVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isAppearRefresh = YES;
    [self creatTableView:@"LSMessageCell"];
    self.tableView.edge(0,0,0,0);
    self.tableView.delegate = self;
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return [LSMessageCell GetCellH:self.dataListArr[indexPath.row]];
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 15;
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

-(void)httpRequest
{
    
[LSHttpKit getMethod:@"c=Message&a=systemMessage" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    if (self.page == 1) {
        [self.dataListArr removeAllObjects];
    }
    NSArray *list = responseObject[@"data"][@"system_message_list"];
    if (ISNOTNILARR(list)) {
        for (NSDictionary *dic in list) {
            LSMessageModel *model = [LSMessageModel  objectWithKeyValues:dic];
            [self.dataListArr addObject:model];
        }
          [self handleNilData:@"您没有任何系统消息" image:nil];
        [self.tableView reloadData];
    }
}];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSMessageModel *model = self.dataListArr[indexPath.row];
    LSSystemMessageDetailVC *VC= [[LSSystemMessageDetailVC alloc] init];
    VC.messageModle = model;
    [self.navigationController pushViewController:VC animated:YES];
}
@end

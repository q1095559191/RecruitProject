//
//  LSNewFriendVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSNewFriendVC.h"
#import "LSNewFriendCell.h"
#import "LSInterstedModel.h"
#import "LSPersonalHomePageVC.h"

@interface LSNewFriendVC ()<UITableViewDelegate>

@end

@implementation LSNewFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.dataListArr addObjectsFromArray:@[@"张三",@"王五",@"李四"]];
    [self creatTableView:@"LSNewFriendCell"];
     self.tableView.delegate = self;
     self.tableView.edge(0,0,0,0);
    WeakSelf;
    self.tableViewKit.configureCellBlock = ^(id cell ,LSInterstedModel * item,NSIndexPath *index)
    {   UIButton *attentionBtn  = [(LSNewFriendCell *)cell attentionBtn];
        attentionBtn.actionBlock = ^(UIButton *btn)
        {
            //关注
            //加关注
            [LSHttpKit getMethod:@"c=Circleuser&a=addConcern" parameters:@{@"side_id": item.member_id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
                item.is_friend = @"1";
                [weakSelf.tableView reloadData];
                [SVProgressHUD showSuccessWithStatus:@"关注成功"];
            }];

        };
    };
    
}



-(void)httpRequest
{
    
[LSHttpKit getMethod:@"c=Circleuser&a=newFriends" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
   NSArray *arr = responseObject[@"data"][@"new_friends_list"];
    for (NSDictionary *dic in arr) {
        LSInterstedModel *model = [LSInterstedModel objectWithKeyValues:dic];
       
        [self.dataListArr addObject:model];
    }
    [self.tableView reloadData];
}];
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LSInterstedModel *model  = self.dataListArr[indexPath.row];   
    LSPersonalHomePageVC *HomePageVC = [[LSPersonalHomePageVC alloc] init];
    HomePageVC.side_id = model.member_id;
    [self.navigationController pushViewController:HomePageVC animated:YES];
}



@end

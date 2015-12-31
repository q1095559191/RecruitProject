//
//  LSPersonalHomePageVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/24.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSPersonalHomePageVC.h"
#import "LSPersonalDynamicCell.h"
#import "LSMyDynamicDetailVC.h"
@interface LSPersonalHomePageVC ()<UITableViewDelegate>
{
    LSUserModel    *userModel;
    NSMutableArray *dynamic_list;
    UIButton       *attentionBtn;
}
@end

@implementation LSPersonalHomePageVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人主页";
    userModel = [[LSUserModel alloc] init];
    dynamic_list = [[NSMutableArray alloc] init];
    [self.dataListArr addObject:@[userModel]];
    [self.dataListArr addObject:@[@"他的动态"]];
    [self.dataListArr addObject:dynamic_list];
    
    [self creatTableView:@[@"LSPersonalHeadCell",@"LSPositionHeadCell", @"LSPersonalDynamicCell"]];
    self.tableView.delegate = self;
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40-60);
    
}

-(void)httpRequest
{
    [self.parDic setObject:[NSString stringWithFormat:@"%ld",(long)self.offset] forKey:@"size"];
    //个人详情
    [self.parDic setObject:@"personalHome" forKey:@"a"];
    [self.parDic setObject:@"Circleuser" forKey:@"c"];
    [self.parDic setObject:self.side_id forKey:@"side_id"];
    [LSHttpKit getMethod:nil parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [userModel setKeyValues:responseObject[@"data"][@"member_info"]];
        userModel.resume_task_completion  =  [NSString stringWithFormat:@"%@",responseObject[@"data"][@"resume_task_completion"]];
         userModel.is_friend  =  [NSString stringWithFormat:@"%@",responseObject[@"data"][@"is_friend"]];
        NSArray *m_dynamic_list = responseObject[@"data"][@"m_dynamic_list"];
        for (NSDictionary *dic in m_dynamic_list) {
            LSDynamicModel *model = [LSDynamicModel objectWithKeyValues:dic];
            [dynamic_list addObject:model];
        }
        [self.tableView reloadData];
        [self refreshView];
    }];
 
}

-(void)refreshView
{
    CGFloat left  = 30;
    CGFloat H    = 40;
    if (attentionBtn) {
        [attentionBtn removeFromSuperview];
    }
    if ([userModel.is_friend isEqualToString:@"0"]) {
        self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40-60);
        attentionBtn  = [UIButton buttonWithTitle:@"关注TA" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
            [LSHttpKit getMethod:@"c=Circleuser&a=addConcern" parameters:@{@"side_id": userModel.member_id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [SVProgressHUD showSuccessWithStatus:@"关注成功"];
                userModel.is_friend = @"1";
                [self  refreshView];
            }];
        }];
        attentionBtn.frame = CGRectMake(0, SCREEN_HEIGHT-60-H, SCREEN_WIDTH, H);
    }else
    {   self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-65-60);
        attentionBtn  = [UIButton buttonWithTitle:@"取消关注" titleColor:color_white BackgroundColor:color_bg_yellow action:^(UIButton *btn) {
            
            [LSHttpKit getMethod:@"c=Circleuser&a=cancelConcern" parameters:@{@"side_id": userModel.member_id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [SVProgressHUD showSuccessWithStatus:@"取消关注成功"];
                userModel.is_friend = @"0";
                [self  refreshView];
            }];
            
        }];
         attentionBtn.frame = CGRectMake(left, SCREEN_HEIGHT-60-H-15, SCREEN_WIDTH-2*left, H);
    }
    [attentionBtn setCornerRadius:3];
    [self.view addSubview:attentionBtn];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90;
    }else   if (indexPath.section == 1)
    {
        return 40;
    }else
    {   //动态
        return [LSPersonalDynamicCell GetCellH:dynamic_list[indexPath.row]];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
         return 15;
    }else
    {   return 0.01;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        LSDynamicModel *model = dynamic_list[indexPath.row];
        LSMyDynamicDetailVC *VC = [[LSMyDynamicDetailVC alloc] init];
        VC.model = model;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}


@end

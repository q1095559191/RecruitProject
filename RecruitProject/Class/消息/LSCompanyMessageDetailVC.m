//
//  LSCompanyMessageDetailVC.m
//  RecruitProject
//
//  Created by sliu on 15/11/5.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSCompanyMessageDetailVC.h"
#import "LSCompanyMessageDetailCell.h"
#import "LSCompanyDetailVC.h"
#import "LSPositionDetailVC.h"
#import "LSPersonalHomePageVC.h"
#import "LSApplyDetailVC.h"

@interface LSCompanyMessageDetailVC ()

@end

@implementation LSCompanyMessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.dataListArr addObject:self.model];
    [self creatTableView:@"LSCompanyMessageDetailCell"];
    self.tableView.edge(0,0,0,0);
    self.tableView.delegate = self;
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return [LSCompanyMessageDetailCell GetCellH:self.model];
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 15;
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //企业介绍
    NSString *btnTitle = @"企业介绍";
    if (APPDELEGETE.isCompany) {
     btnTitle = @"个人主页";
    }
    UIButton *btn = [UIButton buttonWithTitle:btnTitle titleColor:color_white BackgroundColor:color_clear action:^(UIButton *btn) {
        if (APPDELEGETE.isCompany) {
            LSPersonalHomePageVC *HomePageVC = [[LSPersonalHomePageVC alloc] init];
            HomePageVC.side_id = self.model.msg_from_uid;
            [self.navigationController pushViewController:HomePageVC animated:YES];
           
        }else
        {
            LSCompanyDetailVC *companyDetailVC  = [[LSCompanyDetailVC alloc] init];
            companyDetailVC.companyID = self.model.msg_from_uid;
            [self.navigationController pushViewController:companyDetailVC animated:YES];
        }
    }];
    [btn setfont:14];
    btn.frame = CGRectMake(0, 0, 60, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}


-(void)httpRequest
{
WeakSelf;
[self.parDic setObject:self.model.msg_id forKey:@"message_id"];
[self.parDic setObject:self.model.msg_type forKey:@"msg_type"];
[LSHttpKit getMethod:@"c=Message&a=getMessageInfo" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
  weakSelf.model.msg_read = @"1";
}];
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([self.model.msg_type isEqualToString:@"11"] || [self.model.msg_type isEqualToString:@"12"]) {
        //去公司主页 收藏/查看
        LSCompanyDetailVC *companyDetailVC  = [[LSCompanyDetailVC alloc] init];
        companyDetailVC.companyID = self.model.msg_from_uid;
        [self.navigationController pushViewController:companyDetailVC animated:YES];
        
    }
    
    if ([self.model.msg_type isEqualToString:@"13"] || [self.model.msg_type isEqualToString:@"14"]) {
    //面试邀请

        LSApplyDetailVC *VC  = [[LSApplyDetailVC alloc] init];
        VC.title = self.title;
        VC.model = self.model;
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
    
    if ([self.model.msg_type isEqualToString:@"21"] || [self.model.msg_type isEqualToString:@"22"]) {
        //职位详情 简历详情
        LSPersonalHomePageVC *HomePageVC = [[LSPersonalHomePageVC alloc] init];
        HomePageVC.side_id = self.model.msg_from_uid;
        [self.navigationController pushViewController:HomePageVC animated:YES];
    }
    
    if ([self.model.msg_type isEqualToString:@"23"])
    {
       //关注
        LSPersonalHomePageVC *HomePageVC = [[LSPersonalHomePageVC alloc] init];
        HomePageVC.side_id = self.model.msg_from_uid;
        [self.navigationController pushViewController:HomePageVC animated:YES];
    
    }
        
    

}

@end

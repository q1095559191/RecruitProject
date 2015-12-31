//
//  LSCompanyVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSCompanyVC.h"
#import "LSServiceMangeVC.h"
#import "LSLogVC.h"
#import "LSMyDynamicVC.h"
#import "LSMyPositionVC.h"
#import "LSReadedResumeVC.h"
#import "LSReceivedResumeVC.h"
#import "LSContactsCell.h"
#import "LSCompanySettingVC.h"
#import "LSMineDetailCell.h"
#import "LSMyInviteVC.h"
#import "LSTipModel.h"

@interface LSCompanyVC ()<UITableViewDelegate>
{
  LSTipModel *tipModel;
}
@end

@implementation LSCompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isAppearRefresh = YES;
    NSDictionary *tipDic =   [NSObject getSaveDateWithKey:LSSAVE_tip_personal];
    if (ISNOTNILDIC(tipDic)) {
        tipModel = [LSTipModel objectWithKeyValues:tipDic];
    }else
    {
        tipModel = [[LSTipModel alloc] init];
    }
    
    NSArray *titles = @[@[@"1",@"2"],@[@"我发布的职位",@"我收到的简历",@"我的面试邀请",@"我收藏的简历",@"我看过的简历"],@[@"我的动态"],@[@"业务日志"]];
    NSArray *images = @[@[@"1",@"1"],@[@"icon_myapplyjob_normal",@"icon_myreceivedresume_normal",@"icon_nterview_invitation_normal-0",@"icon_mycollcetionresume_normal",@"icon_whoseemyresume_normal"],@[@"icon_mydynamic_normal"],@[@"icon_servicemanagement_normal"]];
   
    [self.dataListArr addObjectsFromArray:[LSBaseModel getBaseModels:titles images:images]];
    [self.dataListArr replaceObjectAtIndex:0 withObject:@[tipModel,tipModel]];
    [self  creatTableView:@[@[@"LSMineCell",@"LSMineDetailCell"],@"LSContactsCell",@"LSContactsCell",@"LSContactsCell"]];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,0,0);
    
    UIButton *singoutBtn = [UIButton buttonWithTitle:@"退出登录" titleColor:color_white BackgroundColor:color_bg_yellow action:^(UIButton *btn) {
        //退出登录
        [NSObject removeSaveWithKey:LSSAVE_USERPASSWORD];
        [APPDELEGETE showLogin];
    }];
    singoutBtn.frame = CGRectMake(20, 0, SCREEN_WIDTH - 40, 40);
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 55);
    [view addSubview:singoutBtn];
    self.tableView.tableFooterView = view;
    [singoutBtn setCornerRadius:3];


    
    
}

-(void)httpRequest
{
   //公司首页信息
    [LSHttpKit getMethod:@"c=Company&a=MeInfo" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:responseObject[@"data"]];
        
        //防止Values为空
        NSArray *keys = [dic allKeys];
        NSArray *allValues = [dic allValues];
        for (int i = 0; i < keys.count; i++) {
            id obj =  allValues[i];
            if (![obj isKindOfClass:[NSString class]]) {
                [dic setValue:@"" forKey:keys[i]];
            }
        }
        //数据本地缓存
        [dic  saveDateWithKey:LSSAVE_tip_personal];
        [tipModel setKeyValues:dic];
        [self.tableView reloadData];
        //申请 收藏数量
        LSBaseModel *model1 =  self.dataListArr[1][0];
        LSBaseModel *model2 =  self.dataListArr[1][1];
        LSBaseModel *model3 =  self.dataListArr[1][3];
        model1.detailTile = tipModel.OpeningsCount;
        model2.detailTile = tipModel.applyCount;
        model3.detailTile = tipModel.FavCount;
        [self.tableView reloadData];
        
    }];
    
     //个人用户信息
    [LSHttpKit getMethod:@"c=Personal&a=getMyInfo" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = responseObject[@"data"];
        if (ISNOTNILDIC(dic)) {
            
            [APPDELEGETE.user setKeyValues:dic];
            NSIndexSet *index = [NSIndexSet indexSetWithIndex:0];
            [self.tableView reloadSections:index withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 90;
        }else
        {
            return 70;
        }
    }
    return 50;
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
    if (indexPath.section == 0) {
        //个人信息
        if(indexPath.row == 0)
        {
            LSCompanySettingVC *setVC = [[LSCompanySettingVC alloc] init];
            setVC.title = @"企业资料";
            setVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setVC animated:YES];
        }
        
    }else if (indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
            {
                LSMyPositionVC *dynamicVC = [[LSMyPositionVC alloc] init];
                dynamicVC.hidesBottomBarWhenPushed = YES;
                dynamicVC.title = @"我发布的职位";
                [self.navigationController pushViewController:dynamicVC animated:YES];
            }
                break;
            case 1:
            {  //我收到的简历
                LSReceivedResumeVC *ReceivedResumeVC = [[LSReceivedResumeVC alloc] init];
                ReceivedResumeVC.hidesBottomBarWhenPushed = YES;
                ReceivedResumeVC.title = @"我收到的简历";
                [self.navigationController pushViewController:ReceivedResumeVC animated:YES];
            }
                break;
            case 2:
            {
                LSMyInviteVC *ReceivedResumeVC = [[LSMyInviteVC alloc] init];
                ReceivedResumeVC.hidesBottomBarWhenPushed = YES;
                ReceivedResumeVC.title = @"我的面试邀请";
                [self.navigationController pushViewController:ReceivedResumeVC animated:YES];
            }
                break;
            case 3:
            {
                LSReadedResumeVC *ReadedResumeVC = [[LSReadedResumeVC alloc] init];
                ReadedResumeVC.hidesBottomBarWhenPushed = YES;
                ReadedResumeVC.title = @"我收藏的简历";
                ReadedResumeVC.isCollection = YES;
                [self.navigationController pushViewController:ReadedResumeVC animated:YES];
            }
                break;
            case 4:
            {
                LSReadedResumeVC *ReadedResumeVC = [[LSReadedResumeVC alloc] init];
                ReadedResumeVC.hidesBottomBarWhenPushed = YES;
                ReadedResumeVC.title = @"我看过的简历";
                [self.navigationController pushViewController:ReadedResumeVC animated:YES];
            }
                break;
                
            default:
                break;
        }
        
        
    }else  if (indexPath.section == 2)
    {   //我的动态
        LSMyDynamicVC *dynamicVC = [[LSMyDynamicVC alloc] init];
        dynamicVC.hidesBottomBarWhenPushed = YES;
        dynamicVC.title = @"我的动态";
        [self.navigationController pushViewController:dynamicVC animated:YES];
        
    }else
    {
       if(indexPath.row == 0)
       {   //业务日志
           LSLogVC *logVC = [[LSLogVC alloc] init];
           logVC.hidesBottomBarWhenPushed = YES;
           logVC.title = @"业务日志";
           [self.navigationController pushViewController:logVC animated:YES];
        }else if (indexPath.row == 1)
        {//财务日志
        
     
        }else
        {
            
            
        }
    }
}



@end

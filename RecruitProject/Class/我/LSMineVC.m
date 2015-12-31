//
//  LSMineVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/21.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSMineVC.h"
#import "LSMineSettingVC.h"
#import "LSMyDynamicVC.h"
#import "LSMyResumeVC.h"
#import "LSPosition_meVC.h"
#import "LSPrivacyVC.h"
#import "LSContactsCell.h"
#import "LSTipModel.h"
#import "LSMineDetailCell.h"
#import "LSMyInviteVC.h"
#import "LSApplyForResumeVC.h"

@interface LSMineVC ()<UITableViewDelegate>
{
    LSTipModel *tipModel;
}
@end

@implementation LSMineVC
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
    
    NSArray *titles =@[@[@"1",@"2"],@[@"我的简历",@"谁看过我的简历"],@[@"我应聘的职位",@"我收藏的职位"],@[@"我的动态",@"求职隐私设置"]];
    NSArray *images = @[@[@"1",@"2"],@[@"icon_myresume_normal",@"icon_whoseemyresume_normal"],@[@"icon_mypublishedresume_normal",@"icon_mygroup_normal"],@[@"icon_mydynamic_normal",@"icon_jobprivacy_normal"]];
    [self.dataListArr addObjectsFromArray:[LSBaseModel getBaseModels:titles images:images]];
    [self.dataListArr replaceObjectAtIndex:0 withObject:@[tipModel,tipModel]];
    
    [self creatTableView:@[@[@"LSMineCell",@"LSMineDetailCell"],@"LSContactsCell",@"LSContactsCell",@"LSContactsCell"]];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,0,0);
    
    UIButton *singoutBtn = [UIButton buttonWithTitle:@"退出登录" titleColor:color_white BackgroundColor:color_bg_yellow action:^(UIButton *btn) {
        //退出圈子
       [NSObject removeSaveWithKey:LSSAVE_USERPASSWORD];
       [APPDELEGETE showLogin];
    }];
    singoutBtn.frame = CGRectMake(20, 0, SCREEN_WIDTH - 40, 40);
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 55);
    [view addSubview:singoutBtn];
    self.tableView.tableFooterView = view;
    [singoutBtn setCornerRadius:3];
    WeakSelf;
    self.tableViewKit.configureCellBlock = ^(LSMineDetailCell *cell,id item,NSIndexPath *index)
    {
        if (index.section == 0 && index.row == 1) {
            UIView *view1  =  (UIView *)[cell.contentView viewWithTag:88];
            UIView *view2  =  (UIView *)[cell.contentView viewWithTag:89];
            UIView *view3  =  (UIView *)[cell.contentView viewWithTag:90];
            view1.userInteractionEnabled = YES;
            view2.userInteractionEnabled = YES;
            view3.userInteractionEnabled = YES;
            [view1 bk_whenTapped:^{
             //我应聘的职位
                LSApplyForResumeVC *vc = [[LSApplyForResumeVC alloc] init];
                vc.title  = @"我应聘的职位";
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
                
            }];
            [view2 bk_whenTapped:^{
             //我的简历
                LSMyResumeVC *resumeVC  = [[LSMyResumeVC alloc] init];
                resumeVC.title  = @"我的简历";
                resumeVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:resumeVC animated:YES];
            }];
            [view3 bk_whenTapped:^{
             //面试通知
                
                LSMyInviteVC *ReceivedResumeVC = [[LSMyInviteVC alloc] init];
                ReceivedResumeVC.hidesBottomBarWhenPushed = YES;
                ReceivedResumeVC.title = @"面试管理";
                [weakSelf.navigationController pushViewController:ReceivedResumeVC animated:YES];
                
                
            }];
            
        }
    };
    
    
}


-(void)httpRequest
{

[LSHttpKit getMethod:@"c=Personal&a=MeInfo" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

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
    LSBaseModel *model1 =  self.dataListArr[2][0];
    LSBaseModel *model2 =  self.dataListArr[2][1];
    model1.detailTile = tipModel.apply_count;
    model2.detailTile = tipModel.fav_count;
    [self.tableView reloadData];
    
}];
    
    
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
            LSMineSettingVC *settingVC  = [[LSMineSettingVC alloc] init];
            settingVC.title  = @"个人信息";
            settingVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:settingVC animated:YES];
           
        }
    
    }else if (indexPath.section == 1)
    {   //我的简历 谁看过我的简历
        if(indexPath.row == 0)
        {
            LSMyResumeVC *resumeVC  = [[LSMyResumeVC alloc] init];
            resumeVC.title  = @"我的简历";
            resumeVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:resumeVC animated:YES];
        }else
        {
            LSPosition_meVC *Position_meVC = [[LSPosition_meVC alloc] init];
            Position_meVC.title  = @"谁看过我的简历";
            Position_meVC.isCollection = NO;
            Position_meVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:Position_meVC animated:YES];
        }
    
    }else if (indexPath.section == 2)
    {   //我应聘的职位  我收藏的职位
       
        if (indexPath.row == 0) {
            LSApplyForResumeVC *vc = [[LSApplyForResumeVC alloc] init];
            vc.title  = @"我应聘的职位";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            LSPosition_meVC *Position_meVC = [[LSPosition_meVC alloc] init];
            Position_meVC.title  = @"我收藏的职位";
            Position_meVC.isCollection = YES;
            Position_meVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:Position_meVC animated:YES];
        }       
        
    }
    else
    {   if(indexPath.row == 0)
       {//我的动态
        LSMyDynamicVC *dynamicVC = [[LSMyDynamicVC alloc] init];
        dynamicVC.hidesBottomBarWhenPushed = YES;
        dynamicVC.title = @"我的动态";
        [self.navigationController pushViewController:dynamicVC animated:YES];
        }else
        {//求职隐私设置
            LSPrivacyVC  *PrivacyVC = [[LSPrivacyVC alloc] init];
            PrivacyVC.hidesBottomBarWhenPushed = YES;
            PrivacyVC.title = @"求职隐私设置";
            [self.navigationController pushViewController:PrivacyVC animated:YES];
        }
   }
    
}


@end

//
//  LSMessageVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSMessageVC.h"
#import "LSCompanyMessageVC.h"
#import "LSSystemMessageVC.h"
#import "LSFriendMessageVC.h"
#import "LSNewFriendVC.h"
#import "LSBaseModel.h"
#import "LSContactsCell.h"

@interface LSMessageVC ()<UITableViewDelegate>
{

}
@end

@implementation LSMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    NSArray *titles ;
    NSArray *images;
    
    if (APPDELEGETE.isCompany) {
        titles = @[@"人才消息",@"系统消息"];
        images = @[@"icon_friendmessage_normal",@"icon_systemmessage_normal"];
      
    }else
    {
       titles = @[@"企业消息",@"系统消息"];
       images = @[@"icon_companymessage_normal",@"icon_systemmessage_normal"];
    }
    
    
    NSArray *models =  [LSBaseModel getBaseModels:titles images:images];
    [self.dataListArr addObjectsFromArray:@[models]];

    [self creatTableView:@"LSContactsCell"];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,0,0);
    [self refreshNum];
    
}

-(void)refreshNum
{
    for (int i = 0; i < [self.dataListArr[0] count]; i++) {
        LSBaseModel *model = self.dataListArr[0][i];
        if (i == 0) {
            if (APPDELEGETE.isCompany) {
                model.index =  APPDELEGETE.messageNum.c_num;
            }else
            {
                model.index =  APPDELEGETE.messageNum.p_num;
            }
        }else
        {
                model.index =  APPDELEGETE.messageNum.s_num;
        }
    }
    if (self.tableView) {
       [self.tableView reloadData];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    UIViewController* messageVC;
    if (indexPath.row == 0) {
        if (APPDELEGETE.isCompany) {
           messageVC = [[LSFriendMessageVC alloc] init];
        }else
        {
          messageVC = [[LSCompanyMessageVC alloc] init];
        }
    }else if (indexPath.row == 1)
    {
       messageVC = [[LSSystemMessageVC alloc] init];
    }
    
    LSBaseModel *model = (LSBaseModel *)self.dataListArr[indexPath.section][indexPath.row];
    messageVC.title = model.title;
    messageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageVC animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tabBarController httpRequest];

}

@end

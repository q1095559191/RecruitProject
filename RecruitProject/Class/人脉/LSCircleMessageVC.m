//
//  LSCircleMessageVC.m
//  RecruitProject
//
//  Created by sliu on 15/10/12.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSCircleMessageVC.h"
#import "LSCircleInfoModel.h"
#import "LSTextCell.h"
#import "LSCircleUserCell.h"
@interface LSCircleMessageVC ()
{
    UIButton *singoutBtn;
    LSCircleInfoModel *circleInfoModel;
    NSMutableArray *userArr;
}
@end
@implementation LSCircleMessageVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    circleInfoModel = [[LSCircleInfoModel alloc] init];
    userArr = [NSMutableArray array];
    
    [self.dataListArr addObject:@[circleInfoModel]];
    [self.dataListArr addObject:@[@"圈子公告",circleInfoModel]];
    [self.dataListArr addObject:@[@"圈子成员",userArr]];

    
    NSMutableArray *cellArr = [NSMutableArray array];
    [cellArr addObject:@[@"LSCircleDetailHeadCell"]];
    [cellArr addObject:@[@"LSHeadCell",@"LSTextCell"]];
    [cellArr addObject:@[@"LSHeadCell",@"LSCircleUserCell"]];

//消息免打扰
//    [cellArr addObject:@[@"LSCircleMessageCell"]];
//    [self.dataListArr addObject:@[@"消息免打扰"]];
    
    [self creatTableView:cellArr];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,0,0);
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        if (indexPath.section == 0) {
            return 180;
        }else if (indexPath.section == 1)
        {
            if (indexPath.row==0) {
                return 40;
            }else
            {
                return [LSTextCell GetCellH:self.dataListArr[1][0]];
            }
        
        }else if (indexPath.section == 2)
        {
            if (indexPath.row==0) {
                return 40;
            }else
            {
                return [LSCircleUserCell GetCellH:self.dataListArr[2][1]];
            }
            
        }else
        {
            return 60;
        }
        return 100;
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
    
        return 15;
    }];
    
    self.title = @"圈子信息";
    singoutBtn = [UIButton buttonWithTitle:@"退出圈子" titleColor:color_white BackgroundColor:color_bg_yellow action:^(UIButton *btn) {
    //退出圈子
    [LSHttpKit getMethod:@"c=Circleuser&a=exitCircle" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [SVProgressHUD showSuccessWithStatus:@"圈子退出成功"];
    [self senderNotificationIndex:@"exitCircle" userInfo:nil];
    [self.navigationController popViewControllerAnimated:YES];
        
    }];
        
        
        
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
    //圈子信息
 
    [self.parDic setObject:self.circle_id forKey:@"circle_id"];
    
    [LSHttpKit getMethod:@"c=Circle&a=circleInformation" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [circleInfoModel setKeyValues:responseObject[@"data"][@"circle_info"]];
    
     NSArray *arr  =  responseObject[@"data"][@"circleuser_list"];
     circleInfoModel.circlepost_list_count = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"circlepost_list_count"]];
     circleInfoModel.circleuser_list_count = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"circleuser_list_count"]];
     if (ISNOTNILARR(arr)) {
         for (NSDictionary *dic in arr) {
             LSUserModel *model = [LSUserModel objectWithKeyValues:dic];
             [userArr addObject:model];
         }
     }
    [self.tableView reloadData];
    }];

}

@end

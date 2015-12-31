//
//  LSPositionDetailVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/21.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSPositionDetailVC.h"
#import "LSPositionDetailCell.h"
#import "LSCompanyDetailVC.h"
#import "LSShareView.h"


@interface LSPositionDetailVC ()<UITableViewDelegate>
{
    UIButton *collectBtn;
}
@end

@implementation LSPositionDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"职位详情";
    //分享
    NSString *title1 = [NSString stringWithFormat:@"融易聘 - 国内首家专业金融人才招聘平台"];
    NSString *imageUrl = @"http://www.rongyp.com/themes/webhtm/images/logo_new.png";
    
    
    UIButton *btn = [UIButton buttonWithImage:@"btn_share_navbar" action:^(UIButton *btn) {
        LSShareView *share = [LSShareView shareView];
          WeakObj(share);
        share.btn1.actionBlock = ^(UIButton *btn)
        {
        [shareWeak cancle:^{
        //分享的
         NSDictionary *dic = @{@"tb_type": @"5",
                               @"data_id": self.positionModel.openings_id
                               };
        [LSHttpKit getMethod:@"c=Dynamic&a=addDynamic" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"分享成功!"];
        }];
            
        }];
            
        };
        
        
        share.btn2.actionBlock = ^(UIButton *btn)
        {   //微信朋友圈
            [shareWeak cancle:^{
               
                NSString *url = [NSString stringWithFormat:@"http://www.rongyp.com/positionview/id-%@/",self.positionModel.openings_id];
                [UMSocialWechatHandler setWXAppId:WXAPPKEY appSecret:WXAPPSECORT url:url];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
                [UMSocialData defaultData].extConfig.wechatTimelineData.title = title1;
                [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content: self.positionModel.tb_name image:data location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                    if (response.responseCode == UMSResponseCodeSuccess) {
                    }
                }];
            }];
        };
        share.btn3.actionBlock = ^(UIButton *btn)
        {   //微信好友
            [shareWeak cancle:^{
                [shareWeak cancle:^{
                    
                    NSString *url = [NSString stringWithFormat:@"http://www.rongyp.com/positionview/id-%@/",self.positionModel.openings_id];
                    [UMSocialWechatHandler setWXAppId:WXAPPKEY appSecret:WXAPPSECORT url:url];
                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
                    [UMSocialData defaultData].extConfig.wechatSessionData.title = title1;
                    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:self.positionModel.tb_name image:data location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                        if (response.responseCode == UMSResponseCodeSuccess) {
                        }
                    }];
                }];
            }];
        };
        
        [share show];
        
    }];
    btn.frame = CGRectMake(0, 0, 46, 36);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    //底部按钮
    collectBtn = [UIButton buttonWithTitle:@"收藏职位" titleColor:color_white BackgroundColor:color_bg_yellow action:^(UIButton *btn) {
      if(!btn.selected)
      {
          [LSHttpKit getMethod:@"c=Personal&a=addFavOpenings" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
              [SVProgressHUD showSuccessWithStatus:@"职位收藏成功!"];
              btn.selected  = YES;
          }];
      }else
      {
      
          [LSHttpKit getMethod:@"c=Personal&a=delFavOpenings" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
              [SVProgressHUD showSuccessWithStatus:@"取消收藏成功!"];
               btn.selected  = NO;
          }];
      }
    }];
    [collectBtn setImage:[UIImage imageNamed:@"icon_star_empty_white_undefined"] forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"icon_star_empty_white"] forState:UIControlStateSelected];
    [collectBtn setTitle:@"取消收藏" forState:UIControlStateSelected];
    
    [self.view addSubview:collectBtn];
    CGFloat w = SCREEN_WIDTH/2;
    collectBtn.frame = CGRectMake(0, SCREEN_HEIGHT-50-60, w-5, 50);
    [collectBtn setCornerRadius:3];
    
    UIButton *sendResumeBtn = [UIButton buttonWithTitle:@"投递简历" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
        [LSHttpKit getMethod:@"c=Personal&a=applyOpenings" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"简历投递成功"];
        }];
    }];
    [sendResumeBtn setImage:[UIImage imageNamed:@"icon_send_white"] forState:UIControlStateNormal];
    [self.view addSubview:sendResumeBtn];
    sendResumeBtn.frame = CGRectMake(w+5, SCREEN_HEIGHT-50-60, w-5, 50);
    [sendResumeBtn setCornerRadius:3];

}

-(void)httpRequest
{
    if(self.positionModel)
    {
        self.openings_id = self.positionModel.openings_id;
    }
    [self.parDic  setValue:self.openings_id forKey:@"openings_id"];
    [LSHttpKit getMethod:@"c=Company&a=JobInfo" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject[@"data"][0];
        if (ISNOTNILDIC(dic)) {
            if (self.positionModel) {
              [self.positionModel setKeyValues:dic];
            }else
            {
                self.positionModel = [LSPositionModel objectWithKeyValues:dic];
            }
       
        [self refreshData];
        [self.tableView reloadData];
            if ([self.positionModel.is_fav isEqualToString:@"1"]) {
                collectBtn.selected = YES;
            }else
            {
                 collectBtn.selected = NO;
            }
        }
    }];
}

-(void)refreshData
{
    [self.dataListArr removeAllObjects];
    NSArray *titles = [self.positionModel getRequireMesage];
    NSArray *WelfareArr = [self.positionModel getWelfare];
    NSString *description;
    if (ISNOTNILSTR(self.positionModel.tb_description)) {
        description = self.positionModel.tb_description;
    }else
    {
        description = @"暂无职位介绍";
    }
    if (self.positionModel) {
    [self.dataListArr addObject:@[self.positionModel,titles,@"职位描述",description,@"职位诱惑",WelfareArr]];
    }
}

-(void)creatContentView
{
    [self refreshData];
    [self creatTableView:@[@[@"LSPositionDetailCell",@"LSPositionRequire",@"LSPositionHeadCell",@"LSTextCell",@"LSPositionHeadCell",@"LSPositionTemptCell"]]];
    self.tableView.delegate  = self;
    self.tableView.edge(0,0,50,0);
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        switch (indexPath.row) {
            case 0:
                return 80;
                break;
            case 1:
                return 100;
                break;
            case 2:
                return 40;
                break;
            case 3:                
                return [self.positionModel.tb_description getStrH:SCREEN_WIDTH-20 font:14] +20;
                break;
            case 4:
                return 40;
                break;
            case 5:
                return 40;
                break;
            default:
                return 0;
                break;
        }
        
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    }];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        LSCompanyDetailVC *companyDetailVC  = [[LSCompanyDetailVC alloc] init];
        companyDetailVC.companyID = self.positionModel.member_id;
        [self.navigationController pushViewController:companyDetailVC animated:YES];
    }
}


@end

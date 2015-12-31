//
//  LSServiceMangeVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSServiceMangeVC.h"
#import "LSRechargeVC.h"

@interface LSServiceMangeVC ()

@end

@implementation LSServiceMangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *rechargeBtn = [UIButton buttonWithTitle:@"充值" titleColor:color_white BackgroundColor:color_clear action:^(UIButton *btn) {
        LSRechargeVC *rechargeVC = [[LSRechargeVC alloc] init];
        
        [self.navigationController pushViewController:rechargeVC animated:YES];
    }];
    [rechargeBtn setfont:14];
    rechargeBtn.frame = CGRectMake(0, 0, 40, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rechargeBtn];
}


-(void)httpRequest
{
   //服务管理

}


@end

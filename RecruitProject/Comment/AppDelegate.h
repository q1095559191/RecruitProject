//
//  AppDelegate.h
//  RenovationProject
//
//  Created by admin on 15/7/9.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSLoginVC.h"
#import "LSUserModel.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "LSMessageNumModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow            *window;
@property (nonatomic,assign)   BOOL               isCompany;
@property (nonatomic,strong)   LSUserModel        *user;
@property (nonatomic,strong)   LSMessageNumModel  *messageNum;
//登录
-(void)loginName:(NSString *)name passWord:(NSString *)password;
//登录页面
-(void)showLogin;
//主视图
-(void)showMain;

@end


//
//  AppDelegate.m
//  RenovationProject
//
//  Created by admin on 15/7/9.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomepageView.h"
#import "LSBaseTabBarVC.h"
#import "LSBaseNavigationVC.h"
#import "IQKeyboardManager.h"
#import "LSInitVC.h"
#import "WelcomepageView.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;                              //控制整个功能是否可以使用
    manager.shouldResignOnTouchOutside = YES;          //控制点击背景是否收起键盘
    manager.shouldToolbarUsesTextFieldTintColor = YES; //控制键盘上的工具条文字颜色是否用户自定义
    manager.enableAutoToolbar = NO;                    //控制是否显示键盘上的工具条
  
    //友盟
    [UMSocialData setAppKey:UMAPPKEY];

    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:WXAPPKEY appSecret:WXAPPSECORT url:@"www.baidu.com"];
    
     [self addObserverIndex:@"LSQequestFailure"];
    
    //初始化视图
    LSInitVC *initVC = [[LSInitVC alloc] init];
    self.window.rootViewController = initVC;
    [self.window makeKeyAndVisible];
  //  [self showLogin];
    return YES;
}

-(void)showLogin
{
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"firstLauch"])
    {
      [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLauch"];
      NSLog(@"第一次启动");
      WelcomepageView *WelcomeView = [[WelcomepageView alloc] init];
      self.window.rootViewController = WelcomeView;
      [self.window makeKeyAndVisible];
    }else
    {
        //创建登录视图
        LSLoginVC *loginC = [[LSLoginVC alloc] init];
        LSBaseNavigationVC *navVC = [[LSBaseNavigationVC alloc] initWithRootViewController:loginC];
        self.window.rootViewController = navVC;
        [self.window makeKeyAndVisible];
    }
}

-(void)showMain
{
        //创建主视图
        LSBaseTabBarVC *baseTabBarVC = [[LSBaseTabBarVC alloc] init];
        self.window.rootViewController = baseTabBarVC;
        [self.window makeKeyAndVisible];
}

-(void)notification:(NSNotification *)noti
{
    if ([noti.name isEqualToString:@"LSQequestFailure"]) {
     //请求失败
      NSString *url =  [NSString stringWithFormat:@"%@",noti.userInfo[@"URL"]];
      if ([url hasPrefix:[NSString stringWithFormat:@"%@?a=checkLogin&c=member",URL_Base]]) {
          [self showLogin];
        }
    }
}

-(void)loginName:(NSString *)name passWord:(NSString *)password
{
//    //个人
//    name       = @"18516633972";
//    password   = @"123456";
//
//    name     = @"beyondbobo@126.com";
//    password = @"jjjjjj";
//
////    //企业账户
//    name       = @"658@qq.com";
//    password   = @"jjjjjj";

   
    [LSHttpKit getMethod:nil   parameters:@{    @"name": name,
                                                @"passwd": password,
                                                @"c":@"member",
                                                @"a":@"checkLogin"
                                                } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                NSDictionary *userdic = responseObject[@"data"];
                                                LSUserModel *user = [LSUserModel objectWithKeyValues:userdic];
                                                    
                                                    APPDELEGETE.user = user;
                                                    [name saveDateWithKey:LSSAVE_USERNAME];
                                                    [password saveDateWithKey:LSSAVE_USERPASSWORD];
                                                    if([userdic[@"type"] integerValue] == 1)
                                                    {//公司账户
                                                        self.isCompany = YES;
                                                    }else
                                                    {    //个人账户
                                                         self.isCompany = NO;
                                                    }
                                                    [self showMain];
                                                }];
}


#pragma mark Nofitication
- (void)didReceiveNofitication:(NSNotification *)noti
{
   
    if ([noti.name isEqualToString:@"WelocomeNotification"]) {
        
        [self ShowBaseTabBar];
    }
    
    if ([noti.name isEqualToString:@"InitSuccessNotification"]) {
        if (![[NSUserDefaults standardUserDefaults]boolForKey:@"firstLauch"])
        {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLauch"];
            NSLog(@"第一次启动");
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLauch"];
        WelcomepageView *WelcomeView = [[WelcomepageView alloc] init];
        self.window.rootViewController = WelcomeView;
        WelcomeView.imageArr = @[@"123",@"123"];
        [self.window makeKeyAndVisible];    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNofitication:) name:@"WelocomeNotification" object:nil];
            
        }else
        {
              [self ShowBaseTabBar];
        }
    }
}

#pragma mark - 创建选项卡视图
-(void)ShowBaseTabBar
{
    //加载选项卡
//    UIStoryboard *storyVC = [UIStoryboard storyboardWithName:@"main" bundle:nil];
//    [storyVC instantiateViewControllerWithIdentifier:@""];
    
    LSBaseTabBarVC *BaseTabBar = [[LSBaseTabBarVC alloc] init];
    self.window.rootViewController = BaseTabBar;
    [self.window makeKeyAndVisible];
}


#pragma mark - 添加回调


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}
@end

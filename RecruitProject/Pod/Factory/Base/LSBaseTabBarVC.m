//
//  LSBaseTabBarVC.m
//  RenovationProject
//
//  Created by admin on 15/7/9.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSBaseTabBarVC.h"
#import "LSBaseNavigationVC.h"
#import "LSMineVC.h"
#import "LSPositionVC.h"
#import "LSContactsVC.h"
#import "LSFoundVC.h"
#import "LSMessageVC.h"
#import "LSCompanyVC.h"
#import "LSMessageNumModel.h"

@interface LSBaseTabBarVC ()
{
    NSTimer *timer;
}
@property(nonatomic ,strong) UIButton *selectedBtn;
@end

@implementation LSBaseTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //删除现有的tabBar
    APPDELEGETE.messageNum = [[LSMessageNumModel alloc] init];
    timer = [NSTimer scheduledTimerWithTimeInterval:LSNumber_Message target:self selector:@selector(httpRequest) userInfo:nil repeats:YES];
    
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:color_black,                                                                                                              NSForegroundColorAttributeName, nil]
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      color_main,
      NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    NSString *findStr;
    id            mineVC;
    NSString *findImage;
    NSString *findImage_selected;
    if (APPDELEGETE.isCompany) {
        findStr   = @"简历";
        findImage = @"icon_resume_normal";
        findImage_selected = @"icon_resume_selected";
        mineVC  = [[LSCompanyVC alloc]init];
    }else
    {
        findStr  = @"职位";
        findImage = @"icon_job_normal";
        findImage_selected = @"icon_job_selected";
        mineVC  = [[LSMineVC alloc]init];
    }
    
    NSArray *titles =  @[@"发现",findStr,@"消息",@"人脉",@"我"];
    NSArray *images =  @[@"icon_find_normal",findImage,@"icon_message_normal",@"icon_group_normal",@"icon_me_normal"];
    NSArray *images_selected =  @[@"icon_find_selected",findImage_selected,@"icon_message_selected",@"icon_group_selected",@"icon_me_selected"];
    
     LSFoundVC    *foundVC  = [[LSFoundVC alloc]init];
     LSPositionVC *position = [[LSPositionVC alloc]init];
     LSContactsVC *contacts = [[LSContactsVC alloc]init];
     LSMessageVC  *messageVC= [[LSMessageVC alloc] init];
    
   
    NSArray *vcs = @[foundVC,position,messageVC,contacts,mineVC];
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (int i = 0; i  < titles.count; i ++) {
        UIViewController *currentVC =  vcs[i];
        currentVC.tabBarItem.image = [UIImage imageNamed:images[i]];
        UIImage *selectImage =  [UIImage imageNamed:images_selected[i]];
        selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        currentVC.tabBarItem.selectedImage = selectImage;
        currentVC.tabBarItem.title =titles[i];
        
        currentVC.title = titles[i];
        [viewControllers addObject:[[LSBaseNavigationVC alloc] initWithRootViewController:currentVC]];
    }
    self.viewControllers = viewControllers;
    self.selectedIndex = 1;
    [self httpRequest];
}

-(void)httpRequest
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
   if (APPDELEGETE.isCompany) {
    [dic setObject:@"1" forKey:@"user_type"];
   }else
   {
    [dic setObject:@"0" forKey:@"user_type"];
   }
  
    [LSHttpKit getMethod:@"a=getMessageCount&c=Message" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
     NSDictionary *dic = responseObject[@"data"];
  
   
        APPDELEGETE.messageNum.p_num = dic[@"p_num"];
        APPDELEGETE.messageNum.c_num = dic[@"c_num"];
        APPDELEGETE.messageNum.s_num = dic[@"s_num"];
        if (!APPDELEGETE.isCompany) {
           APPDELEGETE.messageNum.messageNum = [NSString stringWithFormat:@"%ld",[APPDELEGETE.messageNum.p_num integerValue] + [APPDELEGETE.messageNum.s_num integerValue]];
        }else
        {
            APPDELEGETE.messageNum.messageNum = [NSString stringWithFormat:@"%ld",[APPDELEGETE.messageNum.c_num integerValue] + [APPDELEGETE.messageNum.s_num integerValue]];
        }
        
      if ([ APPDELEGETE.messageNum.messageNum integerValue] != 0) {
        [[self.tabBar.items objectAtIndex:2] setBadgeValue: APPDELEGETE.messageNum.messageNum];
       }else
       {
        [[self.tabBar.items objectAtIndex:2] setBadgeValue:nil];
       }
        LSBaseNavigationVC *nav = (LSBaseNavigationVC*)self.viewControllers[2];
        
        LSMessageVC *message = (LSMessageVC *)nav.topViewController;
        if([message isKindOfClass:[LSMessageVC class]])
        {
            [message refreshNum];
        }
   }];

}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [timer invalidate];
}

@end

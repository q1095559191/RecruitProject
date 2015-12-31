//
//  LSBaseNavigationVC.m
//  RenovationProject
//
//  Created by admin on 15/7/9.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSBaseNavigationVC.h"

@interface LSBaseNavigationVC ()

@end

@implementation LSBaseNavigationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置背景
    [self.navigationBar setBackgroundImage:[self GetImageFromColor:color_main] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置标题字体
    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
    [barAttrs setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [self.navigationBar setTitleTextAttributes:barAttrs];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (UIImage *)GetImageFromColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

-(void)HiderBavButton
{
    [_backButton setHidden:YES];
}

//拦截Push统一设置返回按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
  
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1)
    {
        viewController.navigationItem.leftBarButtonItem = [self creatBarButtonItem];
    }
}

// 自定义返回按钮
-(UIBarButtonItem *)creatBarButtonItem
{
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(0, 0, 24, 24);
    [_backButton setBackgroundImage:nil forState:UIControlStateNormal];
    [_backButton setImage:[UIImage imageNamed:@"icon_arrow_left_navbar"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(_backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    
    return barButton;
}

// 返回按钮事件
-(void)_backButtonAction
{
    [self popViewControllerAnimated:YES];
}

@end

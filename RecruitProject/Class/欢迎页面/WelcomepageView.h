//
//  WelcomepageView.h
//  ShoppingProject
//  领导页面    （第一次启动加载）
//  Created by zhangfan on 14-9-3.
//  Copyright (c) 2014年 GuanYisoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomepageView : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *Myscrollview;     //轮播
    
}

@property (nonatomic ,strong) NSArray *imageArr;         //轮播数组
@end



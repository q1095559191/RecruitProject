//
//  LSIndicatorView.m
//  AMY
//
//  Created by admin on 15/7/26.
//  Copyright (c) 2015年 ASYH. All rights reserved.
//

#import "LSIndicatorView.h"
#define LSIndicatorViewW 60
#define LSIndicatorViewH 40
@implementation LSIndicatorView
+(void)show
{
    LSIndicatorView *sharedView = [LSIndicatorView sharedView];
    sharedView.animationImages = [NSArray arrayWithObjects:
                                  
                                  [UIImage imageNamed:@"amy1.png"],
                                  
                                  [UIImage imageNamed:@"amy2.png"],
                                  
                                  [UIImage imageNamed:@"amy3.png"],
                                  
                                  [UIImage imageNamed:@"amy4.png"],
                                  
                                  [UIImage imageNamed:@"amy5.png"],
                                  nil];
    sharedView.animationDuration = 1.0;
    
    // repeat the annimation forever
    
    sharedView.animationRepeatCount = 0;
    [sharedView startAnimating];
    
    [[UIApplication sharedApplication].keyWindow addSubview:sharedView];
}

+(void)disMiss
{
    [[LSIndicatorView sharedView] stopAnimating];
    [[LSIndicatorView sharedView] removeFromSuperview];
    
}
+ (LSIndicatorView*)sharedView {
    static dispatch_once_t once;
    static LSIndicatorView *sharedView;
    dispatch_once(&once, ^ { sharedView = [[LSIndicatorView alloc] init]; });
    sharedView.center = [UIApplication sharedApplication].keyWindow.center;
    sharedView.bounds = CGRectMake(0, 0, LSIndicatorViewW, LSIndicatorViewH);

    return sharedView;
}


@end

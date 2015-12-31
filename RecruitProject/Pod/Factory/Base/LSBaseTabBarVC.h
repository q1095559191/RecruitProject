//
//  LSBaseTabBarVC.h
//  RenovationProject
//
//  Created by admin on 15/7/9.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSBaseTabBarVC : UITabBarController

@property (nonatomic ,strong) UIView *tabbarView;
@property (nonatomic ,strong) NSArray *titleArr;
@property (nonatomic ,strong) NSArray *imageArr;
@property (nonatomic ,strong) NSArray *selectedImageArr;


@end

//
//  UIButton+LSFactory.h
//  TestCode
//
//  Created by admin on 15/4/17.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LSActionBlock)(UIButton *btn);
@interface UIButton (LSFactory)

@property (nonatomic , copy) LSActionBlock actionBlock;

+(instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor*)color BackgroundColor:(UIColor *)bgcolor action:(LSActionBlock)action;

+(instancetype)buttonWithImage:(NSString *)image action:(LSActionBlock)action;

-(void)setfont:(CGFloat)fount;


@end

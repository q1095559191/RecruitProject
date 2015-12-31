//
//  UIView+LSFactory.m
//  ShoppingProject
//
//  Created by admin on 15/7/6.
//  Copyright (c) 2015年 GuanYisoft. All rights reserved.
//

#import "UIView+LSFactory.h"

@implementation UIView (LSFactory)
-(void)setCornerRadius:(CGFloat)Radius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = Radius;
}
@end

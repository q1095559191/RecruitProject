//
//  UILabel+LSFactory.h
//  TestCode
//
//  Created by admin on 15/4/17.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
LSLabelAlignment_left,
LSLabelAlignment_right,
LSLabelAlignment_center,

} LSLabelAlignment;

@interface UILabel (LSFactory)
+(instancetype)labelWithText:(NSString *)Text color:(UIColor *)color font:(CGFloat)font Alignment:(LSLabelAlignment)alignment;

-(void)settingSub:(NSString *)subStr color:(UIColor *)color font:(CGFloat) size;


@end

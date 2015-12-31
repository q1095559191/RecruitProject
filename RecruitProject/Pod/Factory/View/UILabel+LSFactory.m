//
//  UILabel+LSFactory.m
//  TestCode
//
//  Created by admin on 15/4/17.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "UILabel+LSFactory.h"

@implementation UILabel (LSFactory)
+(instancetype)labelWithText:(NSString *)Text color:(UIColor *)color font:(CGFloat)font Alignment:(LSLabelAlignment)alignment
{

    UILabel *label = [[UILabel alloc] init];
    label.text = Text;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];
    switch (alignment) {
        case LSLabelAlignment_left:
            label.textAlignment = NSTextAlignmentLeft;
            break;
        case LSLabelAlignment_right:
            label.textAlignment = NSTextAlignmentRight;
            break;
        case LSLabelAlignment_center:
            label.textAlignment = NSTextAlignmentCenter;
            break;
            
        default:
            break;
}
       return label;

}

-(void)settingSub:(NSString *)subStr color:(UIColor *)color font:(CGFloat)size
{
   self.attributedText  =  [self.text settingSub:subStr color:color font:size];
   
}
@end

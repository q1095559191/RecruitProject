//
//  UIButton+LSFactory.m
//  TestCode
//
//  Created by admin on 15/4/17.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "UIButton+LSFactory.h"
#import <objc/runtime.h>
char* const LSAction = "ASSOCIATION_LSAction";
@implementation UIButton (LSFactory)
//关联扩展属性
-(LSActionBlock)actionBlock
{
    LSActionBlock action =objc_getAssociatedObject(self,LSAction);
    
    return action;
}

-(void)setActionBlock:(LSActionBlock)actionBlock
{
    objc_setAssociatedObject(self,LSAction,actionBlock,OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+(instancetype)buttonWithImage:(NSString *)image action:(LSActionBlock)action
{
    UIButton * btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    if(action)
    {
    [btn addTarget:btn action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    }
    btn.actionBlock = action;
    return btn;
}

+(instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)color BackgroundColor:(UIColor *)bgcolor action:(LSActionBlock)action
{
    UIButton * btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setBackgroundColor:bgcolor];
    if(action)
    {
     [btn addTarget:btn action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    }
   
    btn.actionBlock = action;
    return btn;
}


-(void)action:(UIButton *)btn
{
    if (btn.actionBlock) {
        btn.actionBlock(btn);
    }

}


-(void)setfont:(CGFloat)fount
{
    self.titleLabel.font = [UIFont systemFontOfSize:fount];
}
@end

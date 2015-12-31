//
//  LSCoustomAlert.m
//  SizeClass
//
//  Created by liushuang on 15-1-19.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import "LSCoustomAlert.h"
#define sheetH self.height_sheetAction != 0?self.height_sheetAction:168
#define contentViewColor [UIColor whiteColor]
#define alertBgColor [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.4]


@implementation LSCoustomAlert

-(instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = alertBgColor;
        CGRect rect = [UIApplication sharedApplication].keyWindow.bounds;
        self.frame = rect;
        self.contentView = [[UIView alloc] init];
        self.isCancle = YES;

        //点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove:)];
        [self addGestureRecognizer:tap];
        
    }

    return self;
}

-(instancetype)initWithType:(alertType)type
{
    self = [self init];
    self.type = type;
    if (type == alertType_alert) {
        self.contentView.center = self.center;
        self.contentView.bounds = CGRectMake(0, 0, 200, 100);
        self.contentView.backgroundColor = contentViewColor;
        
    }
    else if(type == alertType_sheetAction)
    {
       CGRect rect = [UIApplication sharedApplication].keyWindow.bounds;
       self.contentView.center = self.center;
       self.contentView.frame = CGRectMake(0, rect.size.height-sheetH, rect.size.width, sheetH);
       self.contentView.backgroundColor = contentViewColor;
    
    }
        
        
    return self;
}



- (void)remove:(UITapGestureRecognizer *)sender
{
    if (self.isCancle == YES) {
          [self cancle:self.cancleBlock];
    }
  
    
    
}
-(void)cancle:(CancleBlock)completion
{
    self.cancleBlock = completion;
    if (self.type == alertType_sheetAction) {
   
    [UIView animateWithDuration:0.5 animations:^{
       self.contentView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.contentView removeFromSuperview];
        
        if (completion) {
            completion();
        }
    }];
   }else
   {
       [self removeFromSuperview];
       [self.contentView removeFromSuperview];
       if (completion) {
           completion();
       }
   }

}

-(void)show
{
    //动画
    CGRect rect = [UIApplication sharedApplication].keyWindow.bounds;
  if (self.type == alertType_sheetAction) {
    self.contentView.frame = CGRectMake(0, rect.size.height, self.contentView.frame.size.width, sheetH);
      NSLog(@"%f",sheetH);
    [UIView animateWithDuration:0.5 animations:^{
//  self.contentView.frame = CGRectMake(0, rect.size.height-sheetH, self.contentView.frame.size.width, );
        CGFloat  a = sheetH;
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -a);
    }];
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow addSubview:self.contentView];
    
}


@end

//
//  LSCoustomAlert.h
//  SizeClass
//
//  Created by liushuang on 15-1-19.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  enum
{   alertType_alert,
    alertType_sheetAction,
} alertType;
typedef void(^CancleBlock)();
@interface LSCoustomAlert : UIView

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) alertType type;
@property (nonatomic, copy)   CancleBlock cancleBlock;
@property (nonatomic, assign) BOOL isCancle;

@property (nonatomic, assign) CGFloat height_sheetAction;

-(void)show;
-(void)cancle:(CancleBlock)completion;
-(instancetype)initWithType:(alertType)type;


@end

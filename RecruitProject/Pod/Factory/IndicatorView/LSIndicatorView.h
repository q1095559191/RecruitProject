//
//  LSIndicatorView.h
//  AMY
//
//  Created by admin on 15/7/26.
//  Copyright (c) 2015年 ASYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSIndicatorView : UIImageView
@property(nonatomic,strong)UIImageView *imageView;
+ (LSIndicatorView*)sharedView;
+(void)show;
+(void)disMiss;
@end

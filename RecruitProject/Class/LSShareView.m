//
//  LSShareView.m
//  RecruitProject
//
//  Created by sliu on 15/10/22.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSShareView.h"

@implementation LSShareView

+(instancetype)shareView
{
    NSArray *images = @[@"icon_share_mydynamic",@"icon_share_weixingroup",@"icon_share_weixinfriend"];
    NSArray *titles = @[@"我的动态",@"微信朋友圈",@"微信好友"];
     CGFloat W  =  (SCREEN_WIDTH-40)/3;
    CGFloat left = (W - 80)/2;
    
    LSShareView *share = [[LSShareView alloc] initWithType:alertType_sheetAction];
    for (int i= 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithImage:images[i] action:^(UIButton *btn) {
            
        }];
        [share.contentView addSubview:btn];
        if (i == 0) {
            share.btn1 = btn;
        }else if (i == 1)
        {
           share.btn2 = btn;
        }else
        {   share.btn3 = btn;
        }
        
        UILabel *label = [UILabel labelWithText:titles[i] color:color_black font:14 Alignment:LSLabelAlignment_center];
         [share.contentView addSubview:label];
        btn.frame = CGRectMake(20+i*W+left , 15, 70, 70);
        label.frame = CGRectMake(20+i*W+left , 85, 70, 30);
    }
    
    UIButton *cancleBtn = [UIButton buttonWithTitle:@"取消" titleColor:color_black BackgroundColor:color_white action:^(UIButton *btn) {
        [share cancle:^{
            
        }];
    }];
    [share.contentView addSubview:cancleBtn];
    [cancleBtn setCornerRadius:3];
    cancleBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cancleBtn.layer.borderWidth = 1;
    cancleBtn.frame = CGRectMake(20+left, 120, 3*W-2*left, 30);
    share.cancleBtn = cancleBtn;
    return share;

}

@end

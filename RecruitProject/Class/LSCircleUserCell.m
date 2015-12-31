//
//  LSCircleUserCell.m
//  RecruitProject
//
//  Created by sliu on 15/10/20.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSCircleUserCell.h"

@implementation LSCircleUserCell

-(void)awakeFromNib
{
}

-(void)configCell:(id)data
{
    for (UIView *view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    if ([data isKindOfClass:[NSArray class]]) {
        NSArray *arr = (NSArray *)data;
        for (int i = 0; i < arr.count; i ++) {
            LSUserModel *model  = arr[i];
            UIImageView *image = [[UIImageView alloc] init];
            [self.contentView addSubview:image];
            [image setImageWithURL:[NSURL URLWithString:model.img]];
            [image setCornerRadius:3];
            UILabel *label = [UILabel labelWithText:model.truename color:color_black font:14 Alignment:LSLabelAlignment_center];
             [self.contentView addSubview:label];
            
            CGFloat a = i/5;
            CGFloat b = i%5;
            CGFloat W = SCREEN_WIDTH/5-20;
            image.frame = CGRectMake(10+b*(W+20), 5+a*(W+30), W, W);
            label.frame = CGRectMake(b*(W+20), 5+a*(W+30)+W, W+20, 30);
            
        }
    }
}

+(CGFloat)GetCellH:(id)data
{
    if ([data isKindOfClass:[NSArray class]]) {
        NSArray *arr = (NSArray *)data;
        CGFloat a = arr.count/5;
        CGFloat b = arr.count%5;
        if (b!=0) {
            a += 1;
        }
        CGFloat W = SCREEN_WIDTH/5-20;
        return  5+a*(W+30)+5;
    }

    return 44;
}

@end

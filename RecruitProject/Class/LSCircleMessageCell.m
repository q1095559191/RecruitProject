//
//  LSCircleMessageCell.m
//  RecruitProject
//
//  Created by sliu on 15/10/21.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSCircleMessageCell.h"

@implementation LSCircleMessageCell
-(void)awakeFromNib
{
   
    UILabel *label = [UILabel labelWithText:@"消息免打扰" color: color_black font:14 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:label];
    UILabel *label2 = [UILabel labelWithText:@"打开后,最新话题不会推送给您" color: color_title_Gray font:12 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:label2];
    label.frame = CGRectMake(10, 0, 200, 30);
    label2.frame = CGRectMake(10, 30, 200, 30);
    UISwitch *checkView = [[UISwitch alloc] init];
    checkView.frame = CGRectMake(0, 0, 50, 30);
    self.accessoryView = checkView;

    
}


@end

//
//  LSInterviewCell.m
//  RecruitProject
//
//  Created by sliu on 15/11/7.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSInterviewCell.h"


@implementation LSInterviewCell

-(void)awakeFromNib
{
    self.titleLB = [UILabel labelWithText:@"面试" color:color_black font:14 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:self.titleLB];
    
    self.titleLB.sizeBy(100,30);
    self.titleLB.originBy(10,-1);
    self.titleLB.centerY = self.contentView.centerY;
    
    self.detailLB = [UILabel labelWithText:@"面试" color:color_black font:14 Alignment:LSLabelAlignment_right];
    self.detailLB.numberOfLines = 0;
    [self.contentView addSubview: self.detailLB];
   
}

+(CGFloat)GetCellH:(id)data
{
    if ([data isKindOfClass:[LSBaseModel class]]) {
        LSBaseModel *modle = (LSBaseModel *)data;
      
        CGFloat W = SCREEN_WIDTH - 20 -100;
        CGFloat H = [modle.detailTile getStrH:W font:14]+10;
        if (H <= 40) {
            return 40;
        }

        return H;
    }
    
    return 44;
}

-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSBaseModel class]]) {
        LSBaseModel *modle = (LSBaseModel *)data;
        self.titleLB.text = modle.title;
        self.detailLB.text = modle.detailTile;
        CGFloat W = SCREEN_WIDTH - 20 -100;
        CGFloat H = [modle.detailTile getStrH:W font:14]+10;
        self.detailLB.frame = CGRectMake(110, 0, W, H);
    }

}

@end

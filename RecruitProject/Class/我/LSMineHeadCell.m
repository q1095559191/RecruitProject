//
//  LSMineHeadCell.m
//  RecruitProject
//
//  Created by sliu on 15/9/30.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSMineHeadCell.h"

@implementation LSMineHeadCell
-(void)awakeFromNib
{
 
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.headImage  = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headImage];
    self.headImage.frame = CGRectMake(SCREEN_WIDTH - 35 -80, 15, 60, 60);
    [self.headImage setCornerRadius:5];
    self.headImage.backgroundColor = [UIColor lightGrayColor];
    
    
    self.titleLB = [UILabel labelWithText:@"头像" color:color_title_Gray font:16 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:self.titleLB];
    
    self.titleLB.originBy(10,-1);
    self.titleLB.sizeBy(150,30);
    self.titleLB.centerY = self.contentView.centerY;
}


-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSBaseModel class]]) {
        LSBaseModel *model = (LSBaseModel *)data;
        self.titleLB.text = model.title;
        if (model.imageUrl) {
            [self.headImage setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
        }
        
    }
}

@end

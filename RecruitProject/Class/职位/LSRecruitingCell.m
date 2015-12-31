//
//  LSRecruitingCell.m
//  RecruitProject
//
//  Created by sliu on 15/10/10.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSRecruitingCell.h"

@implementation LSRecruitingCell
- (void)awakeFromNib {
    
    self.titleLB = [UILabel labelWithText:@"分口尽力 [北京]" color:color_black font:16 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview: self.titleLB];
    self.titleLB.edge(0,10,0,-1);
    self.titleLB.sizeBy(200,-1);
    
    self.detailLB = [UILabel labelWithText:@"10-20k" color:color_bg_yellow font:16 Alignment:LSLabelAlignment_right];
    [self.contentView addSubview: self.detailLB];
    self.detailLB.edge(0,-1,0,0);
    self.detailLB.sizeBy(100,-1);
    self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
}


-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSPositionModel class]]) {
        LSPositionModel *model = (LSPositionModel *)data;
        self.titleLB.text = [NSString stringWithFormat:@"%@  [%@]",model.tb_name,model.tb_city];
        [self.titleLB settingSub:[NSString stringWithFormat:@"[%@]",model.tb_city] color:color_title_Gray font:16];
    }
    
    
}

@end

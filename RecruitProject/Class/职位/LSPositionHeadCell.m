//
//  LSPositionHeadCell.m
//  RecruitProject
//
//  Created by sliu on 15/9/22.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSPositionHeadCell.h"

@implementation LSPositionHeadCell

- (void)awakeFromNib {
    // Initialization code
    self.headLB = [UILabel labelWithText:@"职位描述" color:color_title_Gray font:16 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:self.headLB];
    
    self.headLB.edge(0,10,0,0);
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        [self awakeFromNib];
    }
    return self;

}

-(void)configCell:(id)data
{
    self.headLB.text = data;
}

@end

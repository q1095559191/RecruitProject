//
//  LSBaseCell.m
//  RecruitProject
//
//  Created by sliu on 15/9/30.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSBaseCell.h"

@implementation LSBaseCell

- (void)awakeFromNib {
    // Initialization code
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end

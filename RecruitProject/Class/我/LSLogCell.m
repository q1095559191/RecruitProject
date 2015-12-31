//
//  LSLogCell.m
//  RecruitProject
//
//  Created by sliu on 15/11/10.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSLogCell.h"
#import "LSLogModel.h"
@implementation LSLogCell

-(void)awakeFromNib
{
    _label1 = [UILabel labelWithText:nil color:color_black font:14 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_label1];
    _label1.frame = CGRectMake(10, 5, SCREEN_WIDTH-20, 30);
    
    _label2 = [UILabel labelWithText:nil color:color_title_Gray font:12 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_label2];
    _label2.frame = CGRectMake(10, 30, SCREEN_WIDTH-20, 20);
    
    _label3 = [UILabel labelWithText:nil color:color_black font:12 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_label3];
    _label3.frame = CGRectMake(10, 50, SCREEN_WIDTH-20, 20);

}

-(void)configCell:(id)data
{

    LSLogModel *model = (LSLogModel *)data;
    _label1.text = model.type;
    _label2.text = [NSString stringWithFormat:@"业务时间:%@",[NSObject getTime:model.time]];
    _label3.text = model.log;

}

@end

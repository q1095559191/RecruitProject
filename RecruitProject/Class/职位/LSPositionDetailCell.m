//
//  LSPositionDetailCell.m
//  RecruitProject
//
//  Created by sliu on 15/9/22.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSPositionDetailCell.h"

@implementation LSPositionDetailCell

- (void)awakeFromNib {
    // Initialization code
    _headImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImage];
    [_headImage setCornerRadius:5];
    _headImage.backgroundColor = [UIColor lightGrayColor];
    
    _titleLB = [UILabel labelWithText:nil color:color_black font:16 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_titleLB];
    
    _detailLB = [UILabel labelWithText:@"你们的职位相似" color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_detailLB];
    
    _headImage.sizeBy(60,60);
    _headImage.originBy(10,10);
    
    _titleLB.originBy(80,10);
    _titleLB.sizeBy(200,40);
    
     _detailLB.originBy(80,40);
    _detailLB.sizeBy(200,30);
   
    
    
}


-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSPositionModel class]]) {
        LSPositionModel *model = (LSPositionModel*)data;
        [_headImage setImageWithURL:[NSURL URLWithString:model.com_img] placeholderImage:nil];
        _titleLB.text = model.tb_name;      
        _detailLB.text = model.com_name;
    }

    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    return self;
}

@end

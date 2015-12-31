//
//  LSCircleListCell.m
//  RecruitProject
//
//  Created by sliu on 15/10/13.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSCircleListCell.h"

@implementation LSCircleListCell
- (void)awakeFromNib {
    // Initialization code
    
    _headImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImage];
    [_headImage setCornerRadius:5];
    _headImage.backgroundColor = [UIColor lightGrayColor];
    
    _titleLB = [UILabel labelWithText:nil color:color_black font:16 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_titleLB];
    
    _detailLB = [UILabel labelWithText:@"你们的职位相似" color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
    _detailLB.numberOfLines = 0;
    [self.contentView addSubview:_detailLB];
    
    
    _headImage.sizeBy(50,50);
    _headImage.originBy(10,10);
    
    _titleLB.originBy(70,5);
    _titleLB.sizeBy(200,30);
    
    
    _detailLB.sizeBy(SCREEN_WIDTH-70-10,50);
    _detailLB.originBy(70,25);
    
}

-(void)configCell:(id)data
{
    if (ISKINDOFCLASS(data, LSCircleModel)) {
        LSCircleModel *model = (LSCircleModel *)data;
        [_headImage setImageWithURL:[NSURL URLWithString:model.tb_img]];
        NSString *name = model.tb_name;
        if ([model.tb_audit isEqualToString:@"0"]) {
            name = [NSString stringWithFormat:@"%@(审核中)",model.tb_name];
        }
         _titleLB.text = name;
        _detailLB.text = model.tb_info;
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

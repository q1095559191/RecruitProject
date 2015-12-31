//
//  LSAttentionCell.m
//  RecruitProject
//
//  Created by sliu on 15/9/24.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSAttentionCell.h"

@implementation LSAttentionCell

- (void)awakeFromNib {
    // Initialization code
    _headImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImage];
    [_headImage setCornerRadius:5];
    _headImage.backgroundColor = [UIColor lightGrayColor];
    
    _titleLB = [UILabel labelWithText:nil color:color_black font:15 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_titleLB];
    
    _detailLB = [UILabel labelWithText:nil color:color_title_Gray font:11 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_detailLB];
    
    _headImage.sizeBy(44,44);
    _headImage.originBy(10,8);
    
    _titleLB.originBy(64,5);
    _titleLB.sizeBy(SCREEN_WIDTH-64-10,30);
    
    
    _detailLB.sizeBy(SCREEN_WIDTH-64-10,20);
    _detailLB.originBy(64,30);
    
    
 
}

-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSAttentionModel class]]) {
        LSAttentionModel *model = (LSAttentionModel *)data;
       
        NSString *name= model.name;
        if (model.tb_jobtype_two) {
            name = [NSString stringWithFormat:@"%@%@",name,model.tb_jobtype_two];
        }
        _titleLB.text = name;
         [_titleLB settingSub:[NSString stringWithFormat:@"%@",model.tb_jobtype_two] color:color_title_Gray font:16];
        
        [_headImage setImageWithURL:[NSURL URLWithString:model.image]];
    }
 
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
}

@end

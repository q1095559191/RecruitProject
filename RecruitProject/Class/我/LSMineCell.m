//
//  LSMineCell.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSMineCell.h"

@implementation LSMineCell

- (void)awakeFromNib {
    // Initialization code
    _headImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImage];
    [_headImage setCornerRadius:5];
    _headImage.backgroundColor = [UIColor lightGrayColor];
    
    _titleLB = [UILabel labelWithText:nil color:color_black font:16 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_titleLB];
    
    _detailLB = [UILabel labelWithText:nil color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_detailLB];
    
    //  90
    
    _headImage.sizeBy(60,60);
    _headImage.originBy(10,15);
    
    _titleLB.originBy(80,15);
    _titleLB.sizeBy(250,30);
    
    
    _detailLB.sizeBy(250,30);
    _detailLB.originBy(80,45);
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
}
-(void)configCell:(id)data
{
    if ([APPDELEGETE.user.type integerValue] == 1) {
      //公司名称
        //个人签名
        if ([data isKindOfClass:[LSTipModel class]]) {
            LSTipModel *model = (LSTipModel *)data;
            [_headImage setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
            _titleLB.text = model.truename;
            if(ISNILSTR(model.amount))
            {
              model.amount = @"0.00";
            }
            _detailLB.text = [NSString stringWithFormat:@"账户余额 %@ 元",model.amount];
            [_detailLB settingSub:model.amount  color:color_main font:12];
           
        }
        
       
      
    }else
    {   //个人签名
        if ([data isKindOfClass:[LSTipModel class]]) {
            LSTipModel *model = (LSTipModel *)data;
            [_headImage setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
            _titleLB.text = model.truename;
        }
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

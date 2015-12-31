//
//  LSContactsCell.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSContactsCell.h"

@implementation LSContactsCell

- (void)awakeFromNib {
    // Initialization code
    
    _headImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImage];
    [_headImage setCornerRadius:5];
    _headImage.backgroundColor = color_bg_yellow;
    
    _titleLB = [UILabel labelWithText:nil color:color_black font:14 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_titleLB];
    
    _messageNumLB = [UILabel labelWithText:nil color:color_title_Gray font:14 Alignment:LSLabelAlignment_right];
    [self.contentView addSubview:_messageNumLB];
    
    _headImage.sizeBy(30,30);
    _headImage.originBy(15,10);
    
    _titleLB.sizeBy(200,30);
    _titleLB.originBy(60,10);
    
    _messageNumLB.frame = CGRectMake(SCREEN_WIDTH-100-35, 10, 100, 30);
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    _tipLB = [UILabel labelWithText:nil color:color_white font:12 Alignment:LSLabelAlignment_center];
    [self.contentView addSubview:_tipLB];
    _tipLB.backgroundColor = color_bg_yellow;
    
    
}

-(void)configCell:(id)data
{
    if (ISKINDOFCLASS(data, LSContactsModel)) {
        LSContactsModel *model = (LSContactsModel *)data;
        _titleLB.text = model.title;
        _headImage.image = [UIImage imageNamed:model.image];
    }
    
    if (ISKINDOFCLASS(data, LSBaseModel)) {
        LSBaseModel *model = (LSBaseModel *)data;
        _titleLB.text = model.title;
        _headImage.image = [UIImage imageNamed:model.imageUrl];
        
        //提示
        if ([model.index integerValue] == 0) {
            _tipLB.hidden = YES;
        }else
        {
            _tipLB.hidden = NO;
            CGFloat X = [model.title getStrW:30 font:14] + 60+5;
            _tipLB.frame = CGRectMake(X, 18, 8, 8);
            [_tipLB setCornerRadius:4];
            model.detailTile = [NSString stringWithFormat:@"%@",model.index];
            
        }
        
        if (model.detailTile) {
            if ([model.detailTile integerValue] != 0) {
                _messageNumLB.text = model.detailTile;
            }
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

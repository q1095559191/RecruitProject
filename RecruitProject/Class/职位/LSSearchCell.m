//
//  LSSearchCell.m
//  RecruitProject
//
//  Created by sliu on 15/10/10.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSSearchCell.h"

@implementation LSSearchCell
- (void)awakeFromNib {
    // Initialization code
    _titleLB = [UILabel labelWithText:@"张三" color:color_title_Gray font:16 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_titleLB];
    _titleLB.originBy(10,5);
    _titleLB.sizeBy(150,30);
    
    
    _detailLB = [UILabel labelWithText:@"未填写" color:color_black font:14 Alignment:LSLabelAlignment_right];
    [self.contentView addSubview: _detailLB ];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    _detailLB.frame = CGRectMake(SCREEN_WIDTH -35 -200, 5, 200, 30);
    
}

-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSBaseModel class]]) {
        LSBaseModel *model = (LSBaseModel *)data;
         _titleLB.text = model.title;
        if (model.detailTile) {
            _detailLB.text = model.detailTile;
            
            if ([model.detailTile isEqualToString:@"无"]) {
                 _detailLB.text =@"未填写";
            }
        }else
        {
              _detailLB.text =@"未填写";
        }
    }
   
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
    }
    return self;
}
@end

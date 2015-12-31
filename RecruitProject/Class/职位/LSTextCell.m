//
//  LSTextCell.m
//  RecruitProject
//
//  Created by sliu on 15/10/9.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSTextCell.h"

@implementation LSTextCell
- (void)awakeFromNib {
    // Initialization code
    _textLB = [UILabel labelWithText:@"qdncanmxlknxama;mama,pcaoillmxdaldldlaNdknldnLKndlKD;" color:color_black font:14 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_textLB];
    _textLB.numberOfLines = 0;
  
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    return self;
}

+(CGFloat)GetCellH:(id)data
{
 if (ISNOTNILSTR(data)) {
     CGFloat h = [data getStrH:SCREEN_WIDTH-20 font:14];
     return h+20;
 }
    return 100;
}

-(void)configCell:(id)data
{NSString *str;
    
    if (ISNOTNILSTR(data)) {
        str = data;
    }
    if ([data isKindOfClass:[LSCircleInfoModel class]]) {
        LSCircleInfoModel *model = (LSCircleInfoModel *)data;
        if (ISNILSTR(model.tb_notice)) {
            str = @"无";
        }else
        {
          str =   model.tb_notice;
        }
      
    }
    _textLB.text = str;
    CGFloat h = [_textLB.text getStrH:SCREEN_WIDTH-20 font:14];
    _textLB.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, h);
    
}

@end

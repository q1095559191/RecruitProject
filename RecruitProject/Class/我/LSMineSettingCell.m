//
//  LSMineSettingCell.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSMineSettingCell.h"

@implementation LSMineSettingCell

- (void)awakeFromNib {
    // Initialization code
    _titleLB = [UILabel labelWithText:@"张三" color:color_title_Gray font:16 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_titleLB];
    _titleLB.originBy(10,-1);
    _titleLB.sizeBy(150,30);
    _titleLB.centerY = self.contentView.centerY;
    
    
    _detailTF = [[UITextField alloc] init];
    _detailTF.font = [UIFont systemFontOfSize:14];
    _detailTF.textAlignment = NSTextAlignmentRight;
    _detailTF.delegate = self;
    [self.contentView addSubview: _detailTF ];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    _detailTF.originBy(100,-1);
    _detailTF.sizeBy(200,30);
    _detailTF.centerY = self.contentView.centerY;
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.modle.detailTile  =  textField.text;
}

-(void)configCell:(id)data
{
   
    if([data isKindOfClass:[LSBaseModel class]])
    {
        LSBaseModel *model = (LSBaseModel *)data;
        _titleLB.text = model.title;
        _detailTF.text = model.detailTile;
        self.modle = data;
        _detailTF.placeholder = @"未填写";
        if ([model.type isEqualToString:@"1"]) {
            //选择的
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
             [_detailTF resetConstraint:0 constant:SCREEN_WIDTH -35 -200];
            _detailTF.enabled = NO;
            
        }else if ([model.type isEqualToString:@"3"])
        {
            [_detailTF resetConstraint:0 constant:SCREEN_WIDTH -200 -15];
            self.accessoryType = UITableViewCellAccessoryNone;
            _detailTF.enabled = YES;
            _detailTF.keyboardType = UIKeyboardTypePhonePad;
        
        }
      
        else
        {   //没有箭头的
            [_detailTF resetConstraint:0 constant:SCREEN_WIDTH -200 -15];
            self.accessoryType = UITableViewCellAccessoryNone;
            _detailTF.enabled = YES;
        }
    }
   
}
-(void)setDetailLBText:(NSString *)str
{
    if (str && ![str isEqualToString:@""]) {
        _detailTF.text = str;
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

//
//  LSPositionApplyCell.m
//  RecruitProject
//
//  Created by sliu on 15/11/6.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSPositionApplyCell.h"

@implementation LSPositionApplyCell

- (void)awakeFromNib {
    // Initialization code
    
   
    
    self.positionLB = [UILabel labelWithText:@"风控经理" color:color_black font:16 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:self.positionLB];
    
    self.timeLB = [UILabel labelWithText:@"上海 / 2015-08-20" color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:self.timeLB];
    
    self.gongsiLB = [UILabel labelWithText:@"广发证劵有限公司" color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:self.gongsiLB];
    
    self.priceLB = [UILabel labelWithText:nil color:color_bg_yellow font:14 Alignment:LSLabelAlignment_right];
    [self.contentView addSubview:self.priceLB];
    
    _stateBtn = [UIButton buttonWithTitle:@"全部" titleColor:color_white BackgroundColor:[UIColor orangeColor] action:^(UIButton *btn) {
      
    }];
    [_stateBtn setCornerRadius:3];
    [_stateBtn setfont:14];
    [_stateBtn setImage:[UIImage imageNamed:@"icon_angle_up_white"] forState:UIControlStateNormal];
    
    [_stateBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 45, 0, 0)];
    [_stateBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [self.contentView addSubview:_stateBtn];
    
    self.positionLB.frame = CGRectMake(10, 0, 250, 30);
    self.timeLB.frame = CGRectMake(10, 30, 250, 20);
    self.gongsiLB.frame = CGRectMake(10, 55, 250, 25);
    self.priceLB.frame = CGRectMake(SCREEN_WIDTH-100-35, 25, 100, 30);
    _stateBtn.frame = CGRectMake(SCREEN_WIDTH-60-10, 40, 60, 25);
    
    self.accessoryType  = UITableViewCellAccessoryNone;
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSPositionModel class]]) {
        
        LSPositionModel *model = (LSPositionModel*)data;
      
        if([model.fromType isEqualToString:@"9"])
        {
           _timeLB.text = [NSString stringWithFormat:@"%@/%@",model.tb_city,[NSObject getTime:model.tb_uptime]];
            _priceLB.text = [NSObject getInfoDetail:model.tb_salary];
           
            NSString *stateStr = nil;
            UIColor  *stateColor = nil;
            if ([model.tb_read isEqualToString:@"0"]) {
              //未读
              stateStr = @"未读";
              stateColor = RGBCOLOR(50, 107, 150);

            }else
            {
             if ([model.tb_audit isEqualToString:@"1"])
             {
                 stateStr = @"已邀请";
                 stateColor = color_main;
             }else
             {
                 stateStr = @"未邀请";
                 stateColor = RGBCOLOR(50, 107, 150);
             }
            }
            self.gongsiLB.text = stateStr;
            self.gongsiLB.layer.borderWidth = 0.5;
            self.gongsiLB.layer.borderColor = stateColor.CGColor;
            self.gongsiLB.textColor = stateColor;
            
            if (ISNILSTR(model.tb_position)) {
               _positionLB.text = model.truename;
            }else
            {
               _positionLB.text = [NSString stringWithFormat:@"%@[%@]",model.truename,model.tb_position];
              [_positionLB settingSub:[NSString stringWithFormat:@"[%@]",model.tb_position] color:color_title_Gray font:14];
            }
            CGFloat TitleW = [ _positionLB.text getStrW:30 font:14]+10;
            self.gongsiLB.frame = CGRectMake(TitleW+10, 8, 35, 16);
            self.gongsiLB.font = [UIFont systemFontOfSize:10];
            [self.gongsiLB setCornerRadius:3];
            self.gongsiLB.textAlignment = NSTextAlignmentCenter;
            
            self.stateBtn.hidden = YES;
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.priceLB.frame = CGRectMake(SCREEN_WIDTH-100-35, 15, 100, 30);

        }else
        {
            self.priceLB.frame = CGRectMake(SCREEN_WIDTH-100-15, 10, 100, 30);
            _positionLB.text = model.tb_name;
            _timeLB.text = [NSString stringWithFormat:@"%@/%@",model.tb_city,[NSObject getTime:model.tb_uptime]];
            _priceLB.text = [NSObject getInfoDetail:model.tb_salary];
            _gongsiLB.text = model.truename;
            if (ISNILSTR(model.truename)) {
                _gongsiLB.text = model.turename;
            }
            if ([model.tb_read isEqualToString:@"0"]) {
                //未读
                [_stateBtn setImage:[UIImage imageNamed:@"icon_angle_up_gray"] forState:UIControlStateNormal];
                [_stateBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                _stateBtn.backgroundColor = [UIColor lightGrayColor];
                [_stateBtn setTitle:@"未读" forState:UIControlStateNormal];
                
            }else
            {
                [_stateBtn setImage:[UIImage imageNamed:@"icon_angle_up_white"] forState:UIControlStateNormal];
                [_stateBtn setTitleColor:color_white forState:UIControlStateNormal];
                _stateBtn.backgroundColor = color_bg_yellow;
                [_stateBtn setTitle:@"已读" forState:UIControlStateNormal];
            }
        }
}
   
}

@end

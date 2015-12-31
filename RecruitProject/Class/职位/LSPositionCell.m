//
//  LSPositionCell.m
//  RecruitProject
//
//  Created by sliu on 15/9/21.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSPositionCell.h"

@implementation LSPositionCell

- (void)awakeFromNib {
    // Initialization code
    
    self.positionImage = [[UIImageView alloc] init];
    [self.positionImage setCornerRadius:3];
    self.positionImage.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:  self.positionImage];
   
    
    self.positionLB = [UILabel labelWithText:@"风控经理" color:color_black font:16 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:self.positionLB];
    
    self.timeLB = [UILabel labelWithText:@"上海 / 2015-08-20" color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:self.timeLB];
    
    self.gongsiLB = [UILabel labelWithText:@"广发证劵有限公司" color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:self.gongsiLB];
    
    self.priceLB = [UILabel labelWithText:nil color:color_bg_yellow font:14 Alignment:LSLabelAlignment_right];
    [self.contentView addSubview:self.priceLB];
   
    self.positionImage.frame = CGRectMake(10, 10, 50, 50);
    self.positionLB.frame    = CGRectMake(70, 0, 250, 30);
    self.timeLB.frame        = CGRectMake(70, 30, 200, 25);
    self.gongsiLB.frame      = CGRectMake(70, 55, 250, 25);
    self.priceLB.frame       = CGRectMake(SCREEN_WIDTH-100-35, 25, 100, 30);
    
    self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
   
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
  return self;
}


-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSPositionModel class]]) {
        LSPositionModel *model = (LSPositionModel*)data;
        //1:发现.职位  2:发现.简历  3:职位  4:简历
        if ([model.fromType integerValue] == 1) {
            //发现.职位
            [_positionImage setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
            self.accessoryType  = UITableViewCellAccessoryNone;
            self.priceLB.frame = CGRectMake(SCREEN_WIDTH-100-10, 25, 100, 30);
            _positionLB.text = model.tb_name;
            _timeLB.text = [NSString stringWithFormat:@"%@/%@",model.tb_city,[NSObject getTime:model.tb_uptime]];
            _gongsiLB.text = model.turename;
            _priceLB.text = [NSObject getInfoDetail:model.tb_salary];
            
        }else if ([model.fromType integerValue] == 2)
        {  //2:发现.简历
            [_positionImage setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
            self.accessoryType  = UITableViewCellAccessoryNone;
            self.priceLB.frame = CGRectMake(SCREEN_WIDTH-100-10, 15, 100, 30);
            [_gongsiLB removeFromSuperview];
             self.priceLB.text = [NSObject getInfoDetail:model.tb_salary];
            
            NSString *name ;
            if (ISNOTNILSTR(model.tb_position) ) {
                name = [NSString stringWithFormat:@"%@[%@]",model.truename,model.tb_position];
            }else
            {
                 name = [NSString stringWithFormat:@"%@",model.truename];
            }
             _positionLB.text = name;
            [_positionLB settingSub:[NSString stringWithFormat:@"[%@]",model.tb_position] color:color_title_Gray font:14];
            
            NSString *worknum = [NSString stringWithFormat:@"%@",model.tb_workyear];
            if (!ISNOTNILSTR(model.tb_workyear)) {
                worknum = [NSString stringWithFormat:@"0年"];
            }
            _timeLB.text = [NSString stringWithFormat:@"%@/%@/%@",model.tb_city,worknum,[NSObject getTime:model.tb_edittime]];
            [_gongsiLB removeFromSuperview];
            
        }else if ([model.fromType integerValue] == 3)
        {   //职位 没有头像
            [self.positionImage removeFromSuperview];
            CGFloat left = 10;
            self.positionLB.frame    = CGRectMake(left, 0, 250, 30);
            self.timeLB.frame        = CGRectMake(left, 30, 200, 25);
            self.gongsiLB.frame      = CGRectMake(left, 55, 250, 25);
            self.priceLB.frame       = CGRectMake(SCREEN_WIDTH-100-35, 25, 100, 30);
            self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
            _positionLB.text = model.tb_name;
            _timeLB.text = [NSString stringWithFormat:@"%@/%@",model.tb_city,[NSObject getTime:model.tb_uptime]];
            _priceLB.text = [NSObject getInfoDetail:model.tb_salary];
            _gongsiLB.text = model.truename;
            if (ISNILSTR(model.truename)) {
                _gongsiLB.text = model.turename;
            }
            
        }else if ([model.fromType integerValue] == 4)
        {   //简历
            [_positionImage setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
            self.priceLB.frame = CGRectMake(SCREEN_WIDTH-100-35, 15, 100, 30);
            self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
            [_gongsiLB removeFromSuperview];
           
            NSString *name ;
            if (ISNOTNILSTR(model.tb_position)) {
                name = [NSString stringWithFormat:@"%@[%@]",model.truename,model.tb_position];
            }else
            {
                name = [NSString stringWithFormat:@"%@",model.truename];
            }
            _positionLB.text = name;
            [_positionLB settingSub:[NSString stringWithFormat:@"[%@]",model.tb_position] color:color_title_Gray font:14];
            NSString *price  = [NSObject getInfoDetail:model.tb_salary];
            if([price isEqualToString:@"未填写"])
            {
            self.priceLB.text = @"面议";
            self.priceLB.hidden = YES;
            }else
            {
            self.priceLB.hidden = NO;
            self.priceLB.text = [NSObject getInfoDetail:model.tb_salary];
            }
            
            NSString *worknum = [NSString stringWithFormat:@"%@",model.tb_workyear];
            if (!ISNOTNILSTR(model.tb_workyear)) {
                worknum = [NSString stringWithFormat:@"0年"];
            }
            _timeLB.text = [NSString stringWithFormat:@"%@/%@/%@",model.tb_city,worknum,[NSObject getTime:model.tb_edittime]];
            [_gongsiLB removeFromSuperview];
            
        }else if ([model.fromType integerValue] == 5)
        {   //简历
            [_positionImage setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
            self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
            self.priceLB.frame = CGRectMake(SCREEN_WIDTH-100-10-35, 25, 100, 30);
            _positionLB.text = model.tb_name;
            _timeLB.text = [NSString stringWithFormat:@"%@/%@",model.tb_city,[NSObject getTime:model.tb_uptime]];
            _gongsiLB.text = model.turename;
            _priceLB.text = [NSObject getInfoDetail:model.tb_salary];
            if (model.isSelected) {
                self.positionImage.image = [UIImage imageNamed:@"checkbox_selected"];
            }else
            {
                self.positionImage.image = [UIImage imageNamed:@"checkbox_normal"];
            }
          
            self.positionImage.frame = CGRectMake(10,(70-25)/2, 25, 25);
            self.positionLB.frame    = CGRectMake(45, 0, 250, 30);
            self.timeLB.frame        = CGRectMake(45, 30, 200, 25);
            self.gongsiLB.frame      = CGRectMake(45, 55, 250, 25);
            
        }
        else if ([model.fromType integerValue] == 6)
        {   //简历
            self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
            self.priceLB.frame = CGRectMake(SCREEN_WIDTH-100-10-35, 25, 100, 30);
            _positionLB.text = model.truename;
            _timeLB.textColor = color_black;
            _timeLB.text = [NSString stringWithFormat:@"再招职位: %@个",model.jobs];
            [_timeLB settingSub:[NSString stringWithFormat:@"%@",model.jobs] color:color_main font:14];
            _gongsiLB.text = [NSString stringWithFormat:@"%@ 查看了您的简历",[NSObject getDetailTime:model.business_time]];
            if (model.isSelected) {
                self.positionImage.image = [UIImage imageNamed:@"checkbox_selected"];
            }else
            {
                self.positionImage.image = [UIImage imageNamed:@"checkbox_normal"];
            }
            
           self.positionImage.frame = CGRectMake(10, (70-25)/2, 25, 25);
            self.positionLB.frame    = CGRectMake(45, 0, 250, 30);
            self.timeLB.frame        = CGRectMake(45, 30, 200, 25);
            self.gongsiLB.frame      = CGRectMake(45, 55, 250, 25);
            
        } else if ([model.fromType integerValue] == 7)
        {
            //我发布的职位
            self.accessoryType  = UITableViewCellAccessoryNone;
            _positionLB.text = model.tb_name;
            _timeLB.text = [NSString stringWithFormat:@"%@/%@",model.tb_city,[NSObject getTime:model.tb_uptime]];
            _gongsiLB.text = model.turename;
            CGFloat W = [model.tb_name getStrW:30 font:16]+5;
            //已审核、未审核
            self.priceLB.frame = CGRectMake(20+25+W, 8, 40, 16);
            self.priceLB.font = [UIFont systemFontOfSize:10];
            [self.priceLB setCornerRadius:3];
            self.priceLB.layer.borderWidth = 1;
            self.priceLB.textAlignment = NSTextAlignmentCenter;
            if([model.tb_audit isEqualToString:@"1"])
            { //已审核
            
               self.priceLB.text = @"已审核";
               self.priceLB.layer.borderColor = RGBCOLOR(13, 67, 125).CGColor;
               self.priceLB.textColor = RGBCOLOR(13, 67, 125);
              
                
            }else
            {    //未审核
                self.priceLB.text = @"未审核";
                self.priceLB.layer.borderColor =color_main.CGColor;
                self.priceLB.textColor = color_main;
            }
            if (model.isSelected) {
                self.positionImage.image = [UIImage imageNamed:@"checkbox_selected"];
            }else
            {
                self.positionImage.image = [UIImage imageNamed:@"checkbox_normal"];
            }
          
            self.positionImage.userInteractionEnabled = YES;
            [self.positionImage bk_whenTapped:^{
                model.isSelected = !model.isSelected;
                if (model.isSelected) {
                    self.positionImage.image = [UIImage imageNamed:@"checkbox_selected"];
                }else
                {
                    self.positionImage.image = [UIImage imageNamed:@"checkbox_normal"];
                }
            }];
            
            self.positionImage.frame = CGRectMake(10, (70-35)/2, 25, 25);
            self.positionLB.frame    = CGRectMake(45, 0, 250, 30);
            self.timeLB.frame        = CGRectMake(45, 30, 200, 25);
            self.gongsiLB.frame      = CGRectMake(45, 55, 250, 25);
            
            
        
        } else if ([model.fromType integerValue] == 8)
        {
            //我收藏、我看过的简历
            self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
            [_gongsiLB removeFromSuperview];
            
            NSString *name ;
            if (ISNOTNILSTR(model.tb_position)) {
                name = [NSString stringWithFormat:@"%@[%@]",model.truename,model.tb_position];
            }else
            {
                name = [NSString stringWithFormat:@"%@",model.truename];
            }
            _positionLB.text = name;
            [_positionLB settingSub:[NSString stringWithFormat:@"[%@]",model.tb_position] color:color_title_Gray font:14];
           
            NSString *worknum = [NSString stringWithFormat:@"%@",model.tb_workyear];
            if (!ISNOTNILSTR(model.tb_workyear)) {
                worknum = [NSString stringWithFormat:@"0年"];
            }
            _timeLB.text = [NSString stringWithFormat:@"%@/%@/%@",model.tb_city,worknum,[NSObject getTime:model.tb_edittime]];
            
            if (model.isSelected) {
                self.positionImage.image = [UIImage imageNamed:@"checkbox_selected"];
            }else
            {
                self.positionImage.image = [UIImage imageNamed:@"checkbox_normal"];
            }
            
            self.positionImage.frame = CGRectMake(10, (70-35)/2, 25, 25);
            self.positionLB.frame    = CGRectMake(45, 0, 250, 30);
            self.timeLB.frame        = CGRectMake(45, 30, 200, 25);
            self.gongsiLB.frame      = CGRectMake(45, 55, 250, 25);
            self.priceLB.frame       = CGRectMake(SCREEN_WIDTH-100-35, 25, 100, 30);
            
            self.positionImage.userInteractionEnabled = YES;
            [self.positionImage bk_whenTapped:^{
                model.isSelected = !model.isSelected;
                if (model.isSelected) {
                    self.positionImage.image = [UIImage imageNamed:@"checkbox_selected"];
                }else
                {
                    self.positionImage.image = [UIImage imageNamed:@"checkbox_normal"];
                }
            }];
        } else if ([model.fromType integerValue] == 10)
        {
            //我的面试邀请
            [self.positionImage removeFromSuperview];
            [_gongsiLB removeFromSuperview];
            
            CGFloat left = 10;
            self.positionLB.frame    = CGRectMake(left, 0, 250, 30);
            self.timeLB.frame        = CGRectMake(left, 30, 200, 25);
            self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
            NSString *name ;
            if (ISNOTNILSTR(model.tb_position)) {
                name = [NSString stringWithFormat:@"%@[%@]",model.truename,model.tb_position];
            }else
            {
                name = [NSString stringWithFormat:@"%@",model.truename];
            }
            _positionLB.text = name;
            [_positionLB settingSub:[NSString stringWithFormat:@"[%@]",model.tb_position] color:color_title_Gray font:14];
            
            
            _timeLB.text = [NSString stringWithFormat:@"%@",[NSObject getTime:model.tb_uptime]];
            
            
            CGFloat W = [model.truename getStrW:30 font:16]+5;
         
            self.priceLB.frame = CGRectMake(10+W, 8, 35, 16);
            self.priceLB.font = [UIFont systemFontOfSize:10];
            [self.priceLB setCornerRadius:3];
            self.priceLB.layer.borderWidth = 1;
            self.priceLB.textAlignment = NSTextAlignmentCenter;
            if([model.tb_reading isEqualToString:@"1"])
            {   //已读
                self.priceLB.text = @"已读";
                self.priceLB.layer.borderColor = [UIColor lightGrayColor].CGColor;
                self.priceLB.textColor = [UIColor lightGrayColor];
            }else
            {    //未读
                self.priceLB.text = @"未读";
                self.priceLB.layer.borderColor = RGBCOLOR(13, 67, 125).CGColor;
                self.priceLB.textColor = RGBCOLOR(13, 67, 125);
            }
            
        }else if ([model.fromType integerValue] == 11)
        {
            //面试管理
            [self.positionImage removeFromSuperview];
            [_gongsiLB removeFromSuperview];
            
            CGFloat left = 10;
            self.positionLB.frame    = CGRectMake(left, 0, 250, 30);
            self.timeLB.frame        = CGRectMake(left, 30, 200, 25);
          
            self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
            
            
            NSString *name ;
            if (ISNOTNILSTR(model.tb_position)) {
                name = [NSString stringWithFormat:@"%@[%@]",model.tb_companyname,model.tb_position];
            }else
            {
                name = [NSString stringWithFormat:@"%@",model.tb_companyname];
            }
            _positionLB.text = name;
            [_positionLB settingSub:[NSString stringWithFormat:@"[%@]",model.tb_position] color:color_title_Gray font:14];
            
           
            _timeLB.text = [NSString stringWithFormat:@"%@",[NSObject getTime:model.tb_uptime]];
            
            
            CGFloat W = [model.tb_companyname getStrW:30 font:16]+5;
            
            self.priceLB.frame = CGRectMake(10+W, 8, 35, 16);
            self.priceLB.font = [UIFont systemFontOfSize:10];
            [self.priceLB setCornerRadius:3];
            self.priceLB.layer.borderWidth = 1;
            self.priceLB.textAlignment = NSTextAlignmentCenter;
            if([model.tb_reading isEqualToString:@"1"])
            {   //已读
                self.priceLB.text = @"已读";
                self.priceLB.layer.borderColor = [UIColor lightGrayColor].CGColor;
                self.priceLB.textColor = [UIColor lightGrayColor];
            }else
            {    //未读
                self.priceLB.text = @"未读";
                self.priceLB.layer.borderColor = RGBCOLOR(13, 67, 125).CGColor;
                self.priceLB.textColor = RGBCOLOR(13, 67, 125);
            }
            
        }
        else
        {
            //
            [_positionImage setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
            self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
            self.priceLB.frame = CGRectMake(SCREEN_WIDTH-100-10-35, 25, 100, 30);
            _positionLB.text = model.tb_name;
            _timeLB.text = [NSString stringWithFormat:@"%@/%@",model.tb_city,[NSObject getTime:model.tb_uptime]];
            _gongsiLB.text = model.turename;
            _priceLB.text = [NSObject getInfoDetail:model.tb_salary];
            if (model.isSelected) {
                self.positionImage.image = [UIImage imageNamed:@"checkbox_selected"];
            }else
            {
              self.positionImage.image = [UIImage imageNamed:@"checkbox_normal"];
            }
        
            self.positionImage.frame = CGRectMake(10, (70-25)/2, 25, 25);
            self.positionLB.frame    = CGRectMake(45, 0, 250, 30);
            self.timeLB.frame        = CGRectMake(45, 30, 200, 25);
            self.gongsiLB.frame      = CGRectMake(45, 55, 250, 25);
        }
       
    }

}


@end

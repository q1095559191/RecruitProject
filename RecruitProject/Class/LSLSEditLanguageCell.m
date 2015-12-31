//
//  LSLSEditLanguageCell.m
//  RecruitProject
//
//  Created by sliu on 15/10/28.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSLSEditLanguageCell.h"

@implementation LSLSEditLanguageCell
- (void)awakeFromNib {
    // Initialization code
    self.titleLB = [UILabel labelWithText:@"张三" color:color_title_Gray font:16 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview: self.titleLB];
    
    
    
     self.levelLB = [[UITextField alloc] init];
   
     self.levelLB.font = [UIFont systemFontOfSize:14];
     self.levelLB.textAlignment = NSTextAlignmentRight;
     self.levelLB.delegate = self;
     [self.contentView addSubview: self.levelLB];
    
    
    self.headImage = [[UIImageView alloc] init];
    [self.contentView addSubview: self.headImage];
    self.titleLB.frame = CGRectMake(40, 5, 100, 30);
    self.levelLB.frame = CGRectMake(SCREEN_WIDTH-200-10, 5, 200, 30);
    self.headImage.frame = CGRectMake(10, 10, 20, 20);
    self.levelLB.placeholder = @"填写语言能力等级";
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.model.detailTile = textField.text;
}

-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSBaseModel class]]) {
        LSBaseModel *model = (LSBaseModel *)data;
        self.model = model;
        if (model.isSelected) {
            self.headImage.image = [UIImage imageNamed:@"checkbox_selected"];
            self.levelLB.hidden = NO;
        }else
        {
           self.headImage.image = [UIImage imageNamed:@"checkbox_normal"];
           self.levelLB.hidden = YES;
        }
        self.titleLB.text = model.title;
        self.levelLB.text = model.detailTile;
        
    }
    
    
}



@end

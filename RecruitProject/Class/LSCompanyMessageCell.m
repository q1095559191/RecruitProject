//
//  LSCompanyMessageCell.m
//  RecruitProject
//
//  Created by sliu on 15/11/4.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSCompanyMessageCell.h"

@implementation LSCompanyMessageCell

-(void)awakeFromNib
{
  self.headImage = [[UIImageView alloc] init];
  [self.contentView addSubview: self.headImage];
  [self.headImage setCornerRadius:5];
  self.headImage.backgroundColor = [UIColor lightGrayColor];
 
    
  self.titleLB = [UILabel labelWithText:nil color:color_black font:14 Alignment:LSLabelAlignment_left];
  [self.contentView addSubview:self.titleLB];
 
  self.detailLB = [UILabel labelWithText:nil color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
  [self.contentView addSubview:self.detailLB];
    
  self.timeLB = [UILabel labelWithText:nil color:color_title_Gray font:10 Alignment:LSLabelAlignment_right];
  [self.contentView addSubview:self.timeLB];
    
  _tipLB = [[UILabel alloc] init];
  [self.contentView addSubview:_tipLB];
  _tipLB.frame = CGRectMake(60, 5, 8, 8);
  _tipLB.backgroundColor = color_bg_yellow;
  [_tipLB setCornerRadius:4];
    
  self.headImage.frame = CGRectMake(10, 10, 50, 50);
  self.titleLB.frame   = CGRectMake(70, 5, 200, 30);
  self.detailLB.frame   = CGRectMake(70, 35, SCREEN_WIDTH-80, 30);
  self.timeLB.frame   = CGRectMake(SCREEN_WIDTH-110, 5, 100, 30);
     
}

-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSMessageModel class]]) {
    LSMessageModel *model = (LSMessageModel *)data;
    [self.headImage setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    self.titleLB.text = model.truename;
    self.detailLB.text = model.detailStr;
    NSString *time =  [NSObject getTime:model.msg_time];
    if (time.length >= 10) {
    self.timeLB.text = [time substringWithRange:NSMakeRange(5, 5)];
    }
        
        if ([model.msg_read integerValue] == 0) {
            _tipLB.hidden = NO;
        }else
        {
            _tipLB.hidden = YES;
        }
            
    
}

}

@end

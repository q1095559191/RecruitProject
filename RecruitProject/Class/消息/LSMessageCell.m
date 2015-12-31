//
//  LSMessageCell.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSMessageCell.h"

@implementation LSMessageCell

- (void)awakeFromNib {
// Initialization code
    
   

    self.timeLB = [UILabel labelWithText:@"2015-12-12 10:20" color:color_black font:14 Alignment:LSLabelAlignment_center];
    [self.contentView addSubview:self.timeLB];
    self.timeLB.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    self.timeLB.backgroundColor = color_clear;
    
    _bgView = [[UIView alloc] init];
    [self.contentView addSubview:_bgView];
    _bgView.backgroundColor = color_white;
    [_bgView setCornerRadius:5];
    
    self.titleLB = [UILabel labelWithText:nil color:color_black font:14 Alignment:LSLabelAlignment_left];
    [_bgView addSubview:self.titleLB];
    self.titleLB.numberOfLines = 0;
   

    self.detailLB = [UILabel labelWithText:@"12313" color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
    [_bgView addSubview:self.detailLB];
    self.detailLB.numberOfLines = 0;

  
    _showLB = [UILabel labelWithText:nil color:color_black font:14 Alignment:LSLabelAlignment_right];
    [_bgView addSubview:_showLB];

    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_right"]];
    [_showLB addSubview:image];
    image.frame = CGRectMake(SCREEN_WIDTH-20-10-15, 8, 10, 14);
  
    UILabel *label = [UILabel labelWithText:@"去看看" color:color_black font:14 Alignment:LSLabelAlignment_right];
    [_showLB addSubview:label];
    label.frame = CGRectMake(0, 0, SCREEN_WIDTH-50, 30);
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = color_line;
    [_showLB addSubview:lineView1];
    lineView1.edgeNearTop(0,0,0,0.5);
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = color_line;
    [_showLB addSubview:lineView2];
    lineView2.edgeNearbottom(0,0,0,0.5);
    
    UIView *tempView = [[UIView alloc] init];
    [self setBackgroundView:tempView];
    [self setBackgroundColor:[UIColor clearColor]];
  
   
    
}

+(CGFloat)GetCellH:(id)data
{
    if ([data isKindOfClass:[LSMessageModel class]]) {
        LSMessageModel *model = (LSMessageModel *)data;
      
      CGFloat W = SCREEN_WIDTH - 20;
      CGFloat titleH = [model.msg_title getStrH:W-20 font:14]+10;
      CGFloat detailH = [model.msg_txt getStrH:W-20 font:14]+10;
      return 30+titleH+detailH+30;
    }
    return 44;

}

-(void)configCell:(id)data
{
      if ([data isKindOfClass:[LSMessageModel class]]) {
        LSMessageModel *model = (LSMessageModel *)data;
        self.titleLB.text = model.msg_title;
        self.detailLB.text = model.msg_txt;
        self.timeLB.text = [NSObject getDetailTime: model.msg_time];
        CGFloat W = SCREEN_WIDTH - 20;
        
        CGFloat titleH = [model.msg_title getStrH:W-20 font:14]+10;
        self.titleLB.frame = CGRectMake(10, 0, W-20, titleH);
        
        CGFloat detailH = [model.msg_txt getStrH:W-20 font:14]+10;
        self.detailLB.frame = CGRectMake(10, titleH, W-20, detailH);
        self.showLB.frame = CGRectMake(0, detailH+titleH, W, 30);
        self.bgView.frame = CGRectMake(10, 30, W, 30+titleH+detailH);
        
        
    }
}



@end

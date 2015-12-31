//
//  LSCompanyMessageDetailCell.m
//  RecruitProject
//
//  Created by sliu on 15/11/5.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSCompanyMessageDetailCell.h"

@implementation LSCompanyMessageDetailCell

- (void)awakeFromNib {
    // Initialization code

    self.timeLB = [UILabel labelWithText:@"" color:color_black font:14 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:self.timeLB];
    self.timeLB.frame = CGRectMake(10, 0, SCREEN_WIDTH, 30);
    self.timeLB.backgroundColor = color_clear;
    
    self.headImage = [[UIImageView alloc] init];
    [self.contentView addSubview: self.headImage];
    self.headImage.frame = CGRectMake(10, 30, 35, 35);
    [self.headImage setCornerRadius:4];
    
    UIImageView *arrowView = [[UIImageView alloc] init];
    [self.contentView addSubview: arrowView];
    arrowView.frame = CGRectMake(50, 30+18, 10, 15);
    arrowView.image = [UIImage imageNamed:@"arrow_comment_left"];
    
    _bgView = [[UIView alloc] init];
    [self.contentView addSubview:_bgView];
    _bgView.backgroundColor = color_white;
    [_bgView setCornerRadius:5];
    
    self.titleLB = [UILabel labelWithText:nil color:color_black font:16 Alignment:LSLabelAlignment_left];
    [_bgView addSubview:self.titleLB];
    self.titleLB.numberOfLines = 0;
    
    
    self.detailLB = [UILabel labelWithText:@"12313" color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
    [_bgView addSubview:self.detailLB];
    self.detailLB.numberOfLines = 0;
    
    
    _showLB = [UILabel labelWithText:nil color:color_black font:14 Alignment:LSLabelAlignment_right];
    [_bgView addSubview:_showLB];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_right"]];
    [_showLB addSubview:image];
    image.frame = CGRectMake(SCREEN_WIDTH-70-20, 8, 10, 14);
    
    _showDetailLB = [UILabel labelWithText:@"去看看" color:color_black font:14 Alignment:LSLabelAlignment_right];
    [_showLB addSubview:_showDetailLB];
    _showDetailLB.frame = CGRectMake(0, 0, SCREEN_WIDTH-95, 30);
    
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
        
        CGFloat W = SCREEN_WIDTH - 70;
        CGFloat titleH = [model.detailStr getStrH:W-20 font:16]+10;
        CGFloat detailH = [model.detailStr2 getStrH:W-20 font:14]+10;
        return 30+titleH+detailH+30;
    }
    return 44;
    
}

-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSMessageModel class]]) {
        LSMessageModel *model = (LSMessageModel *)data;
        self.titleLB.text = model.detailStr;
        self.detailLB.text = model.detailStr2;
        [self.headImage setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
        self.timeLB.text = [NSObject getDetailTime: model.msg_time];
        CGFloat W = SCREEN_WIDTH - 70;
        CGFloat left = 60;
        
        CGFloat titleH = [model.detailStr getStrH:W-20 font:16]+10;
        self.titleLB.frame = CGRectMake(10, 0, W-20, titleH);
        
        CGFloat detailH = [model.detailStr2 getStrH:W-20 font:14]+10;
        self.detailLB.frame = CGRectMake(10, titleH, W-20, detailH);
        self.showLB.frame = CGRectMake(0, detailH+titleH, W, 30);
        
        self.bgView.frame = CGRectMake(left, 30, W, 30+titleH+detailH);
        
        _showDetailLB.text = model.showStr;
        
        
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

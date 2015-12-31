//
//  LSPersonalHeadCell.m
//  RecruitProject
//
//  Created by sliu on 15/9/24.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSPersonalHeadCell.h"

@implementation LSPersonalHeadCell

- (void)awakeFromNib {
    // Initialization code
    _headImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImage];
    [_headImage setCornerRadius:5];
    _headImage.backgroundColor = [UIColor lightGrayColor];
    
    _titleLB = [UILabel labelWithText:nil color:color_black font:18 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_titleLB];
    
    _detailLB = [UILabel labelWithText:@"简历完整度（%50）" color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_detailLB];
    
    _headImage.sizeBy(60,60);
    _headImage.originBy(10,15);
    
    _titleLB.originBy(80,15);
    _titleLB.sizeBy(200,30);
    
    _detailLB.originBy(80,45);
    _detailLB.sizeBy(200,20);
  
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
    
    //简历完整度
    _progressBg = [[UIView alloc] init];
    _progressBg.backgroundColor = color_title_Gray;
    [self.contentView  addSubview:_progressBg];
    _progressBg.frame = CGRectMake(80, 70, SCREEN_WIDTH - 90, 4);
    [_progressBg setCornerRadius:2];
    
    _progressView = [[UIView alloc] init];
    _progressView.backgroundColor = color_main;
    [self.contentView  addSubview:_progressView];
    _progressView.frame = CGRectMake(80, 70, (SCREEN_WIDTH - 95)/2, 4);
    [_progressView setCornerRadius:2];
    
}

-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSUserModel class]]) {
        LSUserModel *model = (LSUserModel*)data;
        NSString *title ;
        if (ISNILSTR(model.position)) {
         title = [NSString stringWithFormat:@"%@",model.truename];
        }else
        {
        title = [NSString stringWithFormat:@"%@[%@]",model.truename,model.position];
        }
        _titleLB.text = title;
        [_titleLB settingSub:[NSString stringWithFormat:@"[%@]",model.position] color:color_title_Gray font:16];
        [_headImage setImageWithURL:[NSURL URLWithString:model.img]];
        CGFloat  a  = 100/[model.resume_task_completion floatValue];
         _progressView.frame = CGRectMake(80, 70, (SCREEN_WIDTH - 95)/a, 4);
        _detailLB.text = [NSString stringWithFormat:@"简历完整度（%@%%）",model.resume_task_completion];
    }
   
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
}

@end

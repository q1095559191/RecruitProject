//
//  LSIntersetedCell.m
//  RecruitProject
//
//  Created by sliu on 15/9/24.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSIntersetedCell.h"

@implementation LSIntersetedCell

- (void)awakeFromNib {
    // Initialization code
    _headImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImage];
    [_headImage setCornerRadius:5];
    _headImage.backgroundColor = [UIColor lightGrayColor];
    
    _titleLB = [UILabel labelWithText:@"新朋友" color:color_black font:15 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_titleLB];
    
    _detailLB = [UILabel labelWithText:@"你们的职位相似" color:color_title_Gray font:13 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_detailLB];
    
    
    _headImage.sizeBy(44,44);
    _headImage.originBy(10,8);
    
    _titleLB.originBy(64,5);
    _titleLB.sizeBy(SCREEN_WIDTH - 80-64,30);
    
    
    _detailLB.sizeBy(SCREEN_WIDTH - 80-64,20);
    _detailLB.originBy(64,30);
    
    
    _attentionBtn = [UIButton buttonWithTitle:@"关注TA" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
    }];
    
    [_attentionBtn setfont:14];
    [self.contentView addSubview:_attentionBtn];
    [_attentionBtn setCornerRadius:3];
    _attentionBtn.frame = CGRectMake(SCREEN_WIDTH - 60-10, 20, 55, 20);
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
    //最新动态
    _nameLB1 =  [UILabel labelWithText:@"李四" color:color_main font:12 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_nameLB1];
    
    _timeLB1 = [UILabel labelWithText:@"2015-08-06 发表了帖子" color:color_title_Gray font:12 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_timeLB1];
    
    _titleLB1 = [UILabel labelWithText:@" " color:color_black font:14 Alignment:LSLabelAlignment_left];
    _titleLB1.numberOfLines = 0;
    [self.contentView addSubview:_titleLB1];
    
    
    _nameLB2 =  [UILabel labelWithText:@"李四" color:color_main font:12 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_nameLB2];
    
    _timeLB2 = [UILabel labelWithText:@"2015-08-06 发表了帖子" color:color_title_Gray font:12 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_timeLB2];
    
    _titleLB2 = [UILabel labelWithText:@" " color:color_black font:14 Alignment:LSLabelAlignment_left];
    _titleLB2.numberOfLines = 0;
    [self.contentView addSubview:_titleLB2];
    
}

+(CGFloat)GetCellH:(id)data
{
    
    if ([data isKindOfClass:[LSInterstedModel class]]) {
        
        LSInterstedModel *model = (LSInterstedModel *)data;
        CGFloat top = 0;
        if ([model.fromType isEqualToString:@"1"]) {
            //人
            top = 50;
        }else
        {   //圈子
            top = 30;
        }
        
        CGFloat LabelW = SCREEN_WIDTH-75;
        //动态信息
        if (model.circlepost_list) {
            if (model.circlepost_list.count == 0) {
                 top = 50;
            }
            if (model.circlepost_list.count >= 1) {
                NSDictionary *dic = model.circlepost_list[0];
                NSString *title = dic[@"tb_title"];
                CGFloat labelH = [title getStrH:LabelW font:14]+10;
                top += 20;
                top += labelH;
            }
            
            if (model.circlepost_list.count >= 2) {
                NSDictionary *dic = model.circlepost_list[1];
                NSString *title = dic[@"tb_title"];
                CGFloat labelH = [title getStrH:LabelW font:14]+10;
                top += 20;
                top += labelH;
            }
            
        }else
        {
           
        }
        
        return top+8;
    }
    
    return 100;
}

-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSInterstedModel class]]) {
        LSInterstedModel *model = (LSInterstedModel *)data;
        NSString *btnTitle;
        NSString *btnTitle_sel;
        CGFloat  HeadH;
        if ([model.fromType isEqualToString:@"1"]) {
              //感兴趣的人
             btnTitle = @"关注TA";
             btnTitle_sel = @"已关注";
             HeadH = 50;
            NSString *name = model.member_info[@"truename"];
            NSString *image = model.member_info[@"img"];
            _titleLB.text = name;
            [_headImage setImageWithURL:[NSURL URLWithString:image]];
            NSString *tb_jobtype_two = [NSString stringWithFormat:@"%@",model.member_info[@"tb_jobtype_two"]];
            NSString *job = [NSObject getInfoDetail:tb_jobtype_two];
            if(job)
            {                job = [NSString stringWithFormat:@"[%@]",job];
            }else
            {
                             job = @"";
            }
            _titleLB.text = [NSString stringWithFormat:@"%@ %@",name,job];
            [_titleLB settingSub:[NSString stringWithFormat:@"%@",job] color:color_title_Gray font:14];
             _detailLB.hidden = NO;
        }else
        {   //感兴趣的圈子
            if ([model.fromType isEqualToString:@"2"]) {
                btnTitle = @"+加入";
                btnTitle_sel = @"已加入";
            }else
            {
                btnTitle     = @"退出圈子";
                btnTitle_sel = @"已退出";
                _attentionBtn.frame = CGRectMake(SCREEN_WIDTH - 70 -15, 10, 70, 20);
            }
            
            HeadH = 30;
            _titleLB.text = model.tb_name;
            [_headImage setImageWithURL:[NSURL URLWithString:model.tb_img]];
            _detailLB.hidden = YES;
        }
       
        if ([model.is_friend integerValue] == 1) {
            self.attentionBtn.backgroundColor = RGBCOLOR(225, 225, 225);
            [self.attentionBtn setTitleColor:RGBCOLOR(200, 200, 200) forState:UIControlStateNormal];
            [self.attentionBtn setTitle:btnTitle_sel forState:UIControlStateNormal];
             self.attentionBtn.enabled = NO;
        }else
        {
            self.attentionBtn.backgroundColor = color_main;
            [self.attentionBtn setTitleColor:color_white forState:UIControlStateNormal];
            [self.attentionBtn setTitle:btnTitle forState:UIControlStateNormal];
            self.attentionBtn.enabled = YES;
        }
        
        
        _nameLB1.hidden = YES;
        _timeLB1.hidden = YES;
        _titleLB1.hidden = YES;
        _nameLB2.hidden = YES;
        _timeLB2.hidden = YES;
        _titleLB2.hidden = YES;
        
        //动态信息
        if (model.circlepost_list) {
            CGFloat top = HeadH;
            CGFloat nameW = 0;
            CGFloat LabelW = SCREEN_WIDTH - 74;
            if (model.circlepost_list.count >= 1) {
                _nameLB1.hidden = NO;
                _timeLB1.hidden = NO;
                _titleLB1.hidden = NO;
                NSDictionary *dic = model.circlepost_list[0];
                NSString *name = dic[@"truename"];
                NSString *title = dic[@"tb_title"];
                NSString *time = [NSString stringWithFormat:@"%@发表帖子",[NSObject getTime:dic[@"tb_addtime"]]];
                _nameLB1.text = name;
                _timeLB1.text = time;
                _titleLB1.text = title;
                nameW = [name getStrW:20 font:14];
                _nameLB1.text = name;
                _nameLB1.frame = CGRectMake(64, top, nameW, 20);
                _timeLB1.frame = CGRectMake(64+nameW, top, 200, 20);
                CGFloat labelH = [_titleLB1.text getStrH:LabelW font:14]+10;
                top = top+20;
                _titleLB1.frame = CGRectMake(64, top, LabelW, labelH);
                 top += labelH;
            }
            
            if (model.circlepost_list.count >= 2) {
                _nameLB2.hidden = NO;
                _timeLB2.hidden = NO;
                _titleLB2.hidden = NO;
                NSDictionary *dic = model.circlepost_list[1];
                NSString *name = dic[@"truename"];
                NSString *title = dic[@"tb_title"];
                NSString *time = [NSString stringWithFormat:@"%@发表帖子",[NSObject getTime:dic[@"tb_addtime"]]];
                _nameLB2.text = name;
                _timeLB2.text = time;
                _titleLB2.text = title;
                
                nameW = [name getStrW:20 font:14];
                _nameLB2.frame = CGRectMake(64, top, nameW, 20);
                _timeLB2.frame = CGRectMake(64+nameW, top, 200, 20);
                CGFloat labelH = [_titleLB2.text getStrH:LabelW font:14]+10;
                top = top+20;
                _titleLB2.frame = CGRectMake(64, top, LabelW
                                             ,labelH);
                top += labelH;
            }
        
        }
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

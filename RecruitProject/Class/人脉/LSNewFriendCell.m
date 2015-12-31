//
//  LSNewFriendCell.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSNewFriendCell.h"

@implementation LSNewFriendCell

- (void)awakeFromNib {
    // Initialization code
    _headImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImage];
    [_headImage setCornerRadius:5];
    _headImage.backgroundColor = [UIColor lightGrayColor];
    
    _titleLB = [UILabel labelWithText:nil color:color_black font:15 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_titleLB];
    
    _detailLB = [UILabel labelWithText:nil color:color_title_Gray font:12 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_detailLB];
    
    // 70
    _headImage.originBy(10,10);
    _headImage.sizeBy(50,50);
    
    
    _titleLB.originBy(70,5);
    _titleLB.sizeBy(200,30);
   
    
    _detailLB.sizeBy(200,35);
    _detailLB.originBy(70,30);
    
    
    _attentionBtn = [UIButton buttonWithTitle:@"关注TA" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
    }];
    
    [_attentionBtn setfont:14];
    [self.contentView addSubview:_attentionBtn];
    [_attentionBtn setCornerRadius:3];
    _attentionBtn.frame = CGRectMake(SCREEN_WIDTH - 60-10, 20, 55, 20);
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
}

-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSInterstedModel class]]) {
        LSInterstedModel *model = (LSInterstedModel *)data;
        NSString *name = model.member_info[@"truename"];
        NSString *image = model.member_info[@"img"];
        _titleLB.text = name;
        [_headImage setImageWithURL:[NSURL URLWithString:image]];
        NSString *tb_jobtype_two = [NSString stringWithFormat:@"%@",model.member_info[@"tb_jobtype_two"]];
        NSString *job = [NSObject getInfoDetail:tb_jobtype_two];
        if (!ISNILSTR(job)) {
            _titleLB.text = [NSString stringWithFormat:@"%@ [%@]",name,job];
            [_titleLB settingSub:[NSString stringWithFormat:@"[%@]",job] color:color_title_Gray font:14];
        }else
        {
           _titleLB.text = [NSString stringWithFormat:@"%@",name];
        }
        
        _detailLB.text = [NSString stringWithFormat:@"%@ 关注了您",[NSObject getDetailTime:model.tb_addtime]];
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

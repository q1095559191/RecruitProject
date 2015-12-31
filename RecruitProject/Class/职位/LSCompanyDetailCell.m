//
//  LSCompanyDetailCell.m
//  RecruitProject
//
//  Created by sliu on 15/10/9.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSCompanyDetailCell.h"

@implementation LSCompanyDetailCell
- (void)awakeFromNib {
    // Initialization code
    _headImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImage];
    [_headImage setCornerRadius:5];
    _headImage.backgroundColor = [UIColor lightGrayColor];
    
    _titleLB = [UILabel labelWithText:nil color:color_black font:16 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_titleLB];
    
    NSArray *titles = @[@"公司规模:",@"公司性质:",@"公司行业:"];
    for (int i = 0; i < 3; i++) {
        UILabel *label =  [UILabel labelWithText:titles[i] color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
        [self.contentView addSubview:label];
        label.frame = CGRectMake(90, 40+i*30, 70, 30);
        
        UILabel *label1 =  [UILabel labelWithText:titles[i] color:color_black font:14 Alignment:LSLabelAlignment_left];
        [self.contentView addSubview:label1];
        label1.tag = 11 +i;
        label1.frame = CGRectMake(90+70, 40+i*30, 100, 30);
    }
   
    _headImage.sizeBy(70,70);
    _headImage.originBy(10,10);
    _titleLB.originBy(90,5);
    _titleLB.sizeBy(200,40);
    
    _attentionBtn = [UIButton buttonWithTitle:@"+关注" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
    
    }];
    [_attentionBtn setfont:14];
    [self.contentView addSubview:_attentionBtn];
    [_attentionBtn setCornerRadius:3];
    _attentionBtn.frame = CGRectMake(15, 90, 60, 20);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSUserModel class]]) {
        LSUserModel *model = (LSUserModel*)data;
        [_headImage setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
        _titleLB.text = model.truename;
        UILabel *label1 = (UILabel *)[self.contentView viewWithTag:11];
        UILabel *label2 = (UILabel *)[self.contentView viewWithTag:12];
        UILabel *label3 = (UILabel *)[self.contentView viewWithTag:13];
        label1.text = [NSString getInfoDetail:model.unitsize];
        label2.text = [NSString getInfoDetail:model.unittype];
        label3.text = [NSString getInfoDetail:model.tb_jobtype];//公司行业

        
        if ([model.is_friend integerValue] == 1) {
            self.attentionBtn.backgroundColor = RGBCOLOR(225, 225, 225);
            [self.attentionBtn setTitleColor:RGBCOLOR(200, 200, 200) forState:UIControlStateNormal];
            [self.attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
            self.attentionBtn.enabled = NO;
        }else
        {
            self.attentionBtn.backgroundColor = color_main;
            [self.attentionBtn setTitleColor:color_white forState:UIControlStateNormal];
            [self.attentionBtn setTitle:@"+关注" forState:UIControlStateNormal];
            self.attentionBtn.enabled = YES;
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

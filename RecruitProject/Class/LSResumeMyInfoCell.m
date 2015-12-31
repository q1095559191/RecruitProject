//
//  LSResumeMyInfoCell.m
//  RecruitProject
//
//  Created by sliu on 15/10/28.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSResumeMyInfoCell.h"

@implementation LSResumeMyInfoCell

- (void)awakeFromNib
{
    self.headImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headImage];
    [self.headImage setCornerRadius:5];
    self.headImage.backgroundColor = [UIColor lightGrayColor];
    
    self.titleLB = [UILabel labelWithText:@"张三" color:color_black font:18 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:self.titleLB];
    

    CGFloat ImageW = 50;
    self.headImage.sizeBy(ImageW,ImageW);
    self.headImage.originBy(10,15);
    
    self.titleLB.originBy(ImageW+20,15);
    self.titleLB.sizeBy(200,30);
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
    //简历完整度
    _progressBg = [[UIView alloc] init];
    _progressBg.backgroundColor = color_title_Gray;
    [self.contentView  addSubview:_progressBg];
    _progressBg.frame = CGRectMake(10, ImageW+10+10, SCREEN_WIDTH - 20, 4);
    [_progressBg setCornerRadius:2];
    
    _progressView = [[UIView alloc] init];
    _progressView.backgroundColor = color_main;
    [self.contentView  addSubview:_progressView];
    _progressView.frame = CGRectMake(10, ImageW+10+10, (SCREEN_WIDTH - 20)/2, 4);
    [_progressView setCornerRadius:2];
    
    //展开
    self.openBtn = [UIButton buttonWithImage:@"icon_chevron_down" action:^(UIButton *btn) {
    
    }];
    [self.openBtn setImage:[UIImage imageNamed:@"icon_chevron_up"] forState:UIControlStateSelected];
    [self.contentView addSubview: self.openBtn];
    self.openBtn.edgeNearbottom(0,0,0,30);
    
    self.editBtn = [UIButton buttonWithImage:@"btn_edit_resume_orange" action:^(UIButton *btn) {
        
    }];
  
    [self.contentView addSubview: self.editBtn];
    self.editBtn.frame = CGRectMake(SCREEN_WIDTH - 10-30,15,30,40);
    
   
}


+(CGFloat)GetCellH:(id)data
{
    LSUserModel *model = (LSUserModel *)data;
    if (model.isOpen) {
        return 240;
    }else
    {
        return 180;
    }
}

-(NSString *)getStr:(NSString *)str
{
if(str)
{
    if (str.length >= 1) {
        return str;
    }else
    {
      return @"未填写";
    }
    
}else
{
  return @"未填写";
}
}

-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSUserModel class]]) {
        for (UILabel *label in [self.contentView subviews]) {
            if (label.tag >= +33) {
                [label removeFromSuperview];
            }
        }
        
        LSUserModel *model = (LSUserModel *)data;
        [self.headImage setImageWithURL:[NSURL URLWithString:model.img]];
        self.titleLB.text = [NSString stringWithFormat:@"%@  %@",model.truename,model.sex];
        NSArray *titles = @[@"手机:",@"工作性质:",@"QQ:",@"工作经验:",@"邮箱:",@"期望职位:",@"地点:",@"期望月薪:",@"学历:",@"目前状态:"];
        
        NSMutableArray *contentArr = [NSMutableArray array];
        [contentArr addObject:[self getStr:model.mobile]];
        [contentArr addObject:[self getStr:[NSObject getInfoDetail:model.tb_worknature]]];
        [contentArr addObject:[self getStr:model.qq]];
        [contentArr addObject:[self getStr:[NSObject getInfoDetail:model.tb_workyear]]];
        [contentArr addObject:[self getStr:model.email]];
        [contentArr addObject:[self getStr:model.tb_position]];
        [contentArr addObject:[self getStr:model.tb_city]];
        [contentArr addObject:[self getStr:[NSObject getInfoDetail:model.tb_salary]]];
        [contentArr addObject:[self getStr:[NSObject getInfoDetail:model.tb_degree]]];
        [contentArr addObject:[self getStr:[NSObject getInfoDetail:model.tb_workstate]]];
        
        int a = 0;
        if (model.isOpen) {
            a  = 10;
        }else
        {
            a  = 6;
        }
        self.openBtn.selected = model.isOpen;
        for (int i = 0; i < a; i ++) {
           int m =  i/2;
           int n =  i%2;
            
            UILabel *label = [UILabel labelWithText:[NSString stringWithFormat:@"%@ %@",titles[i],contentArr[i]] color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
            label.tag = 33+i;
            [self.contentView addSubview:label];
            label.numberOfLines = 2;
            [label settingSub:contentArr[i] color:color_black font:14];
            label.frame = CGRectMake(10+n*(SCREEN_WIDTH/2-10), 80+m*40, (SCREEN_WIDTH-20)/2, 40);
        }
    }
    
}

@end

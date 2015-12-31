//
//  LSPositionRequire.m
//  RecruitProject
//
//  Created by sliu on 15/10/8.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSPositionRequire.h"

@implementation LSPositionRequire
- (void)awakeFromNib {
    // Initialization code
    NSArray *titles = @[@"工作性质",@"职位月薪",@"工作地点",@"工作经验",@"最低学历",@"招聘人数"];
    CGFloat w = SCREEN_WIDTH/3;
    for (int i = 0; i < titles.count; i++ ) {
        int a = i%3;
        int b = i/3;
        UILabel *label1 = [UILabel labelWithText:titles[i] color:color_black font:14 Alignment:LSLabelAlignment_center];
        [self.contentView addSubview:label1];
        label1.frame = CGRectMake(a*w, b*50, w, 25);
        
        UILabel *label2 = [UILabel labelWithText:nil color:color_bg_yellow font:14 Alignment:LSLabelAlignment_center];
        [self.contentView addSubview:label2];
        label2.tag = 10 +i;
        label2.frame = CGRectMake(a*w, b*50 +25, w, 25);
    }
    
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    lineView.backgroundColor = color_line;
    lineView.frame = CGRectMake(0, 50, SCREEN_WIDTH, 0.5);
    
    UIView *lineView1 = [[UIView alloc] init];
    [self.contentView addSubview:lineView1];
    lineView1.backgroundColor = color_line;
    lineView1.frame = CGRectMake(w, 0, 0.5, 100);
    
    UIView *lineView2 = [[UIView alloc] init];
    [self.contentView addSubview:lineView2];
    lineView2.backgroundColor = color_line;
    lineView2.frame = CGRectMake(2*w, 0, 0.5, 100);
    
}


-(void)configCell:(id)data
{
    if ([data isKindOfClass:[NSArray class]]) {
        NSArray *model = (NSArray*)data;
        for (int i = 0; i <6; i++) {
            UILabel *label = (UILabel *)[self.contentView viewWithTag:10+i];
            label.text =model[i];
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

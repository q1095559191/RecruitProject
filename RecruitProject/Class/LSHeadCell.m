//
//  LSHeadCell.m
//  RecruitProject
//
//  Created by sliu on 15/10/19.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSHeadCell.h"

@implementation LSHeadCell

-(void)awakeFromNib
{
    self.titleLB = [UILabel labelWithText:nil color:color_title_Gray font:16 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:self.titleLB];
    self.titleLB.edge(0,10,0,0);
    
    UIView *line = [[UIView alloc] init];
    [self.contentView addSubview:line];
    line.edgeNearbottom (0,0,0,1);
    line.backgroundColor = color_line;
     self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
    
    self.editBtn = [UIButton buttonWithImage:@"btn_add_resume_orange" action:^(UIButton *btn) {
        
    }];
    self.editBtn.frame = CGRectMake(SCREEN_WIDTH - 40, 0, 25, 30);
    [self.contentView addSubview:self.editBtn];

}
+(CGFloat)GetCellH:(id)data
{
      return 40;
}

-(void)configCell:(id)data
{
    if ([data isKindOfClass:[NSString class]]) {
        self.titleLB.text = data;
        [self.editBtn removeFromSuperview];
    }
    
    if ([data isKindOfClass:[NSArray class]]) {
        self.titleLB.text = data[0];
    }
}

@end

//
//  LSResumeHeadCell.m
//  RecruitProject
//
//  Created by sliu on 15/10/19.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSResumeHeadCell.h"

@implementation LSResumeHeadCell

- (void)awakeFromNib {
    // Initialization code
    
    self.headImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headImage];
    [self.headImage setCornerRadius:5];
    self.headImage.backgroundColor = [UIColor lightGrayColor];
    
    self.titleLB = [UILabel labelWithText:nil
                                    color:color_black font:16 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:self.titleLB];
    
    self.detailLB = [UILabel labelWithText:nil color:color_black font:14 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:self.detailLB];
    
    //  90
   self.headImage.sizeBy(60,60);
   self.headImage.originBy(10,15);
    
    self.titleLB.originBy(80,15);
    self.titleLB.sizeBy(250,30);
    
    
   self.detailLB.sizeBy(250,30);
   self.detailLB.originBy(80,45);
   self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
    UIView *line = [[UIView alloc] init];
    [self.contentView addSubview:line];
    line.backgroundColor = color_line;
    line.frame = CGRectMake(0, 100, SCREEN_WIDTH, 1);
 
   _timeLB = [UILabel labelWithText:@"更新时间:2015-12-24" color:color_black font:12 Alignment:LSLabelAlignment_center];
    _timeLB.backgroundColor = [UIColor whiteColor];
   _timeLB.frame = CGRectMake((SCREEN_WIDTH - 140)/2, 90, 140, 20);
    [self.contentView addSubview:_timeLB];
    
    NSArray *titles = @[@"地点:",@"工作性质:",@"最高学历:",@"期望职位:",@"期望月薪:",@"目前状态:"];
    for (int i = 0; i < titles.count; i++) {
        UILabel *label = [UILabel labelWithText:titles[i] color:color_black font:14 Alignment:LSLabelAlignment_left];
        [self.contentView addSubview:label];
        label.tag = 33 + i;
        CGFloat a = i%2;
        CGFloat b = i/2;
        label.frame = CGRectMake(a*SCREEN_WIDTH/2+10, 110+b*40, SCREEN_WIDTH/2-20, 40);
        label.numberOfLines = 2;
    }
    
 }
    
    
-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSUserModel class]]) {
        LSUserModel *model = (LSUserModel*)data;
        self.titleLB.text = [NSString stringWithFormat:@"%@ %@|%@",model.truename,model.sex,model.birthday];
        [self.headImage setImageWithURL:[NSURL URLWithString:model.img]];
        self.detailLB.text = model.companyName;
        
       NSArray *titles = @[@"地点:",@"工作性质:",@"最高学历:",@"期望职位:",@"期望月薪:",@"目前状态:"];
       NSMutableArray *titleArr = [[NSMutableArray alloc] init];
       [titleArr addObject:[NSString stringWithFormat:@"%@ %@",titles[0],model.tb_city]];
       [titleArr addObject:[NSString stringWithFormat:@"%@ %@",titles[1],[NSObject getInfoDetail:model.tb_worknature]]];
       [titleArr addObject:[NSString stringWithFormat:@"%@ %@",titles[2],[NSObject getInfoDetail:model.tb_degree]]];
       [titleArr addObject:[NSString stringWithFormat:@"%@ %@",titles[3],model.tb_position]];
       [titleArr addObject:[NSString stringWithFormat:@"%@ %@",titles[4],[NSObject getInfoDetail:model.tb_salary]]];
        
       [titleArr addObject:[NSString stringWithFormat:@"%@%@", titles[5],[NSObject getInfoDetail:model.tb_workstate]]];
       
        for (int i = 0; i < 6; i++) {
        UILabel *label = (UILabel *)[self.contentView viewWithTag:33+i];
        label.text = titleArr[i];
        [label settingSub:titles[i] color:color_title_Gray font:14];
    }
}
}



@end

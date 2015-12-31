//
//  LSCircleDetailHeadCell.m
//  RecruitProject
//
//  Created by sliu on 15/10/20.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSCircleDetailHeadCell.h"

@implementation LSCircleDetailHeadCell

-(void)awakeFromNib
{
    
    self.headImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headImage];
    [self.headImage setCornerRadius:5];
    self.headImage.backgroundColor = [UIColor lightGrayColor];
    
    self.titleLB = [UILabel labelWithText:nil
                                    color:color_black font:16 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:self.titleLB];
    
    self.detailLB = [UILabel labelWithText:nil color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
    self.detailLB.numberOfLines = 2;
    [self.contentView addSubview:self.detailLB];
    
    //  90
    self.headImage.sizeBy(60,60);
    self.headImage.originBy(10,15);
    
    self.titleLB.originBy(80,10);
    self.titleLB.sizeBy(250,30);
    
    
    self.detailLB.sizeBy(SCREEN_WIDTH-90,50);
    self.detailLB.originBy(80,30);
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
   
    NSArray *titles = @[@"圈主:",@"创建时间:",@"行业:",@"类型:",@"成员:",@"话题:"];
    for (int i = 0; i < titles.count; i++) {
        UILabel *label = [UILabel labelWithText:titles[i] color:color_black font:14 Alignment:LSLabelAlignment_left];
        [self.contentView addSubview:label];
        if (i == 0) {
            label.textColor = color_main;
        }
        label.tag = 33 + i;
        CGFloat a = i%2;
        CGFloat b = i/2;
        label.frame = CGRectMake(a*SCREEN_WIDTH/2+10, 85+b*30, SCREEN_WIDTH/2-20, 30);
        label.numberOfLines = 2;
    }
    
    
}

-(void)configCell:(id)data
{

    if ([data isKindOfClass:[LSCircleInfoModel class]]) {
        LSCircleInfoModel *model = (LSCircleInfoModel *)data;
        [self.headImage setImageWithURL:[NSURL URLWithString:model.tb_img]];
        self.titleLB.text = model.tb_name;
        self.detailLB.text = model.tb_info;

        NSArray *titles =  @[@"圈主:",@"创建时间:",@"行业:",@"类型:",@"成员:",@"话题:"];
        NSMutableArray *titleArr = [[NSMutableArray alloc] init];
        [titleArr addObject:[NSString stringWithFormat:@"%@ %@",titles[0],model.truename]];
        [titleArr addObject:[NSString stringWithFormat:@"%@ %@",titles[1],[NSObject getTime:model.tb_uptime]]];
        [titleArr addObject:[NSString stringWithFormat:@"%@ %@",titles[2],model.tb_industry]];
        [titleArr addObject:[NSString stringWithFormat:@"%@ %@",titles[3], model.tb_type]];
        [titleArr addObject:[NSString stringWithFormat:@"%@ %@",titles[4],[NSString stringWithFormat:@"%@人",model.circleuser_list_count]]];
        [titleArr addObject:[NSString stringWithFormat:@"%@%@", titles[5],model.circlepost_list_count]];
        
        for (int i = 0; i < 6; i++) {
            UILabel *label = (UILabel *)[self.contentView viewWithTag:33+i];
            label.text = titleArr[i];
        [label settingSub:titles[i] color:color_title_Gray font:14];
         
        }

        
    }

}

@end

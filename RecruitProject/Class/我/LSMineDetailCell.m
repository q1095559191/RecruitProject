//
//  LSMineDetailCell.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSMineDetailCell.h"

@implementation LSMineDetailCell

- (void)awakeFromNib {
    // Initialization code
    //分割线
     CGFloat  w = SCREEN_WIDTH/3;
    for (int i = 0; i< 2; i++) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:line];
       
        line.frame = CGRectMake(w*(i+1), 0, 0.5, 70);
    }
    NSArray *titles ;
    if (APPDELEGETE.isCompany) {
        titles  = @[@"可下载次数",@"可发布次数",@"可置顶次数"];
    }else
    {
        titles  = @[@"申请记录",@"简历数量",@"面试通知"];

    }
    for (int i = 0; i< 3; i++) {
        UIView *bgView = [[UIView alloc] init];
        [self.contentView addSubview:bgView];
        bgView.frame =   CGRectMake(w*i, 0, w, 70);
        bgView.tag = 88 +i;
        
        
        UILabel *label = [UILabel labelWithText:titles[i] color:color_black font:14 Alignment:LSLabelAlignment_center];
        [self.contentView addSubview:label];
        
        UILabel *label2 = [UILabel labelWithText:@"20" color:color_main font:14 Alignment:LSLabelAlignment_center];
        [self.contentView addSubview:label2];
        label2.tag = 33+i;
        
        label.frame =   CGRectMake(w*i, 5, w, 30);
        label2.frame =  CGRectMake(w*i, 5+30, w, 30);
        
    }
}

-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSTipModel class]]) {
     LSTipModel *model = (LSTipModel *)data;
     UILabel *label1  =  (UILabel *)[self.contentView viewWithTag:33];
     UILabel *label2  =  (UILabel *)[self.contentView viewWithTag:34];
     UILabel *label3  =  (UILabel *)[self.contentView viewWithTag:35];
        if (APPDELEGETE.isCompany) {
            label1.text = model.downfiles;
            label2.text = model.openings;
            label3.text = model.topincs;
        }else
        {   label1.text = model.apply_count;
            label2.text = model.resumes_count;
            label3.text = model.Interview_count;
        }
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
    }
    return self;
}


@end

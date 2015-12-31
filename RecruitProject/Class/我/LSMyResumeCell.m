//
//  LSMyResumeCell.m
//  RecruitProject
//
//  Created by sliu on 15/9/24.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSMyResumeCell.h"
#import "LSResumeModel.h"

@implementation LSMyResumeCell

- (void)awakeFromNib {
    // Initialization code
    _titleLB = [UILabel labelWithText:@"张三" color:color_black font:14 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_titleLB];
    _titleLB.originBy(10,0);
    _titleLB.sizeBy(150,40);
    
    
    _resumeNameLB = [UILabel labelWithText:@"默认" color:color_black font:14 Alignment:LSLabelAlignment_right];
    [self.contentView addSubview:_resumeNameLB];
    _resumeNameLB.frame = CGRectMake(SCREEN_WIDTH-30-35, 0, 30, 40);
     self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    _checkImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_checkImage];
    _checkImage.frame = CGRectMake(SCREEN_WIDTH-30-35-30, 10, 20, 20);
    [_checkImage setCornerRadius:10];
    _checkImage.backgroundColor = [UIColor clearColor];
    

    
}

-(void)configCell:(id)data
{
    if ([data isKindOfClass:[LSResumeModel class]]) {
        LSResumeModel *model =  (LSResumeModel *)data;
        _titleLB.text =  model.tb_title;
        if([model.tb_default integerValue]  == 1)
        {
             _checkImage.image = [UIImage imageNamed:@"radio_selected"];
            
        }else
        {
             _checkImage.image = [UIImage imageNamed:@"radio_normal"];
            
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

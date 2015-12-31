//
//  LSMapCell.m
//  RecruitProject
//
//  Created by sliu on 15/10/9.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSMapCell.h"

@implementation LSMapCell

- (void)awakeFromNib {
    // Initialization code
    self.imageView.image = [UIImage imageNamed:@"map"];
    self.textLabel.text = @"无";
    self.textLabel.font = [UIFont systemFontOfSize:12];
    self.textLabel.numberOfLines = 2;
    //查看地图
    UILabel *label = [UILabel labelWithText:nil color:color_black font:12 Alignment:LSLabelAlignment_right];
    label.frame = CGRectMake(0, 0, 60, 30);
    self.accessoryView = label;
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    return self;
}

-(void)configCell:(id)data
{
    self.textLabel.text = data;
}
@end

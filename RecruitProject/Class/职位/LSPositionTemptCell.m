//
//  LSPositionTemptCell.m
//  RecruitProject
//
//  Created by sliu on 15/10/9.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSPositionTemptCell.h"

@implementation LSPositionTemptCell
- (void)awakeFromNib {
    // Initialization code
    
    
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
     NSArray *titles = @[@"包吃住",@"周末双休",@"包吃住",@"周末双休"];
    if ([data isKindOfClass:[NSArray class]]) {
      titles =  data;
    }
  
    CGFloat X = 10;
    for (int i = 0; i < titles.count; i++) {
        NSString *title = titles[i];
        UILabel *label = [UILabel labelWithText:title color:color_black font:12 Alignment:LSLabelAlignment_center];
        [self.contentView addSubview:label];
        label.layer.borderColor = color_title_Gray.CGColor;
        label.layer.borderWidth = 0.4;
        [label setCornerRadius:3];
        CGFloat w  = [title getStrW:20 font:12]+10;
        label.frame = CGRectMake(X, 10, w, 20);
        X = X+10+w;
        
    }
   
}
@end

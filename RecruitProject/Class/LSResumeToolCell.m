//
//  LSResumeToolCell.m
//  RecruitProject
//
//  Created by sliu on 15/10/19.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSResumeToolCell.h"

@implementation LSResumeToolCell
- (void)awakeFromNib {
    // Initialization code
    self.contentView.backgroundColor = color_clear;
    self.backgroundColor = color_clear;
    
     self.selectionStyle  = UITableViewCellSelectionStyleNone;
    _collectionBtn = [UIButton buttonWithTitle:@"收藏简历" titleColor:color_black BackgroundColor:color_white action:^(UIButton *btn) {
        
    }];
    [_collectionBtn setTitle:@"取消收藏" forState:UIControlStateSelected];
      [_collectionBtn setImage:[UIImage imageNamed:@"icon_star_full_gray"] forState:UIControlStateSelected];
    [self.contentView addSubview:_collectionBtn];
    [_collectionBtn setImage:[UIImage imageNamed:@"icon_star_empty_gray"] forState:UIControlStateNormal];
    [_collectionBtn setfont:14];
    
    _phoneBtn = [UIButton buttonWithTitle:@"查看联系方式" titleColor:color_black BackgroundColor:color_white action:^(UIButton *btn) {
        
    }];
    [self.contentView addSubview:_phoneBtn];
    [_phoneBtn setImage:[UIImage imageNamed:@"icon_view_normal"] forState:UIControlStateNormal];
    [_phoneBtn setImage:[UIImage imageNamed:@"icon_view_active"] forState:UIControlStateSelected];
    [_phoneBtn setfont:14];
    CGFloat left = 20;
    CGFloat  W = (SCREEN_WIDTH-left*3)/2;
  
    _collectionBtn.frame = CGRectMake(left, 0, W, 30);
    _phoneBtn.frame  = CGRectMake(left+W+left, 0, W, 30);
    
    [_collectionBtn setCornerRadius:3];
    _collectionBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _collectionBtn.layer.borderWidth = 1;
    
    [_phoneBtn setCornerRadius:3];
    _phoneBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _phoneBtn.layer.borderWidth = 1;
    
}

-(void)configCell:(id)data
{
if([data isKindOfClass:[LSUserModel class]])
{
    LSUserModel *model = (LSUserModel *)data;
    if([model.is_fav isEqualToString:@"1"])
    {
        _collectionBtn.selected = YES;
    }else
    {
        _collectionBtn.selected = NO;
    }
    
    if([model.is_buy isEqualToString:@"1"])
    {
        _phoneBtn.selected = YES;
    }else
    {
        _phoneBtn.selected = NO;
    }
}

}


@end

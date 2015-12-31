//
//  LSBaseCell.h
//  RecruitProject
//
//  Created by sliu on 15/9/30.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LSBaseCellDelegate;
@interface LSBaseCell : UITableViewCell

@property (nonatomic ,strong) UIImageView *headImage;
@property (nonatomic ,strong) UILabel     *titleLB;
@property (nonatomic ,strong) UILabel     *detailLB;
@property (nonatomic ,strong) UILabel     *accessoryLB;

@end


@protocol LSBaseCellDelegate <NSObject>

-(void)baseCellAction:(LSBaseCell *)cell;

@end
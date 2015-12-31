//
//  LSPositionDetailCell.h
//  RecruitProject
//
//  Created by sliu on 15/9/22.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSPositionModel.h"

@interface LSPositionDetailCell : UITableViewCell

@property (nonatomic ,strong) UIImageView *headImage;
@property (nonatomic ,strong) UILabel     *titleLB;
@property (nonatomic ,strong) UILabel     *detailLB;

@end

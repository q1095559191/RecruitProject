//
//  LSPersonalHeadCell.h
//  RecruitProject
//
//  Created by sliu on 15/9/24.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSUserModel.h"
@interface LSPersonalHeadCell : UITableViewCell
@property (nonatomic ,strong) UIImageView *headImage;
@property (nonatomic ,strong) UILabel     *titleLB;
@property (nonatomic ,strong) UILabel     *detailLB;
@property (nonatomic ,strong) UIView      *progressBg;
@property (nonatomic ,strong) UIView      *progressView;
@end

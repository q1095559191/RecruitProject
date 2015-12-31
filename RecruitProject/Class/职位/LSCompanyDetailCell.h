//
//  LSCompanyDetailCell.h
//  RecruitProject
//
//  Created by sliu on 15/10/9.
//  Copyright (c) 2015年 sliu. All rights reserved.
//


//企业介绍
#import "LSUserModel.h"
@interface LSCompanyDetailCell : UITableViewCell

@property (nonatomic ,strong) UIImageView *headImage;
@property (nonatomic ,strong) UILabel     *titleLB;
@property (nonatomic ,strong) UILabel     *detailLB;

@property (nonatomic ,strong) UIButton     *attentionBtn;

@end

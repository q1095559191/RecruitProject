//
//  LSIntersetedCell.h
//  RecruitProject
//
//  Created by sliu on 15/9/24.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSInterstedModel.h"

@interface LSIntersetedCell : UITableViewCell

@property (nonatomic ,strong) UIImageView *headImage;         //头像
@property (nonatomic ,strong) UILabel     *titleLB;           //头像
@property (nonatomic ,strong) UILabel     *detailLB;
@property (nonatomic ,strong) UILabel     *positionLB;
@property (nonatomic ,strong) UIButton    *attentionBtn;

//2条动态
@property (nonatomic ,strong) UILabel     *nameLB1;
@property (nonatomic ,strong) UILabel     *titleLB1;
@property (nonatomic ,strong) UILabel     *timeLB1;

@property (nonatomic ,strong) UILabel     *nameLB2;
@property (nonatomic ,strong) UILabel     *titleLB2;
@property (nonatomic ,strong) UILabel     *timeLB2;

@end

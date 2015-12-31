//
//  LSNewFriendCell.h
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSInterstedModel.h"
@interface LSNewFriendCell : UITableViewCell
@property (nonatomic ,strong) UIImageView *headImage;
@property (nonatomic ,strong) UILabel     *titleLB;
@property (nonatomic ,strong) UILabel     *detailLB;
@property (nonatomic ,strong) UILabel     *positionLB;
@property (nonatomic ,strong) UIButton    *attentionBtn;

@end

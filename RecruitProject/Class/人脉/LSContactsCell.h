//
//  LSContactsCell.h
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSContactsModel.h"
#import "LSBaseModel.h"
@interface LSContactsCell : UITableViewCell
@property (nonatomic ,strong) UIImageView *headImage;
@property (nonatomic ,strong) UILabel     *titleLB;
@property (nonatomic ,strong) UILabel     *messageNumLB;
@property (nonatomic ,strong) UILabel     *tipLB;


@end

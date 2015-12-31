//
//  LSPositionCell.h
//  RecruitProject
//
//  Created by sliu on 15/9/21.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSPositionModel.h"

@interface LSPositionCell : UITableViewCell
@property (nonatomic,strong) UIImageView *positionImage;
@property (nonatomic,strong) UILabel *positionLB;
@property (nonatomic,strong) UILabel *timeLB;
@property (nonatomic,strong) UILabel *gongsiLB;
@property (nonatomic,strong) UILabel *priceLB;

@end

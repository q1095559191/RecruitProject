//
//  LSPositionApplyCell.h
//  RecruitProject
//
//  Created by sliu on 15/11/6.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSBaseCell.h"
#import "LSPositionModel.h"

@interface LSPositionApplyCell : LSBaseCell
@property (nonatomic,strong) UIImageView *positionImage;
@property (nonatomic,strong) UILabel *positionLB;
@property (nonatomic,strong) UILabel *timeLB;
@property (nonatomic,strong) UILabel *gongsiLB;
@property (nonatomic,strong) UILabel *priceLB;

@property (nonatomic ,strong)UIButton *stateBtn;
@end

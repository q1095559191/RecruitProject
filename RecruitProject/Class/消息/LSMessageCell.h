//
//  LSMessageCell.h
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSMessageModel.h"
#import "LSBaseCell.h"

@interface LSMessageCell : LSBaseCell

@property (nonatomic ,strong) UILabel     *timeLB;
@property (nonatomic ,strong) UIView      *bgView;
@property (nonatomic ,strong) UILabel     *showLB;
@property (nonatomic ,strong) UIView      *lineView;
//@property (nonatomic ,strong) UIImageView *arrowView;


@end

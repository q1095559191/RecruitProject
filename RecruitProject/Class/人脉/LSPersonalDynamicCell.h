//
//  LSPersonalDynamicCell.h
//  RecruitProject
//
//  Created by sliu on 15/9/24.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSDynamicModel.h"

@interface LSPersonalDynamicCell : UITableViewCell

@property (nonatomic ,strong) UIImageView *headImage;         //头像
@property (nonatomic ,strong) UILabel     *dynamicTypeLB;     //动态类型
@property (nonatomic ,strong) UILabel     *timeLB;            //动态时间
@property (nonatomic ,strong) UILabel     *titleLB;           //标题
@property (nonatomic ,strong) UILabel     *detailLB;          //内容

@property (nonatomic ,strong) UIButton     *deleBtn;          //删除按钮


@end

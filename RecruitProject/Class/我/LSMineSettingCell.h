//
//  LSMineSettingCell.h
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSMineSettingCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic ,strong) UILabel      *titleLB;
@property (nonatomic ,strong) UITextField  *detailTF;
@property (nonatomic ,strong) LSBaseModel  *modle;
@end

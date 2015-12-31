//
//  LSLSEditLanguageCell.h
//  RecruitProject
//
//  Created by sliu on 15/10/28.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSBaseCell.h"

@interface LSLSEditLanguageCell : LSBaseCell<UITextFieldDelegate>
@property (nonatomic ,strong) UITextField *levelLB;
@property (nonatomic ,strong) LSBaseModel  *model;
@end

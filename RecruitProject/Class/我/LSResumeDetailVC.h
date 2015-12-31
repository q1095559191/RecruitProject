//
//  LSResumeDetailVC.h
//  RecruitProject
//
//  Created by sliu on 15/9/24.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSBaseVC.h"

@interface LSResumeDetailVC : LSBaseVC
//  个人中心的简历

@property (nonatomic ,copy)NSString *resume_id;
@property (nonatomic ,assign) BOOL isEdit;

@end

//
//  LSResumeMimeSettingVC.h
//  RecruitProject
//
//  Created by sliu on 15/11/1.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSBaseVC.h"
#import "LSUserModel.h"
@interface LSResumeMimeSettingVC : LSBaseVC
@property (nonatomic,strong) LSUserModel *userModel;
@property (nonatomic ,copy)    NSString *resumes_id;
@end

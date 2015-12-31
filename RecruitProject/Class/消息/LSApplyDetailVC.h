//
//  LSApplyDetailVC.h
//  RecruitProject
//
//  Created by sliu on 15/11/6.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSBaseVC.h"
#import "LSMessageModel.h"

@interface LSApplyDetailVC : LSBaseVC
@property(nonatomic,strong)LSMessageModel *model;

@property(nonatomic,assign) BOOL     isApply;    //是否是邀请面试
@property(nonatomic,assign) NSString *resumes_id;
@property(nonatomic,assign) NSString *apply_id;
@end

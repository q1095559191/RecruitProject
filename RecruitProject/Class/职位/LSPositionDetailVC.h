//
//  LSPositionDetailVC.h
//  RecruitProject
//
//  Created by sliu on 15/9/21.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSBaseVC.h"
#import "LSPositionModel.h"

@interface LSPositionDetailVC : LSBaseVC

@property (nonatomic,strong) LSPositionModel *positionModel;
@property (nonatomic,copy)   NSString *openings_id;  //职位id

@end

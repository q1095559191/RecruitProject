//
//  LSUserModel.m
//  RecruitProject
//
//  Created by sliu on 15/9/25.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSUserModel.h"

@implementation LSUserModel
-(void)keyValuesDidFinishConvertingToObject
{
    self.is_friend = self.favflag;
}

@end

//
//  LSMessageNumModel.m
//  RecruitProject
//
//  Created by sliu on 15/11/19.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSMessageNumModel.h"

@implementation LSMessageNumModel
-(void)keyValuesDidFinishConvertingToObject
{
    if (!APPDELEGETE.isCompany) {
    self.messageNum = [NSString stringWithFormat:@"%ld",[self.p_num integerValue] + [self.s_num integerValue]];
    }else
    {
     self.messageNum = [NSString stringWithFormat:@"%ld",[self.c_num integerValue] + [self.s_num integerValue]];
    }

}


@end

//
//  LSInterstedModel.m
//  RecruitProject
//
//  Created by sliu on 15/10/8.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSInterstedModel.h"

@implementation LSInterstedModel
-(void)keyValuesDidFinishConvertingToObject
{
    if (ISNOTNILDIC(self.circle_info)) {
        self.circle_id  =   self.circle_info[@"circle_id"];
        self.member_id  =   self.circle_info[@"member_id"];
        self.tb_name  =   self.circle_info[@"tb_name"];
        self.tb_img  =   self.circle_info[@"tb_img"];
        self.tb_edittime  =   self.circle_info[@"tb_edittime"];
    }

}
@end

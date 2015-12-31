//
//  LSAttentionModel.m
//  RecruitProject
//
//  Created by sliu on 15/10/15.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSAttentionModel.h"

@implementation LSAttentionModel
-(void)keyValuesDidFinishConvertingToObject
{
    if (ISNOTNILDIC(self.member_info)) {
        self.image = self.member_info[@"img"];
        NSString *name = self.member_info[@"truename"];
        if ([self.member_info[@"type"] isEqualToString:@"1"]) {
        
        }else
        {
            if (![self.member_info[@"tb_jobtype_two"] isEqualToString:@"0"]) {
                 self.tb_jobtype_two  = [NSString stringWithFormat:@"[%@]",[NSObject getInfoDetail:self.member_info[@"tb_jobtype_two"]]];
            }
        }
        self.name = name;
        self.image = self.member_info[@"img"];
        self.userID = self.member_info[@"member_id"];
    }
}

@end

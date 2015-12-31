//
//  LSPositionModel.m
//  RecruitProject
//
//  Created by sliu on 15/10/8.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSPositionModel.h"

@implementation LSPositionModel
-(NSArray *)getRequireMesage
{
    NSMutableArray *titles= [NSMutableArray array];
    //工作性质
    if ([self.tb_worknature integerValue] != 0) {
        [titles addObject:[NSObject getInfoDetail:self.tb_worknature]];
    }else
    {
     [titles addObject:@"无"];
    }
    
    if ([self.tb_salary integerValue] != 0) {
        [titles addObject:[NSObject getInfoDetail:self.tb_salary]];
    }else
    {
        [titles addObject:@"面议"];
    }
    if (ISNOTNILSTR(self.tb_city)) {
        [titles addObject:self.tb_city];
    }else
    {
        [titles addObject:@"无"];
    }
    if (ISNOTNILSTR(self.tb_workyear)) {
        
        [titles addObject:[NSString stringWithFormat:@"%@",[NSObject getInfoDetail:self.tb_workyear]]];
    }else
    {
        [titles addObject:@"无"];
    }
    if (ISNOTNILSTR(self.tb_degree)) {
        [titles addObject:[NSObject getInfoDetail:self.tb_degree]];
    }else
    {
        [titles addObject:@"无要求"];
    }
    
    if (ISNOTNILSTR(self.tb_worknum)) {
        [titles addObject:[NSString stringWithFormat:@"%@人",self.tb_worknum]];
    }else
    {
        [titles addObject:@"无上线"];
    }
    return titles;
}


-(NSArray *)getWelfare
{
    NSArray *titles;
    if (ISNOTNILSTR(self.tb_welfare)) {
        NSString *str = self.tb_welfare;
        titles =  [str componentsSeparatedByString:@","];
    }
    return titles;
}
@end

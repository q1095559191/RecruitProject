//
//  LSCheckModel.m
//  RecruitProject
//
//  Created by sliu on 15/10/13.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSCheckModel.h"

@implementation LSCheckModel
-(void)empty
{
    self.tb_city = nil;
    self.tb_degree = nil;
    self.tb_jobtype = nil;
    self.tb_jobtype_two = nil;
    self.tb_salary = nil;
    self.tb_worknature = nil;
    self.tb_workyear = nil;
    self.dayscope = nil;
    self.keyword = nil;

    
}
-(NSString *)getAddress
{
    NSString *addressPath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:addressPath];
    NSArray *titles = [dict objectForKey:@"address"];
    if (self.index1 >= 0  && self.index2 >= 0) {
       return   titles[self.index1][@"sub"][self.index2][@"name"];
    }
    
    return nil;
}

-(NSInteger)getSeleted:(NSString *)str data:(NSArray *)data
{
    for (int i = 0; i < data.count; i++) {
      id obj = data[i];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            if ([str isEqual:obj[@"tb_id"]]) {
                return i;
            }
        }else
        {
            if ([str isEqual:obj]) {
                return i;
            }
        }       
    }
    return -1;
}

-(NSString *)getID:(NSInteger)i
{
    NSString *strID;
    switch (i) {
        case 1:
        {
            [NSObject getInfo:4];
        }
            break;
            
        default:
            break;
    }

    return strID;
}
@end

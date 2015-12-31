//
//  LSBaseModel.m
//  RecruitProject
//
//  Created by sliu on 15/9/30.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSBaseModel.h"

@implementation LSBaseModel

+(NSArray *)getBaseModels:(NSArray *)titles
{
    NSMutableArray *modles = [NSMutableArray array];
    for (NSString *str in titles) {
        LSBaseModel *modle = [[LSBaseModel alloc] init];
        modle.title = str;
        [modles addObject:modle];
    }
    return modles;
}

+(NSArray *)getBaseModels:(NSArray *)titles images:(NSArray *)images
{
    NSMutableArray *modles = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
       
        id obj1 = titles[i];
        if ([obj1 isKindOfClass:[NSString class]]) {
            LSBaseModel *modle = [[LSBaseModel alloc] init];
            modle.title = titles[i];
            modle.imageUrl = images[i];
            [modles addObject:modle];
        }
        
        if ([obj1 isKindOfClass:[NSArray class]]) {
            NSArray *objArr1 = (NSArray *)obj1;
            NSArray *objArr2 = (NSArray *)images[i];
            NSMutableArray *objArr = [NSMutableArray array];
            for (int j = 0; j < objArr1.count; j++) {
                LSBaseModel *modle = [[LSBaseModel alloc] init];
                modle.title = objArr1[j];
                modle.imageUrl = objArr2[j];
               [objArr addObject:modle];
            }
           [modles addObject:objArr];
        }
    
    }
  
    return modles;
}
@end

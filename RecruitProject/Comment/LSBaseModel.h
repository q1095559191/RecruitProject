//
//  LSBaseModel.h
//  RecruitProject
//
//  Created by sliu on 15/9/30.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSBaseModel : NSObject


@property (nonatomic ,assign) BOOL isSelected;
@property (nonatomic ,copy) NSString *type;      //0:输入的 1:选择的  3:输入电话
@property (nonatomic ,copy) NSString *index;     //标签
@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,copy) NSString *detailTile;
@property (nonatomic ,copy) NSString *imageUrl;
@property (nonatomic ,strong) NSMutableArray *subArr;

+(NSArray *)getBaseModels:(NSArray *)titles;
+(NSArray *)getBaseModels:(NSArray *)titles images:(NSArray *)images;



@end

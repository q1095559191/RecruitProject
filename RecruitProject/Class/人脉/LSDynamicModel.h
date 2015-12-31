//
//  LSDynamicModel.h
//  RecruitProject
//
//  Created by sliu on 15/10/15.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSDynamicModel : NSObject
@property (nonatomic ,copy) NSString *fromType;   // 1:个人主页  2:个人中心有删除


@property (nonatomic ,copy) NSString *truename;
@property (nonatomic ,copy) NSString *tb_type;
@property (nonatomic ,copy) NSString *tb_addtime;
@property (nonatomic ,copy) NSDictionary *ext_info;
@property (nonatomic ,copy) NSString *dynamic_id;
@property (nonatomic ,copy) NSString *tb_title;
@property (nonatomic ,copy) NSString *english;
@property (nonatomic ,copy) NSString *member_id;
@property (nonatomic ,copy) NSString *data_id;
@property (nonatomic ,copy) NSString *tb_outline;

@end

//
//  LSAttentionModel.h
//  RecruitProject
//
//  Created by sliu on 15/10/15.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSAttentionModel : NSObject
@property (nonatomic ,copy) NSString *side_id;
@property (nonatomic ,copy) NSString *tb_addtime;
@property (nonatomic ,copy) NSString *tb_read;
@property (nonatomic ,copy) NSString *social_id;
@property (nonatomic ,copy) NSString *member_id;
@property (nonatomic ,copy) NSString *tb_depth;

@property (nonatomic ,copy) NSDictionary *member_info;
@property (nonatomic ,copy) NSString *image;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *userID;
@property (nonatomic ,copy) NSString *tb_jobtype_two;

@end

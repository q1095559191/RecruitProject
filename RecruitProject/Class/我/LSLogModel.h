//
//  LSLogModel.h
//  RecruitProject
//
//  Created by sliu on 15/11/10.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSLogModel : NSObject

@property (nonatomic ,copy) NSString *id;
@property (nonatomic ,copy) NSString *member_id;
@property (nonatomic ,copy) NSString *data_id;
@property (nonatomic ,copy) NSString *type;
@property (nonatomic ,copy) NSString *log;
@property (nonatomic ,copy) NSString *time;

@end

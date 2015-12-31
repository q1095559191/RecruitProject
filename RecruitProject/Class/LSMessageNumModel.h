//
//  LSMessageNumModel.h
//  RecruitProject
//
//  Created by sliu on 15/11/19.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSMessageNumModel : NSObject

@property (nonatomic,copy) NSString *c_num;        //企业未读
@property (nonatomic,copy) NSString *p_num;        //个人未读
@property (nonatomic,copy) NSString *s_num;        //系统未读

@property (nonatomic,copy) NSString *messageNum;   //总的未读消息数

@end

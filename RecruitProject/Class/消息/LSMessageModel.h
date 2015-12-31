//
//  LSMessageModel.h
//  RecruitProject
//
//  Created by sliu on 15/11/4.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSMessageModel : NSObject
@property (nonatomic ,copy) NSString *msg_id;

@property (nonatomic ,copy) NSString *msg_title;
@property (nonatomic ,copy) NSString *msg_from_uid;
@property (nonatomic ,copy) NSString *msg_read;
@property (nonatomic ,copy) NSString *msg_type;
@property (nonatomic ,copy) NSString *msg_to_uid;
@property (nonatomic ,copy) NSString *msg_time;




@property (nonatomic ,strong) NSDictionary *member_info;
// --- >>消息来源者信息
@property (nonatomic ,copy) NSString *truename;
@property (nonatomic ,copy) NSString *img;



@property (nonatomic ,copy)   NSString *msg_txt;
// --- >>消息内容
@property (nonatomic ,strong) NSDictionary *otherDic;
@property (nonatomic ,copy)   NSString     *detailStr;
@property (nonatomic ,copy)   NSString     *detailSubStr;

@property (nonatomic ,copy)   NSString     *detailID;

@property (nonatomic ,copy)   NSString     *detailStr2;  //面试邀请

@property (nonatomic ,copy)   NSString     *showStr;     //去看看

@end

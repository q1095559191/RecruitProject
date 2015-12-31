//
//  LSInterstedModel.h
//  RecruitProject
//
//  Created by sliu on 15/10/8.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSInterstedModel : NSObject

//公共参数
@property (nonatomic ,copy) NSString *fromType; //1:感兴趣的人  2:感兴趣的圈子

@property (nonatomic ,strong) NSArray *circlepost_list;  //动态
@property (nonatomic ,copy)   NSString *circle_id;       //圈子ID
@property (nonatomic ,copy) NSString *member_id;
@property (nonatomic ,copy) NSString *tb_audit;
@property (nonatomic ,copy) NSString *tb_edittime;
@property (nonatomic ,copy) NSString *tb_name;
@property (nonatomic ,copy) NSString *tb_joinway;
@property (nonatomic ,copy) NSString *tb_notice;
@property (nonatomic ,copy) NSString *tb_default;
@property (nonatomic ,copy) NSString *tb_industry;
@property (nonatomic ,copy) NSString *tb_recommend;
@property (nonatomic ,copy) NSString *user_audit;
@property (nonatomic ,copy) NSString *english;
@property (nonatomic ,copy) NSString *tb_uptime;
@property (nonatomic ,copy) NSString *tb_img;
@property (nonatomic ,copy) NSString *tb_type;
@property (nonatomic ,copy) NSString *tb_info;
@property (nonatomic ,copy) NSString *tb_addtime;
@property (nonatomic ,strong) NSDictionary *circle_info;   //圈子信息



//感兴趣的人
@property (nonatomic ,copy)   NSString *tb_nickname;
@property (nonatomic ,copy)   NSString *id;
@property (nonatomic ,copy)   NSString *is_friend;           //是否是已经关注  1：已近加入
@property (nonatomic ,copy)   NSString *tb_time;
@property (nonatomic ,strong) NSDictionary *member_info;     //用户信息

//用户信息转换
@property (nonatomic ,copy) NSString *truename;
@property (nonatomic ,copy) NSString *img;
@property (nonatomic ,copy) NSString *tb_jobtype_two;      //工作职位
@property (nonatomic ,copy) NSString *member_info_id;      //用户ID

@end

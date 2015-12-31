//
//  LSPositionModel.h
//  RecruitProject
//
//  Created by sliu on 15/10/8.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSPositionModel : NSObject

//1:发现.职位  2:发现.简历  3:职位  4:简历  5:我发现的职位   6:谁看过我的职位 7:我发布的职位 8:我收藏、看过的简历
//9:我收到的简历  10:我的面试邀请
@property (nonatomic ,copy) NSString *fromType;
@property (nonatomic ,assign)  BOOL isSelected;   //
-(NSArray *)getRequireMesage;
-(NSArray *)getWelfare;




//公共字段
@property (nonatomic ,copy) NSString *tb_city;
@property (nonatomic ,copy) NSString *img;
@property (nonatomic ,copy) NSString *tb_workyear;
@property (nonatomic ,copy) NSString *tb_edittime;
@property (nonatomic ,copy) NSString *tb_worknature;
@property (nonatomic ,copy) NSString *tb_salary;
@property (nonatomic ,copy) NSString *com_img;
@property (nonatomic ,copy) NSString *is_fav;


@property (nonatomic ,copy) NSString *com_name; //公司名称





//职位
@property (nonatomic ,copy) NSString *tb_worknum;
@property (nonatomic ,copy) NSString *tb_degree;
@property (nonatomic ,copy) NSString *tb_welfare;
@property (nonatomic ,copy) NSString *tb_booknum;
@property (nonatomic ,copy) NSString *member_id;
@property (nonatomic ,copy) NSString *openings_id;      //职位ID
@property (nonatomic ,copy) NSString *tb_jobtype_two;
@property (nonatomic ,copy) NSString *tb_name;
@property (nonatomic ,copy) NSString *tb_audit;
@property (nonatomic ,copy) NSString *tb_description;
@property (nonatomic ,copy) NSString *tb_uptime;
@property (nonatomic ,copy) NSString *turename;
@property (nonatomic ,copy) NSString *english;
@property (nonatomic ,copy) NSString *tb_jobtype;

@property (nonatomic ,copy) NSString *jobs;
@property (nonatomic ,copy) NSString *business_time;

@property (nonatomic ,copy) NSString *tb_read; //0：未读 1:已读


//简历
@property (nonatomic ,copy) NSString *truename;
@property (nonatomic ,copy) NSString *position;
@property (nonatomic ,copy) NSString *tb_position;
@property (nonatomic ,copy) NSString *tb_workstate;
@property (nonatomic ,copy) NSString *resumes_id;
@property (nonatomic ,copy) NSString *apply_id;

//面试邀请
@property (nonatomic ,copy) NSString *tb_interviewaddress;
@property (nonatomic ,copy) NSString *tb_txt;
@property (nonatomic ,copy) NSString *interview_id;
@property (nonatomic ,copy) NSString *company_id;
@property (nonatomic ,copy) NSString *tb_state;
@property (nonatomic ,copy) NSString *tb_reading;
@property (nonatomic ,copy) NSString *tb_lxname;
@property (nonatomic ,copy) NSString *tb_companyname;
@property (nonatomic ,copy) NSString *tb_lxphone;




@end

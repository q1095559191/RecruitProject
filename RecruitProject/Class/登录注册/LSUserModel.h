//
//  LSUserModel.h
//  RecruitProject
//
//  Created by sliu on 15/9/25.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSUserModel : NSObject

@property (nonatomic ,assign) BOOL   isOpen;                   //是否显示全部信息
//other
@property (nonatomic ,copy) NSString *resume_task_completion;   //简历完成度

@property (nonatomic ,copy) NSString *is_fav;                  //是否收藏  0:未收藏

@property (nonatomic ,copy) NSString *is_buy;                  //是否查看  0:未查看

@property (nonatomic ,copy) NSString *is_friend;                //是否关注  0:未关注

@property (nonatomic ,copy) NSString *favflag;                  //是否关注  0:未关注

@property (nonatomic ,strong) NSMutableArray *record;             //个人简历

@property (nonatomic ,copy) NSString *tb_selfassessment;        //自我评价

@property (nonatomic ,copy) NSString *tb_foreignlanguage;       //语言能力

@property (nonatomic ,copy) NSString *tb_workstate;             //工作状态
@property (nonatomic ,copy) NSString *tb_salary;                //期望薪资
@property (nonatomic ,copy) NSString *tb_city;                  //工作地点
@property (nonatomic ,copy) NSString *tb_position;              //期望职位
@property (nonatomic ,copy) NSString *companyName;              //最近公司的名称
@property (nonatomic ,copy) NSString *tb_degree;                //学历
@property (nonatomic ,copy) NSString *tb_worknature;               //工作性质

//企业 个人共用字段
@property (nonatomic ,copy) NSString *resetpasswd;
@property (nonatomic ,copy) NSString *integral;
@property (nonatomic ,copy) NSString *remark;
@property (nonatomic ,copy) NSString *organizationcode;
@property (nonatomic ,copy) NSString *unittype;
@property (nonatomic ,copy) NSString *mobilecode;
@property (nonatomic ,copy) NSString *enposition;
@property (nonatomic ,copy) NSString *openings;
@property (nonatomic ,copy) NSString *unitname;
@property (nonatomic ,copy) NSString *certificationinc;
@property (nonatomic ,copy) NSString *type;
@property (nonatomic ,copy) NSString *industry;
@property (nonatomic ,copy) NSString *unitsize;
@property (nonatomic ,copy) NSString *codeinfo;
@property (nonatomic ,copy) NSString *sex;
@property (nonatomic ,copy) NSString *email;
@property (nonatomic ,copy) NSString *lasttime;
@property (nonatomic ,copy) NSString *position;
@property (nonatomic ,copy) NSString *inputname;
@property (nonatomic ,copy) NSString *truename;
@property (nonatomic ,copy) NSString *birthday;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *certificatecode;
@property (nonatomic ,copy) NSString *city;
@property (nonatomic ,copy) NSString *downfiles;
@property (nonatomic ,copy) NSString *emailcode;
@property (nonatomic ,copy) NSString *mobile;
@property (nonatomic ,copy) NSString *entruename;
@property (nonatomic ,copy) NSString *is_mobile;
@property (nonatomic ,copy) NSString *enindustry;
@property (nonatomic ,copy) NSString *qq;
@property (nonatomic ,copy) NSString *img;
@property (nonatomic ,copy) NSString *is_email;
@property (nonatomic ,copy) NSString *addresss;
@property (nonatomic ,copy) NSString *allintegral;
@property (nonatomic ,copy) NSString *friendssearch;
@property (nonatomic ,copy) NSString *limittime;
@property (nonatomic ,copy) NSString *ip;
@property (nonatomic ,copy) NSString *phone;
@property (nonatomic ,copy) NSString *time;
@property (nonatomic ,copy) NSString *topincs;
@property (nonatomic ,copy) NSString *amount;
@property (nonatomic ,copy) NSString *member_id;  //id

//个人信息
@property (nonatomic ,copy) NSString *token;
@property (nonatomic ,copy) NSString *passwd;


//企业用户信息
@property (nonatomic ,copy) NSString *tb_qq_openid;
@property (nonatomic ,copy) NSString *tb_jobtype;
@property (nonatomic ,copy) NSString *tb_jobtype_two;
@property (nonatomic ,copy) NSString *tb_weibo_openid;
@property (nonatomic ,copy) NSString *tb_quicklogin;
@property (nonatomic ,copy) NSString *tb_wx_openid;
@property (nonatomic ,copy) NSString *tb_growing;



//工作年限
@property (nonatomic ,copy) NSString *tb_workyear;




@end

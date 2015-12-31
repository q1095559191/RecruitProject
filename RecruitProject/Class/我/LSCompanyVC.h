//
//  LSCompanyVC.h
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSBaseVC.h"

@interface LSCompanyVC : LSBaseVC
//2
@property (nonatomic ,copy) NSString *tb_jobtype;
//风险管理
@property (nonatomic ,copy) NSString *tb_name;
//1
@property (nonatomic ,copy) NSString *tb_salary;
//包住,周末双休,房补
@property (nonatomic ,copy) NSString *tb_welfare;
//1437115873
@property (nonatomic ,copy) NSString *tb_edittime;
//0
@property (nonatomic ,copy) NSString *tb_jobtype_two;
//252
@property (nonatomic ,copy) NSString *openings_id;
//0
@property (nonatomic ,copy) NSString *english;
//全职
@property (nonatomic ,copy) NSString *tb_worknature;
//3
@property (nonatomic ,copy) NSString *tb_degree;
//.负责贵宾客户维护工作，为客户提供较好的理财体验及服务；
@property (nonatomic ,copy) NSString *tb_description;
//上海
@property (nonatomic ,copy) NSString *tb_city;
//1437115873
@property (nonatomic ,copy) NSString *tb_uptime;
//3
@property (nonatomic ,copy) NSString *tb_workyear;
//5
@property (nonatomic ,copy) NSString *tb_worknum;
//1
@property (nonatomic ,copy) NSString *tb_audit;
//0
@property (nonatomic ,copy) NSString *tb_booknum;
//472
@property (nonatomic ,copy) NSString *member_id;

@end

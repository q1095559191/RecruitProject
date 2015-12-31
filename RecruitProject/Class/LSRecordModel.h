//
//  LSRecordModel.h
//  RecruitProject
//
//  Created by sliu on 15/10/19.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSRecordModel : NSObject

@property (nonatomic ,assign) BOOL isEdit; //是否可以编辑

//工作经历@"3"    教育经历@"4"   语言能力：“1”  自我评价:@"2"
@property (nonatomic ,copy) NSString *tb_type;
@property (nonatomic ,copy) NSString *text;               //描述
@property (nonatomic ,strong)NSMutableArray *listArr;     //经历字典


@property (nonatomic ,copy) NSString *tb_unitname;
@property (nonatomic ,copy) NSString *tb_post;
@property (nonatomic ,copy) NSString *tb_salary;
@property (nonatomic ,copy) NSString *record_id;
@property (nonatomic ,copy) NSString *tb_txt;          //描述
@property (nonatomic ,copy) NSString *tb_industry;
@property (nonatomic ,copy) NSString *resumes_id;
@property (nonatomic ,copy) NSString *tb_startday;
@property (nonatomic ,copy) NSString *tb_endday;
@property (nonatomic ,copy) NSString *tb_unittype;
@property (nonatomic ,copy) NSString *tb_addtime;
@property (nonatomic ,copy) NSString *member_id;


@end

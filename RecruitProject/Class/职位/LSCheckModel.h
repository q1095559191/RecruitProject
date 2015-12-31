//
//  LSCheckModel.h
//  RecruitProject
//
//  Created by sliu on 15/10/13.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSCheckModel : NSObject

@property (nonatomic ,assign) NSInteger  index;       //选中状态

@property (nonatomic ,assign) NSInteger  index1;      //地址选中状态
@property (nonatomic ,assign) NSInteger  index2;      //地址选中状态

//职位搜索

@property (nonatomic,copy) NSString *dayscope;      //发布时间
@property (nonatomic,copy) NSString *tb_degree;     //最低学历
@property (nonatomic,copy) NSString *keyword;       //模糊搜索的字段
@property (nonatomic,copy) NSString *tb_city;       //地区

@property (nonatomic,copy) NSString *tb_jobtype;    //行业
@property (nonatomic,copy) NSString *tb_jobtype_two;//职位

@property (nonatomic,copy) NSString *tb_worknature; //工作性质
@property (nonatomic,copy) NSString *tb_workyear;   //工作经验


@property (nonatomic,copy) NSString *tb_salary;     //月薪范围
//


//获取当前选中状态
-(NSInteger)getSeleted:(NSString *)str data:(NSArray *)data;

//获取选择地址
-(NSString *)getAddress;
-(void)empty;


@end

//
//  LSTipModel.h
//  RecruitProject
//
//  Created by sliu on 15/11/5.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSTipModel : NSObject

//个人主页
@property (nonatomic ,copy) NSString *truename;
@property (nonatomic ,copy) NSString *img;
@property (nonatomic ,copy) NSString *position;
@property (nonatomic ,copy) NSString *apply_count;        //申请数量
@property (nonatomic ,copy) NSString *apply_job_count;    //应聘的职位数
@property (nonatomic ,copy) NSString *fav_count;          //我收藏的职位数
@property (nonatomic ,copy) NSString *resumes_count;      //简历数量
@property (nonatomic ,copy) NSString *unitname;

@property (nonatomic ,copy) NSString *Interview_count;

@property (nonatomic ,copy) NSString *dynamic_count;


//公司证明

@property (nonatomic ,copy) NSString *applyCount;   //申请数
@property (nonatomic ,copy) NSString *FavCount;     //收藏简历
@property (nonatomic ,copy) NSString *OpeningsCount;//发布的职位

@property (nonatomic ,copy) NSString *amount;        //账户金额
@property (nonatomic ,copy) NSString *downfiles;     //可下载
@property (nonatomic ,copy) NSString *openings;      //可发布
@property (nonatomic ,copy) NSString *topincs;       //可置顶

@property (nonatomic ,copy) NSString *IsnotreadCount;//未读数

@property (nonatomic ,copy) NSString *member_id;


@end

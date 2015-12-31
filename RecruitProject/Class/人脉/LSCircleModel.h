//
//  LSCircleModel.h
//  RecruitProject
//
//  Created by sliu on 15/10/13.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSCircleModel : NSObject

@property (nonatomic,assign)  BOOL isShow;                      //显示全部帖子内容
@property (nonatomic,assign)  BOOL isShowReply;                 //显示全部回复



@property (nonatomic ,copy) NSString *tb_title;
@property (nonatomic ,copy) NSString *tb_connet;
@property (nonatomic ,copy) NSArray         *comment_list;        //评论列表
@property (nonatomic ,copy) NSString *post_id;
@property (nonatomic ,copy) NSString *circle_id;
@property (nonatomic ,copy) NSString *tb_audit;                   //圈子是否通过审核
@property (nonatomic ,copy) NSString *interval_time;              //发帖时间

@property (nonatomic ,copy) NSString *tb_notice;
@property (nonatomic ,copy) NSString *tb_name;
@property (nonatomic ,copy) NSString *member_id;
@property (nonatomic ,copy) NSString *tb_info;
@property (nonatomic ,copy) NSString *tb_addtime;



@property (nonatomic ,copy) NSDictionary *member_info;
//发帖人信息
@property (nonatomic ,copy) NSString *img;
@property (nonatomic ,copy) NSString *truename;
@property (nonatomic ,copy) NSString *userID;


@property (nonatomic ,copy) NSString *tb_img;                     //帖子图片
@property (nonatomic ,strong) NSArray *imageArr;                     //帖子图片


@end

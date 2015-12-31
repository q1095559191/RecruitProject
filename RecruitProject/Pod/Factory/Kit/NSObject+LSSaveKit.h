//
//  NSObject+LSSaveKit.h
//  ShoppingProject
//
//  Created by admin on 15/8/3.
//  Copyright (c) 2015年 GuanYisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSBaseModel.h"
@interface NSObject (LSSaveKit)
//保存
-(void)saveDateWithKey:(NSString *)key;
//取出
+(id)getSaveDateWithKey:(NSString *)key;
+(void)removeSaveWithKey:(NSString *)key;

//发送通知
-(void)senderNotificationIndex:(NSString*)index userInfo:(NSDictionary *)dic;
//接收通知
-(void)addObserverIndex:(NSString*)index;

//接收通知事件，接受者去实现
-(void)notification:(NSNotification *)noti;

//打印属性
+(void)log:(NSDictionary *)dic;

//得到数据字典
//1:工作性质2:工作地点3:工作状态4:期望月薪5:工作经验6:学历7:薪资水平8:行业类别9:企业性质10:语种11:职位类别12:公司规模13:热搜职位14:热门搜索15:时间间隔16:行业职位 17:发布时间

+(NSArray *)getInfo:(NSInteger)index;
+(NSArray *)getInfoWithBaseModel:(NSInteger)index;

+(NSArray *)getInfoWithBaseModel:(NSInteger)index defineStr:(NSString *)str;
//所在职位
+(NSArray *)getInfoWithBaseModel2:(NSInteger)index defineStr:(NSString *)str;
+(NSString *)getInfoDetail:(NSString *)index;

//
+(NSMutableArray *)getBasemodel:(NSArray *)titles  define:(NSString *)str;


//转化时间
+(NSString *)getTime:(NSString *)str;
+(NSString *)getDetailTime:(NSString *)str;

@end

//
//  LSHttpKit.h
//  RecruitProject
//
//  Created by sliu on 15/9/25.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSHttpKit : NSObject
#pragma mark -通用GET请求
+(void)getMethod:(NSString *)methodStr
       parameters:(NSDictionary *)parameters
       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         ;
+(void)getMethod:(NSString *)methodStr parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success  failure:(void (^)(AFHTTPRequestOperation *, id))failure;

#pragma mark -通用POST请求
+(void)postMethod:(NSString *)methodStr parameters:(NSDictionary *)parameters   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success;

@end

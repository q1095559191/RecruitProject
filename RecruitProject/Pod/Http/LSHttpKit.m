//
//  LSHttpKit.m
//  RecruitProject
//
//  Created by sliu on 15/9/25.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSHttpKit.h"

@implementation LSHttpKit

+(NSMutableDictionary*)hangdleGetMethodStr:(NSString*)str
{
   NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
   //处理方法
    if (str) {
        //c=Personal&a=PrivacySettings
        NSArray *array = [str componentsSeparatedByString:@"&"];
        for (NSString *str1 in array) {
              NSArray *array1 = [str1 componentsSeparatedByString:@"="];
            if (array1.count == 2) {
                [dic setValue:array1[1] forKey:array1[0]];
            }
        }
        
    }

    //参数公共参数处理
    if(APPDELEGETE.user.member_id)
    {
        [dic setValue:APPDELEGETE.user.member_id forKey:@"member_id"];
    }
    if (APPDELEGETE.user.token) {
        [dic setValue:APPDELEGETE.user.token forKey:@"token"];
    }
    
    return dic;
}

+(void)getMethod:(NSString *)methodStr parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success  failure:(void (^)(AFHTTPRequestOperation *, id))failure
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    NSMutableDictionary *dic = [LSHttpKit hangdleGetMethodStr:methodStr] ;
    [dic setValuesForKeysWithDictionary:parameters];
    
    [manager GET:URL_Base parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"url=\n%@",operation.request.URL);
        if ([responseObject[@"success"] integerValue]  == 0) {
            
            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            NSLog(@"%@",responseObject[@"msg"]);
        }else
        {
            if (success) {
                success(operation,responseObject);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];

}


+(void)getMethod:(NSString *)methodStr parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    NSMutableDictionary *dic = [LSHttpKit hangdleGetMethodStr:methodStr] ;
    [dic setValuesForKeysWithDictionary:parameters];
  
    [manager GET:URL_Base parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"url=\n%@",operation.request.URL);
        
        if ([responseObject[@"success"] integerValue]  == 0) {
            
            
            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [operation.request.URL senderNotificationIndex:@"LSQequestFailure" userInfo:@{@"URL": operation.request.URL,@"msg":responseObject[@"msg"]
                                                                                              }];
                
            });
            
        }else
        {
            if (success) {
               success(operation,responseObject);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
        [operation.request.URL senderNotificationIndex:@"LSQequestFailure" userInfo:@{@"URL": operation.request.URL}];
         NSLog(@"url=\n%@",operation.request.URL);
    }];
  
}

+(void)postMethod:(NSString *)methodStr parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    [NSSet setWithObjects:@"text/html",@"text/plain",@"text/json", nil];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    //参数处理
    if(APPDELEGETE.user.member_id)
    {
        [dic setValue:APPDELEGETE.user.member_id forKey:@"member_id"];
    }
    if (APPDELEGETE.user.token) {
        [dic setValue:APPDELEGETE.user.token forKey:@"token"];
    }
    //处理URL
    NSString *url;
    if (methodStr) {
    url = [NSString stringWithFormat:@"%@?%@",URL_Base,methodStr];
    }else
    {
    url = URL_Base;
    }

    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject){
        if (success) {
            success(operation,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [SVProgressHUD showErrorWithStatus:@"网络异常"];
        NSString *postUrl = nil;
        for (int i = 0; i < [[dic allKeys] count]; i++) {
            NSString *key = [dic allKeys][i];
            NSString *values = [dic allValues][i];
            NSString *str = [NSString stringWithFormat:@"%@=%@",key,values];
            if (i==0) {
                postUrl = [NSString stringWithFormat:@"%@?%@",operation.request.URL,str];
            }else
            {
              postUrl = [NSString stringWithFormat:@"%@&%@",postUrl,str];
            }
        }
        NSLog(@"POSTURL = \n %@",postUrl);
    }];
}



@end

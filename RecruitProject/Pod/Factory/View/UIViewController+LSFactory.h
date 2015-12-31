//
//  UIViewController+LSFactory.h
//  RecruitProject
//
//  Created by sliu on 15/9/21.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LSFactory)

//添加子视图
-(void)creatContentView;

//设置子视图布局
-(void)settingViewLayouts;

//网络请求
-(void)httpRequest;


//图片上传成功
-(void)postImageSuccess:(NSString *)type  imageUrl:(NSString *)url;


@end

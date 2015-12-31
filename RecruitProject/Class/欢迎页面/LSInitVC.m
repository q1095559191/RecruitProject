//
//  LSInitVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/26.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSInitVC.h"

@interface LSInitVC ()
{
    UIImageView *bgImageView;
}
@end

@implementation LSInitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    bgImageView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"start_1242x2208"]];
    
    [self.view addSubview:bgImageView];
    bgImageView.edge(0,0,0,0);
    
    
    //获取字典数据
    NSDictionary *dic = @{@"c": @"Index",
                          @"a":@"dictKV"};
    [LSHttpKit getMethod:nil parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSDictionary *dataDic = responseObject[@"data"] ;
         [dataDic saveDateWithKey:LSSAVE_Info_dic];
      
    }];
 
    //获取字典数据
    NSDictionary *dic1 = @{@"c": @"Index",
                          @"a":@"dictInfo"};
    [LSHttpKit getMethod:nil parameters:dic1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dataDic = responseObject[@"data"] ;
         [dataDic saveDateWithKey:LSSAVE_dictInfo];
      
    }];

    
    NSString *name = [NSObject getSaveDateWithKey:LSSAVE_USERNAME];
    NSString *password = [NSObject getSaveDateWithKey:LSSAVE_USERPASSWORD];
    
    if (password && name) {
     //登录
        [APPDELEGETE loginName:name passWord:password];
    }else
    {
        [APPDELEGETE showLogin];
    }
    
    
}



@end

//
//  LSRegister1VC.m
//  ERentHousekeeper
//
//  Created by admin on 15/8/20.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSRegister1VC.h"
#import "LSRegister2VC.h"

@interface LSRegister1VC ()
{
    UITextField *phoneTF;
    UIButton   *nextBtn;
}
@end

@implementation LSRegister1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.title = @"注册（1/2）";
  
    
}

-(void)creatContentView
{
    
    phoneTF = [[UITextField alloc] init];
    phoneTF.placeholder = @"请输入手机号";
    phoneTF.backgroundColor = color_white;
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneTF.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:phoneTF];
   
    nextBtn = [UIButton buttonWithTitle:@"下一步" titleColor:[UIColor whiteColor] BackgroundColor:color_main action:^(UIButton *btn) {
        if (phoneTF.text.length != 11) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
            return ;
        }
        //发送验证码
        [LSHttpKit getMethod:nil parameters:@{@"mobile": phoneTF.text,
                                              @"c":@"member",
                                              @"a":@"sendSMS"
                                                      } success:^(AFHTTPRequestOperation *operation, id responseObject) {

                                                      }];
        LSRegister2VC *register2VC = [[LSRegister2VC alloc] init];
        register2VC.phoneStr = phoneTF.text;
        [self.navigationController pushViewController:register2VC animated:YES];
       
    }];
    [self.view addSubview:nextBtn];
}

-(void)settingViewLayouts
{
    CGFloat leftSpacing  = 10;
    CGFloat W    = 35;
    phoneTF.edgeNearTop(20,leftSpacing,leftSpacing,W);
    
    nextBtn.edgeNearTop(-1,leftSpacing,leftSpacing,W);
    nextBtn.top = phoneTF.bottom.offset(15);
}


@end

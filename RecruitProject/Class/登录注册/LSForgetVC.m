//
//  LSForgetVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/21.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSForgetVC.h"
@interface LSForgetVC ()
{
    UITextField *codeTF;
    UITextField *passWordTF;
    NSArray     *titles;
    UIButton    *submitBtn;
    UIButton    *getCodeBtn;
    NSTimer     *timer;
    NSInteger   timeNum;
    UITextField *phoneTF;
}
@end

@implementation LSForgetVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"忘记密码";
    
}


-(void)creatContentView
{
    phoneTF = [[UITextField alloc] init];
    phoneTF.placeholder = @"请输入手机号";
    phoneTF.backgroundColor = color_white;
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneTF.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:phoneTF];
    
    titles = @[@"请输入验证码",@"密码（由字母数字或下划线组成）"];
    codeTF = [[UITextField alloc] init];
    codeTF.placeholder = titles[0];
    codeTF.backgroundColor = color_white;
    codeTF.keyboardType  = UIKeyboardTypeNumberPad;
    [self.view addSubview:codeTF];
    codeTF.clearButtonMode = UITextFieldViewModeAlways;
    
    passWordTF = [[UITextField alloc] init];
    passWordTF.placeholder = titles[1];
    passWordTF.backgroundColor = color_white;
    [self.view addSubview:passWordTF];
    passWordTF.secureTextEntry = YES;
    UIView *rightView = [[UIView alloc] init];
    UIButton *rightBtn = [UIButton buttonWithImage:@"label_view_normal" action:^(UIButton *btn) {
        if (btn.selected) {
            passWordTF.secureTextEntry = YES;
            btn.selected = NO;
        }else
        {   passWordTF.secureTextEntry = NO;
            btn.selected = YES;
        }
    }];
    [rightBtn setImage:[UIImage imageNamed:@"icon_view_normal"] forState:UIControlStateSelected];
    [rightView addSubview:rightBtn];
    passWordTF.rightView = rightView;
    passWordTF.rightViewMode = UITextFieldViewModeAlways;   // 同上
    rightBtn.frame = CGRectMake(10, 10, 20, 20);
    rightView.frame = CGRectMake(0, 0, 40, 40);
    
    submitBtn = [UIButton buttonWithTitle:@"完成" titleColor:[UIColor whiteColor] BackgroundColor:color_main action:^(UIButton *btn) {
        
        if (ISNILSTR(codeTF.text)) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确验证码"];
            return ;
        }
        if (ISNILSTR(passWordTF.text) ) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确密码"];
            return ;
        }
        
        if (phoneTF.text.length != 11) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
            return ;
        }
        
        [LSHttpKit getMethod:@"c=member&a=resetPasswd" parameters:@{@"name": phoneTF.text,
                                              @"passwd": passWordTF.text,
                                              @"verify": codeTF.text,
                                              
                                                            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                  [self.phoneStr saveDateWithKey:LSSAVE_USERNAME];
                                                  [passWordTF.text saveDateWithKey:LSSAVE_USERPASSWORD];
                                                  [APPDELEGETE loginName:phoneTF.text passWord:passWordTF.text];
                                                  [SVProgressHUD showSuccessWithStatus:@"密码重设成功"];
                                              }];
    }];
    [self.view addSubview:submitBtn];
    timeNum  = 60;
    getCodeBtn = [UIButton buttonWithTitle:[NSString stringWithFormat:@"获取验证码"] titleColor:[UIColor whiteColor] BackgroundColor:color_main action:^(UIButton *btn) {
        //发送验证码
        if (phoneTF.text.length != 11) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
            return ;
        }
        
        [LSHttpKit getMethod:nil parameters:@{@"mobile": phoneTF.text,
                                              @"c":@"member",
                                              @"a":@"sendSMS"
                                              } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                
                                             }];
        btn.enabled = NO;
        timeNum  = 60;
        if(!timer)
        {
          timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Countdown) userInfo:nil repeats:YES];
        }
      
    }];
    
    [self.view addSubview:getCodeBtn];
    
}


-(void)Countdown{
    
    if (timeNum > 0) {
        timeNum--;
        [getCodeBtn setTitle:[NSString stringWithFormat:@"%li秒后可重发",(long)timeNum] forState:UIControlStateNormal];
        getCodeBtn.enabled  = NO;
        getCodeBtn.backgroundColor = [UIColor grayColor];
    }
   
    
    if(timeNum==0){
        [timer invalidate];
        [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        getCodeBtn.enabled  = YES;
        getCodeBtn.backgroundColor = color_main;
    }
    
    
}

-(void)settingViewLayouts
{
   
    CGFloat leftSpacing  = 10;
    CGFloat W    = 35;
    phoneTF.edgeNearTop(20,leftSpacing,leftSpacing,W);
    

    CGFloat top = 65;
    
  
    
    getCodeBtn.edgeNearTop(top,-1,leftSpacing,W);
    getCodeBtn.sizeBy(120,-1);
    
    codeTF.edgeNearTop(top,leftSpacing,-1,W);
    codeTF.right = getCodeBtn.left.offset(-20);
    
    passWordTF.edgeNearTop(-1,leftSpacing,leftSpacing,W);
    passWordTF.top = codeTF.bottom.offset(15);
    
    submitBtn.edgeNearTop(-1,leftSpacing,leftSpacing,W);
    submitBtn.top = passWordTF.bottom.offset(15);
    
    
}
@end

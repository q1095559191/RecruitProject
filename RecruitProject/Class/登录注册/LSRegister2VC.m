//
//  LSRegister2VC.m
//  ERentHousekeeper
//
//  Created by admin on 15/8/20.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSRegister2VC.h"

@interface LSRegister2VC ()
{
    UITextField *codeTF;
    UITextField *passWordTF;
    NSArray     *titles;
    UIButton    *submitBtn;
    UIButton    *getCodeBtn;
    NSTimer     *timer;
    NSInteger   timeNum;

}
@end

@implementation LSRegister2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册（2/2）";
    
}

-(void)creatContentView
{
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
        
       [LSHttpKit getMethod:nil parameters:@{@"name": self.phoneStr,
                                                 @"passwd": passWordTF.text,
                                                 @"verify": codeTF.text,
                                                 @"c":@"member",
                                                 @"a":@"add"
                                                } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                    [self.phoneStr saveDateWithKey:LSSAVE_USERNAME];
                                                    [passWordTF.text saveDateWithKey:LSSAVE_USERPASSWORD];
                                                    [APPDELEGETE loginName:self.phoneStr passWord:passWordTF.text];
                                                    [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                                               
                                                }];
            }];
    [self.view addSubview:submitBtn];
     timeNum  = 60;
     timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Countdown) userInfo:nil repeats:YES];
    getCodeBtn = [UIButton buttonWithTitle:[NSString stringWithFormat:@"%li秒后可重发",(long)timeNum] titleColor:[UIColor whiteColor] BackgroundColor:color_main action:^(UIButton *btn) {
        //发送验证码
        [LSHttpKit getMethod:nil parameters:@{@"mobile": self.phoneStr,
                                                      @"c":@"member",
                                                      @"a":@"sendSMS"
                                                      } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                          
                                                      }];
    timeNum  = 60;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Countdown) userInfo:nil repeats:YES];
    }];
    
  
    [self.view addSubview:getCodeBtn];

}


-(void)Countdown{
   
    timeNum--;
    [getCodeBtn setTitle:[NSString stringWithFormat:@"%li秒后可重发",(long)timeNum] forState:UIControlStateNormal];
    getCodeBtn.enabled  = NO;
    getCodeBtn.backgroundColor = [UIColor grayColor];
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
  
    getCodeBtn.edgeNearTop(20,-1,leftSpacing,W);
    getCodeBtn.sizeBy(120,-1);
    
    codeTF.edgeNearTop(20,leftSpacing,-1,W);
    codeTF.right = getCodeBtn.left.offset(-20);
    
    passWordTF.edgeNearTop(-1,leftSpacing,leftSpacing,W);
    passWordTF.top = codeTF.bottom.offset(15);
    
    submitBtn.edgeNearTop(-1,leftSpacing,leftSpacing,W);
    submitBtn.top = passWordTF.bottom.offset(15);


}

@end

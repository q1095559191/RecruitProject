//
//  LSLoginVC.m
//  ERentHousekeeper
//
//  Created by admin on 15/8/20.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSLoginVC.h"
#import "LSRegister1VC.h"
#import "LSForgetVC.h"
#import "LSBaseTabBarVC.h"
#import "LSUserModel.h"


@interface LSLoginVC ()
{
    UITextField *nameTF;
    UITextField *passWordTF;
    NSArray     *titles;
    UIButton    *loginBtn;
    UILabel     *forgetLB;
    UILabel     *registerLB;
    
}
@end

@implementation LSLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"登录";
 
}


-(void)creatContentView
{
    titles = @[@"请输入手机号/邮箱",@"请输入密码"];
    
    nameTF = [[UITextField alloc] init];
    UIImageView *leftImg1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"label_user_normal"]];
   
    
    UIView *leftView1 = [[UIView alloc] init];
    leftView1.backgroundColor = [UIColor clearColor];
    leftView1.frame= CGRectMake(0, 0, 40, 40);
    [leftView1 addSubview:leftImg1];
    leftImg1.edge(10,10,10,10);
    
   
    nameTF.leftView = leftView1;
    nameTF.leftViewMode = UITextFieldViewModeAlways;   // 同上
    nameTF.clearButtonMode = UITextFieldViewModeAlways;
    nameTF.placeholder = titles[0];
    nameTF.backgroundColor = color_white;
    [self.view addSubview:nameTF];
   
    passWordTF = [[UITextField alloc] init];
    passWordTF.placeholder = titles[1];
    UIImageView *leftImg2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"label_password_normal"]];
    leftImg2.frame = CGRectMake(10, 0, 20, 20);
    
    UIView *leftView2 = [[UIView alloc] init];
    leftView2.backgroundColor = [UIColor clearColor];
    leftView2.frame= CGRectMake(0, 0, 40, 40);
    [leftView2 addSubview:leftImg2];
    leftImg2.edge(10,10,10,10);
    passWordTF.leftView = leftView2;
    passWordTF.leftViewMode = UITextFieldViewModeAlways;   // 同上
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
    
    
    passWordTF.backgroundColor = color_white;
    [self.view addSubview:passWordTF];
    
    
    NSString *name = [NSObject getSaveDateWithKey:LSSAVE_USERNAME];
//    NSString *password = [NSObject getSaveDateWithKey:LSSAVE_USERPASSWORD];
    
    if (name) {
        //登录
        nameTF.text = name;
    }
    

    loginBtn = [UIButton buttonWithTitle:@"登录" titleColor:[UIColor whiteColor] BackgroundColor:color_main action:^(UIButton *btn) {
        if (ISNILSTR(nameTF.text)) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的用户名"];
            return ;
        }
      
        if (ISNILSTR(passWordTF.text)) {
          [SVProgressHUD showErrorWithStatus:@"请输入正确的密码"];
            return;
        }
           
        [APPDELEGETE loginName:nameTF.text passWord:passWordTF.text];
    }];
    [self.view addSubview:loginBtn];
    
    forgetLB = [UILabel labelWithText:@"忘记密码" color:color_title_main font:14 Alignment:LSLabelAlignment_left];
    [self.view addSubview:forgetLB];
    
    registerLB = [UILabel labelWithText:@"还没有账号? 立即注册" color:color_title_main font:14 Alignment:LSLabelAlignment_right];
    [self.view addSubview:registerLB];
    
    [registerLB settingSub:@"还没有账号?" color:[UIColor lightGrayColor] font:14];
    [nameTF setCornerRadius:3];
    [passWordTF setCornerRadius:3];
    [loginBtn setCornerRadius:3];
    
    registerLB.userInteractionEnabled = YES;
    [registerLB bk_whenTapped:^{
        LSRegister1VC *register1VC = [[LSRegister1VC alloc] init];
        [self.navigationController pushViewController:register1VC animated:YES];
    }];
    
    forgetLB.userInteractionEnabled = YES;
    [forgetLB bk_whenTapped:^{
        LSForgetVC *forgetVC = [[LSForgetVC alloc] init];
        [self.navigationController pushViewController:forgetVC animated:YES];
    }];
    
}

-(void)settingViewLayouts
{
    CGFloat leftSpacing  = 10;
    CGFloat W    = 45;
    
    nameTF.edgeNearTop(20,leftSpacing,leftSpacing,W);
    
    passWordTF.edgeNearTop(-1,leftSpacing,leftSpacing,W);
    passWordTF.top = nameTF.bottom.offset(15);
    
    loginBtn.edgeNearTop(-1,leftSpacing,leftSpacing,W);
    loginBtn.top = passWordTF.bottom.offset(15);
    
    forgetLB.edgeNearTop(-1,leftSpacing,-1,W);
    forgetLB.top = loginBtn.bottom.offset(15);
    forgetLB.sizeBy(150,-1);
    
    registerLB.edgeNearTop(-1,-1,leftSpacing,W);
    registerLB.top = loginBtn.bottom.offset(15);
    registerLB.sizeBy(150,-1);
    
}

@end

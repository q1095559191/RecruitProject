//
//  LSEditEvaluation.m
//  RecruitProject
//
//  Created by sliu on 15/10/28.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSEditEvaluation.h"

@interface LSEditEvaluation ()
{
    LSBaseTextView *textView;
}
@end

@implementation LSEditEvaluation

- (void)viewDidLoad {
    [super viewDidLoad];
    textView = [[LSBaseTextView alloc] init];
    [textView creatTextView];
    textView.placeholderLB.text = @"请填写自我评价";
    
    textView.maxNum = 200;
    [self.view addSubview:textView.textView];
    textView.textView.edgeNearTop(0,0,0,100);
    textView.maxNumLB.frame = CGRectMake(0, 70, SCREEN_WIDTH-10, 30);
    if ([self.evaluationStr isEqualToString:@"请填写您的自我评价"]) {
        
    }else
    {
        [textView setTextStr:self.evaluationStr];
        
    }
    
    UIButton *btn = [UIButton buttonWithTitle:@"保存" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
        if (ISNILSTR(textView.textView.text)) {
            [SVProgressHUD showErrorWithStatus:@"请输入自我评价内容"];
        }else
        {
             [self.parDic setObject:textView.textView.text forKey:@"tb_selfassessment"];
           
        }
        [self.parDic setObject:self.resumes_id forKey:@"resumes_id"];
        [LSHttpKit getMethod:@" c=Personal&a=ModifiedSelfEvaluation" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
      
        
    }];
    [self.view addSubview:btn];
    btn.edgeNearbottom(0,0,0,30);
    
    
}


@end

//
//  LSSendPostVC.m
//  RecruitProject
//
//  Created by sliu on 15/10/12.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSSendPostVC.h"
@interface LSSendPostVC ()<UITextViewDelegate>
{
   UIButton *sendBtn;
   UITextView *titleTV;
   UITextView *contentTV;
   NSMutableArray *imageArr;
   UIImageView *addView;
}
@end
@implementation LSSendPostVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    imageArr = [NSMutableArray array];
    sendBtn = [UIButton buttonWithTitle:@"立即发表" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
        if (ISNILSTR(titleTV.text)) {
            [SVProgressHUD showErrorWithStatus:@"请输入标题"];
        }
        if (ISNILSTR(contentTV.text)) {
            [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        }
         [self.parDic setObject:@"Circlepost" forKey:@"c"];
         [self.parDic setObject:@"newPost" forKey:@"a"];
         [self.parDic setObject:self.circle_id forKey:@"circle_id"];
         [self.parDic setObject:titleTV.text forKey:@"post_title"];
         [self.parDic setObject:contentTV.text forKey:@"post_content"];
         NSString *post_img;
         for (NSString *image in imageArr) {
             if (!post_img) {
                 post_img = [NSString stringWithFormat:@"%@",image];
             }else
             {
                 post_img = [NSString stringWithFormat:@"%@,%@",post_img,image];
             }
         }
         if (post_img) {
            [self.parDic setObject:post_img forKey:@"post_img"];
          }
        
        [LSHttpKit getMethod:nil parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:responseObject[@"msg"]];
            [self.navigationController popViewControllerAnimated:YES];
         }];
    }];
    [self.view addSubview:sendBtn];
    sendBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 60 - 40, SCREEN_WIDTH, 40);
    [sendBtn setCornerRadius:3];
}

-(void)creatContentView
{
    CGFloat top  = 20;
    CGFloat left  = 15;
    
    UILabel *titleLB  = [UILabel labelWithText:@"标题(必填)" color:color_black font:14 Alignment:LSLabelAlignment_left];
    [self.view addSubview:titleLB];
    [titleLB settingSub:@"(必填)" color:color_main font:14];
  
    
    UILabel *contentLB  = [UILabel labelWithText:@"内容(必填)" color:color_black font:14 Alignment:LSLabelAlignment_left];
    [self.view addSubview:contentLB];
    [contentLB settingSub:@"(必填)" color:color_main font:14];
  
    
    titleTV = [[UITextView alloc] init];
    [self.view addSubview:titleTV];
    [titleLB setCornerRadius:3];
  
    contentTV = [[UITextView alloc] init];
    [self.view addSubview:contentTV];
    [contentTV setCornerRadius:3];
    
    titleLB.frame = CGRectMake(left, top, 200, 30);
    contentLB.frame = CGRectMake(left, top+35+40, 200, 30);
    
    titleTV.frame = CGRectMake(left, top+35, SCREEN_WIDTH-30, 30);
    contentTV.frame = CGRectMake(left, top+35+35+40, SCREEN_WIDTH-30, 60);
 
    addView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_add_label"]];
    [self.view addSubview:addView];
    addView.frame =  CGRectMake(left, top+35+35+40+70, 50, 50);
    addView.userInteractionEnabled = YES;
    [addView bk_whenTapped:^{
    //
        [contentTV resignFirstResponder];
        [titleTV resignFirstResponder];
        
        if(imageArr.count < 4)
        {
         [self postImage:@"circle_post_img"];
        }else
        {
          [SVProgressHUD showInfoWithStatus:@"最多只能上传4张图片"];
        }
    }];
 
}


-(void)postImageSuccess:(NSString *)type imageUrl:(NSString *)url
{
    [imageArr addObject:url];
    [self creatImages];

}

-(void)creatImages
{
    CGFloat top   = 20;
    CGFloat left  = 15;
    for (int i = 0; i <imageArr.count; i++) {
        UIImageView *imageView  = (UIImageView *)[self.view viewWithTag:33+i];
        if (!imageView) {
            imageView = [[UIImageView alloc] init];
            [self.view addSubview:imageView];
            [imageView setImageWithURL:[NSURL URLWithString:imageArr[i]] placeholderImage:nil];
            imageView.frame =  CGRectMake(left+i*60, top+35+35+40+70, 50, 50);
            imageView.tag = 33+i;
        }
    }
    addView.frame =  CGRectMake(left+imageArr.count*60, top+35+35+40+70, 50, 50);
}


@end

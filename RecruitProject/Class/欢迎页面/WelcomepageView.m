//
//  WelcomepageView.m
//  ShoppingProject
//  引导页面    （第一次启动加载）
//  Created by zhangfan on 14-9-3.
//  Copyright (c) 2014年 GuanYisoft. All rights reserved.
//

#import "WelcomepageView.h"

@interface WelcomepageView ()
{

}

@end

@implementation WelcomepageView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
     self.imageArr = @[@"start_01_1242x2208",@"start_02_1242x2208",@"start_03_1242x2208"];
    [self CreateScrollview];
   
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [Myscrollview removeFromSuperview];
     Myscrollview = nil;
}

/* 创建 Scrollview */
-(void)CreateScrollview
{
    //初始化UIScrollView，设置相关属性，均可在storyBoard中设置
    Myscrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    Myscrollview.backgroundColor=[UIColor clearColor];
    Myscrollview.pagingEnabled=YES;//以页为单位滑动，即自动到下一页的开始边界
    Myscrollview.showsVerticalScrollIndicator=NO;
    Myscrollview.showsHorizontalScrollIndicator=NO;//隐藏垂直和水平显示条
    [Myscrollview setBounces:NO];

    /* 拖动属性 */
    if (self.imageArr.count <= 1)
    {
        Myscrollview.scrollEnabled = NO;
    }
    else
    {
        Myscrollview.scrollEnabled = YES;
    }
    

    CGFloat Width=Myscrollview.frame.size.width;
    CGFloat Height=Myscrollview.frame.size.height;
    
    for (int i=0; i<[self.imageArr count]; i++)
    {
        UIImageView *subViews=[[UIImageView alloc] init];
        subViews.userInteractionEnabled = YES;   /* 打开imageview的点击属性 */
        subViews.tag = 10001 + i;
        subViews.frame=CGRectMake(Width*i, 0, Width, Height);
        [Myscrollview addSubview: subViews];
        
        subViews.image = [UIImage imageNamed:self.imageArr[i]];
        
        if (i == [self.imageArr count]-1)
        {
         
            UIButton *backButton = [UIButton buttonWithTitle:@"进入" titleColor:color_main BackgroundColor:color_clear action:^(UIButton *btn) {
                //进入APP
                 [APPDELEGETE showMain];
            }];
            backButton.layer.borderColor = color_bg_yellow.CGColor;
            backButton.layer.borderWidth = 1;
            backButton.frame = CGRectMake(SCREEN_WIDTH*i+(SCREEN_WIDTH-80)/2, SCREEN_HEIGHT - 50, 80, 30);
            [backButton setCornerRadius:3];
            [Myscrollview addSubview:backButton];
        }
    }
    
    [Myscrollview setContentSize:CGSizeMake(Width*self.imageArr.count, Height)];
    [self.view addSubview:Myscrollview];

}

@end

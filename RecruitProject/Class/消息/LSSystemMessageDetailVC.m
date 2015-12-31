//
//  LSSystemMessageDetailVC.m
//  RecruitProject
//
//  Created by sliu on 15/11/4.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSSystemMessageDetailVC.h"

@interface LSSystemMessageDetailVC ()

@end

@implementation LSSystemMessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _messageModle.msg_title;
    UILabel *label  = [UILabel labelWithText:_messageModle.msg_txt color:color_black font:14 Alignment:LSLabelAlignment_left];
    [self.view addSubview:label];
    CGFloat h = [_messageModle.msg_txt getStrH:SCREEN_WIDTH-20 font:14]+20;
    label.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, h);
   
    
}



@end

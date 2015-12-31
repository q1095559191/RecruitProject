//
//  LSShareView.h
//  RecruitProject
//
//  Created by sliu on 15/10/22.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSCoustomAlert.h"

@interface LSShareView : LSCoustomAlert
@property(nonatomic,strong)UIButton *btn1;
@property(nonatomic,strong)UIButton *btn2;
@property(nonatomic,strong)UIButton *btn3;
@property(nonatomic,strong)UIButton *cancleBtn;

+(instancetype)shareView;

@end

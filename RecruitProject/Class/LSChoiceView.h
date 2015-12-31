//
//  LSChoiceView.h
//  RecruitProject
//
//  Created by sliu on 15/10/30.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSBaseModel.h"

@interface LSChoiceView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (copy,nonatomic)  LSActionBlock     action;             //单选事件
@property (assign,nonatomic)  NSInteger       selectedIndex;
@property (assign,nonatomic)  NSInteger       selectedIndex2;
@property (nonatomic,strong)  NSArray         *titles;
@property (nonatomic,strong)  UITableView     *tableView;
@property (nonatomic,strong)  UIButton        *saveBtn;
@property (nonatomic,assign)  BOOL            isMore;             //是否单选
@property (nonatomic,assign)  BOOL            isSub;              //是否为2级目录
@property (nonatomic,strong)  NSArray         *titles2;
@property (nonatomic,strong)  UITableView     *tableView2;

@property (nonatomic,strong) NSMutableArray    *moreArr;

//单选
+(instancetype)ChoiceViewInView:(UIView *)view titles:(NSArray *)titles  cancle:(LSActionBlock)action;
//多选
+(instancetype)choiceMoreViewInView:(UIView *)view titles:(NSArray *)titles cancle:(LSActionBlock)action;


@end

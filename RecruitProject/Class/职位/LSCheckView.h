//
//  LSCheckView.h
//  RecruitProject
//
//  Created by sliu on 15/10/13.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSCoustomAlert.h"
#import "LSCheckModel.h"
@class LSCheckView;
typedef void (^LSCheckViewBlock)(void);

@interface LSCheckView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) LSCheckModel   *checkModel;
@property (nonatomic,strong) NSArray        *titles;
@property (nonatomic,strong) UITableView    *tableView;
@property (nonatomic,strong) UIButton       *saveBtn;
@property(assign,nonatomic)  NSInteger      selectedIndex;
@property(copy,nonatomic)  LSCheckViewBlock    action;
@property(assign,nonatomic)  NSInteger         type;
+(instancetype)checkViewInView:(UIView *)view titles:(NSArray *)titles  checkModel:(LSCheckModel *)model cancle:(LSCheckViewBlock)action;

//得到选中的ID
-(NSString *)getSelsctedStr:(NSArray *)arr;



@end

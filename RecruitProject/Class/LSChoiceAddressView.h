//
//  LSChoiceAddressView.h
//  RecruitProject
//
//  Created by sliu on 15/10/22.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSCheckModel.h"
@interface LSChoiceAddressView : UIView <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) LSCheckModel   *checkModel;
@property (nonatomic,copy)   LSActionBlock   action;
@property (nonatomic,copy)   NSString       *type;
@property (nonatomic,strong) NSArray        *titles;
@property (nonatomic,strong) NSArray        *titles2;
@property (nonatomic,strong) UITableView    *tableView;
@property (nonatomic,strong) UITableView    *tableView2;
@property (nonatomic,strong) UIButton       *saveBtn;


@property(assign,nonatomic)  NSInteger      selectedIndex;
@property(assign,nonatomic)  NSInteger      selectedIndex21;
@property(assign,nonatomic)  NSInteger      selectedIndex22;
@property(copy,nonatomic)    NSString       *selectedstr;


+(instancetype)ChoiceViewInView:(UIView *)view   titles:(NSArray *)titles  checkModel:(LSCheckModel *)model cancle:(LSActionBlock)action;
+(instancetype)ChoiceAddressViewInView:(UIView *)view  checkModel:(LSCheckModel *)model cancle:(LSActionBlock)action;
+(instancetype)addressViewInView:(UIView *)view  cancle:(LSActionBlock)action;
-(void)hide;

//得到选中的ID
-(NSString *)getSelsctedID;
//得到选中的字符串
-(NSString *)getSelsctedStr;

@end

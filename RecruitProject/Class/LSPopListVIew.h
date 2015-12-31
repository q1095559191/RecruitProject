//
//  LSPopListVIew.h
//  RecruitProject
//
//  Created by sliu on 15/11/6.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "CMPopTipView.h"

@interface LSPopListVIew : CMPopTipView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView *listView;
@property (nonatomic ,strong) NSArray *listarr;
@property (nonatomic ,assign) BOOL showpop;
@property (nonatomic ,assign) NSInteger index;
+(instancetype)popListView:(NSArray *)listarr ;

@end

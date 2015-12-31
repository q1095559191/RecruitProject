//
//  LSChoiceItems.h
//  LSLayoutDemo
//
//  Created by admin on 15/8/17.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LSChoiceItemsBlock)(NSInteger selectIndex);
@interface LSChoiceItems : NSObject<UITableViewDelegate,UITableViewDataSource>

-(void)choiceItems:(NSArray *)titles btn:(UIButton*)btn action:(LSChoiceItemsBlock)action;

@property (nonatomic , assign) LSChoiceItemsBlock actionBlock;
@property (nonatomic , strong) NSArray     *titles;
@property (nonatomic , strong) UITableView *listView;
@property (nonatomic , strong) UIButton    *btn;
@property (nonatomic , assign) NSInteger   selectIndex;

//显示或隐藏
-(void)listAction:(UIButton *)btn;

-(void)show;
-(void)hide;

@end

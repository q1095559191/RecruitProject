//
//  LSTableViewKit.h
//  LSLayoutDemo
//
//  Created by admin on 15/8/24.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

// 对象必须强引用

typedef void (^TableViewCellConfigureBlock)(id cell, id item,NSIndexPath *index);
typedef void (^TableViewCellEdit)(UITableView * tableView, UITableViewCellEditingStyle editingStyle,NSIndexPath *index);

@interface LSTableViewKit : NSObject<UITableViewDataSource>


@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy)   NSString *cellID;     //与cell名字相同
@property (nonatomic, copy)   NSArray  *cellIDs;    //与cell名字相同
@property (nonatomic, copy)   TableViewCellConfigureBlock configureCellBlock;
@property (nonatomic, copy)   TableViewCellEdit           editBlock;

@property (nonatomic, assign)   BOOL isEdit;

-(id)intitWithData:(NSArray *)items cellID:(id)cellID tableView:(UITableView *)tableView;
//设置cell的高度

@end


@interface UITableViewCell (LSConfigCell)

//刷新Cell
-(void)configCell:(id)data;
//计算Cell高度
+(CGFloat)GetCellH:(id)data;

@end

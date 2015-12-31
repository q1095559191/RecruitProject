//
//  LSTableViewKit.m
//  LSLayoutDemo
//
//  Created by admin on 15/8/24.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import "LSTableViewKit.h"

@implementation LSTableViewKit

-(id)intitWithData:(NSArray *)items cellID:(id)cellID tableView:(UITableView *)tableView
{
  
    if ([super init]) {
        
        self.items =  items;
        
        if ([cellID isKindOfClass:[NSArray class]]) {
            
            self.cellIDs = cellID;
            
        }else
            
        {
            self.cellID = cellID;
        }
    }
    tableView.dataSource = self;
    if (self.cellIDs) {
        for (id cellsection in self.cellIDs) {
            if ([cellsection isKindOfClass:[NSArray class]]) {
                 for (id cellrow in cellsection) {
                     self.cellID = cellrow;
                     [self registerCell:tableView];
                 }
            }else
            {  self.cellID = cellsection;
              [self registerCell:tableView];
            }
        }
        
    }else
    {
    //一种cell
    [self registerCell:tableView];
    }
    return self;
}

//注册cell
-(void)registerCell:(UITableView *)tableView
{
   [tableView registerClass: NSClassFromString(self.cellID) forCellReuseIdentifier:self.cellID];
     tableView.dataSource = self;
}


#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.items.firstObject isKindOfClass:[NSArray class]]) {
        return self.items.count;
    }else
    {
        return 1;
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.items.firstObject isKindOfClass:[NSArray class]]) {
        return [self.items[section] count];
       
    }else
    {
        return self.items.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (self.cellIDs) {
      if ([self.cellIDs[indexPath.section] isKindOfClass:[NSArray class]]) {
          self.cellID = self.cellIDs[indexPath.section][indexPath.row];
        }else
        {
          self.cellID = self.cellIDs[indexPath.section];       
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellID
                                                forIndexPath:indexPath];
  id item;
  if ([self.items.firstObject isKindOfClass:[NSArray class]]) {
         item = self.items[indexPath.section][indexPath.row];
    }else
    {
        if(indexPath.row <= self.items.count)
        {
        item = self.items[indexPath.row];
        }
    }
   //事件
    if (self.configureCellBlock) {
       self.configureCellBlock(cell, item,indexPath);
    }
    //刷新数据
    [cell configCell:item];
    
    return cell;
}


//编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.isEdit;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
 //编辑
    if (self.editBlock) {
        self.editBlock(tableView,editingStyle,indexPath);
    }

}
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath

{
    return NO;
}

@end

@implementation UITableViewCell (LSConfigCell)


+(CGFloat)GetCellH:(id)data
{
    return 44;
}

-(void)configCell:(id)data
{

}
@end

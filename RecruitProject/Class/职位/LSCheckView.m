//
//  LSCheckView.m
//  RecruitProject
//
//  Created by sliu on 15/10/13.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSCheckView.h"

@implementation LSCheckView

-(NSString *)getSelsctedStr:(NSArray *)arr
{
    if (self.selectedIndex >= 0) {
        id data = arr[self.selectedIndex];
        if ([data isKindOfClass:[NSDictionary class]]) {
         NSLog(@"%@",data[@"tb_id"]);
         return   data[@"tb_id"];
        }
    }
   
    return nil;
}

+(instancetype)checkViewInView:(UIView *)view titles:(NSArray *)titles checkModel:(LSCheckModel *)model cancle:(LSCheckViewBlock)action
{
    LSCheckView *checkView  =   [LSCheckView checkView:titles inView:view cancle:action];
    checkView.checkModel = model;
       UIColor *bgcolor = [[UIColor alloc] initWithWhite:0.667 alpha:0.8];
    checkView.backgroundColor = bgcolor;
    [checkView creatTableView];
    return checkView;

}



+(instancetype)checkView:(NSArray *)titles  inView:(UIView *)superView cancle:(LSCheckViewBlock)action
{
    LSCheckView *checkView  = [[LSCheckView alloc] init];
    checkView.titles = titles;
    checkView.action = action;
    [superView addSubview:checkView];
   
 
    return checkView;
}

-(void)creatTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    self.tableView.backgroundColor = color_bg;
    [self.superview addSubview:self.tableView];
 
        NSInteger a = 0;
        if ( self.titles.count >=6) {
        a  = 6;
        }else
        {
          a = self.titles.count;
        }
        self.frame = CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.tableView.frame = CGRectMake(0, 50, SCREEN_WIDTH, a*44);
    
    [self bk_whenTapped:^{
        [self removeFromSuperview];
       
    }];
  
    
}

-(void)removeFromSuperview
{
    [super removeFromSuperview];
    [self.tableView removeFromSuperview];
}
#pragma mark UITableViewDataSource
//头部的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
}
//取消分割线
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

//底部的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"checkCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID
                                              ];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
    }
    id data = self.titles[indexPath.row];
    NSString *title;
    if ([data isKindOfClass:[NSDictionary class]]) {
     title =data[@"tb_tilte"];
    }
    if ([data isKindOfClass:[NSString class]]) {
        title =data;
    }
    cell.textLabel.text = title;
    if (indexPath.row == self.selectedIndex) {
        cell.accessoryType  = UITableViewCellAccessoryCheckmark;
        cell.tintColor = color_bg_yellow;
    }else
    {
        cell.accessoryType  = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedIndex = indexPath.row;
   
    if (self.checkModel)
    {
       self.checkModel.index = self.selectedIndex;
    }
    
    if (self.action) {
        self.action();
    }    
    [self removeFromSuperview];
    
}



@end

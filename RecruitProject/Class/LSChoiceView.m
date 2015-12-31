//
//  LSChoiceView.m
//  RecruitProject
//
//  Created by sliu on 15/10/30.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSChoiceView.h"


@implementation LSChoiceView

#pragma mark - 多选
+(instancetype)choiceMoreViewInView:(UIView *)view titles:(NSArray *)titles cancle:(LSActionBlock)action
{
    LSChoiceView *choiceView = [[LSChoiceView alloc] init];
    [view addSubview:choiceView];
    choiceView.frame = view.bounds;
    UIColor *bgcolor = [[UIColor alloc] initWithWhite:0.667 alpha:0.8];
    choiceView.backgroundColor = bgcolor;
    choiceView.titles = titles;
    LSBaseModel *model = titles[0];
    if (ISNOTNILARR(model.subArr)) {
        choiceView.isSub = YES;
        choiceView.titles2 = model.subArr;
    }
    [choiceView creatTableView:view];
    LSActionBlock saveAction = ^(UIButton *btn)
    {
        [choiceView remove];
        if (action) {
            action(choiceView.saveBtn);
        }
    };
    choiceView.saveBtn = [UIButton buttonWithTitle:@"确定" titleColor:color_white BackgroundColor:color_main action:saveAction];
    [choiceView addSubview: choiceView.saveBtn];
    choiceView.isMore = YES;
    choiceView.moreArr = [NSMutableArray array];
    choiceView.saveBtn.frame = CGRectMake(0, SCREEN_HEIGHT-40-60, SCREEN_WIDTH, 40);
    return choiceView;

}



#pragma mark - 单选
+(instancetype)ChoiceViewInView:(UIView *)view titles:(NSArray *)titles cancle:(LSActionBlock)action
{
    LSChoiceView *choiceView = [[LSChoiceView alloc] init];
    [view addSubview:choiceView];
    choiceView.frame = view.bounds;
    UIColor *bgcolor = [[UIColor alloc] initWithWhite:0.667 alpha:0.8];
    choiceView.backgroundColor = bgcolor;
    choiceView.titles = titles;
    LSBaseModel *model = titles[0];
    if (ISNOTNILARR(model.subArr)) {
        choiceView.isSub = YES;
        choiceView.titles2 = model.subArr;
    }
    [choiceView creatTableView:view];
    LSActionBlock saveAction = ^(UIButton *btn)
    {
        if (action) {
            action(nil);
        }
        [choiceView remove];
    };
    choiceView.action  =  saveAction;
    
    return choiceView;

}


-(void)creatTableView:(UIView *)view
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    self.tableView.backgroundColor = color_bg;
    [view addSubview:self.tableView];
    if (self.isSub) {
        self.tableView2 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.tableView2.dataSource = self;
        self.tableView2.delegate   = self;
        [view addSubview:self.tableView2];
        self.tableView2.backgroundColor = color_bg;
        self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 2*SCREEN_HEIGHT/3);
        self.tableView2.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 2*SCREEN_HEIGHT/3);
        
    }else
    {
        //单行
        NSInteger a = 0;
        if ( self.titles.count >=6) {
            a  = 6;
        }else
        {
            a = self.titles.count;
        }
        self.tableView.frame = CGRectMake(0, (SCREEN_HEIGHT - a*44 - 64)/2, SCREEN_WIDTH, a*44);
    }
    
    self.userInteractionEnabled = YES;
    [self bk_whenTapped:^{
        [self remove];
    }];
 
}

-(void)remove
{
    if (self.tableView) {
        [self.tableView removeFromSuperview];
    }
    if (self.tableView2) {
        [self.tableView2 removeFromSuperview];
    }
    [self removeFromSuperview];
    
}

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


//头部的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}


//底部的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView2) {
        return self.titles2.count;
    }
   
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
    LSBaseModel *model ;
  
 
        if (tableView == self.tableView2) {
            model = self.titles2[indexPath.row];
            if (model.isSelected) {
                //选中
                cell.accessoryType  = UITableViewCellAccessoryCheckmark;
                cell.tintColor = color_bg_yellow;
            }else
            {
                cell.accessoryType  = UITableViewCellAccessoryNone;
            }
            cell.contentView.backgroundColor = color_clear;
            cell.backgroundColor = color_clear;
        }else
        {
            model = self.titles[indexPath.row];
          
            if (self.isSub) {
                  cell.accessoryType  = UITableViewCellAccessoryNone;
            }else
            {
                if (model.isSelected) {
                    //选中
                    cell.accessoryType  = UITableViewCellAccessoryCheckmark;
                    cell.tintColor = color_bg_yellow;
                }else
                {
                    cell.accessoryType  = UITableViewCellAccessoryNone;
                }
            
            }
        }
   
    
  
    cell.textLabel.text = model.title;
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *temp;
    if (tableView == self.tableView) {
        temp = self.titles;
        self.selectedIndex = indexPath.row;
    }else
    {
       temp = self.titles2;
       self.selectedIndex2 = indexPath.row;
    }
    
    if (self.isMore) {
        //多选
        LSBaseModel *model = temp[indexPath.row];
        if (model.isSelected) {
            model.isSelected = NO;
            [self.moreArr removeObject:model];
            if (self.isSub) {
                //2列多选
                if (tableView == self.tableView) {
                    LSBaseModel *model1 = self.titles[self.selectedIndex];
                    self.titles2 = model1.subArr;
                }
                [self.tableView2 reloadData];
                
                
            }else
            {   //单列多选
                [self.tableView reloadData];
            }
            
        }else
        {   //未选中的

            if (self.moreArr.count >= 3  &&tableView == self.tableView2) {
                [SVProgressHUD showInfoWithStatus:@"最多只能选3个期望职位"];
                return;
            }else
            {
                if (self.isSub) {
                    if (tableView == self.tableView) {
                        LSBaseModel *model1 = self.titles[self.selectedIndex];
                        self.titles2 = model1.subArr;
                    }else
                    {  //右侧列表
                        model.isSelected = YES;
                        [self.moreArr addObject:model];
                    }
                    [self.tableView2 reloadData];
                }else
                {
                    [self.tableView reloadData];
                }
            
            }
           
        }
       
        
    }else
    {
        for (LSBaseModel *model in temp) {
            model.isSelected = NO;
        }
        LSBaseModel *model = temp[indexPath.row];
        model.isSelected = YES;
        if (self.isSub) {
            if (tableView == self.tableView) {
                LSBaseModel *model1 = self.titles[self.selectedIndex];
                self.titles2 = model1.subArr;
                [self.tableView2 reloadData];
            }else
            {
                if(self.action)
                {
                    self.action(nil);
                }
            }
           
        }else
        {   //单列单选
            if(self.action)
            {
                self.action(nil);
            }
        }
    }
 
  
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



@end

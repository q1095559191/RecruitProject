//
//  LSChoiceAddressView.m
//  RecruitProject
//
//  Created by sliu on 15/10/22.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSChoiceAddressView.h"
#define LSChoiceCellH   44

@implementation LSChoiceAddressView




-(NSString *)getSelsctedStr
{
    if (self.selectedIndex >= 0) {
        id data = self.titles[self.selectedIndex];
        if ([data isKindOfClass:[NSDictionary class]]) {
            return   data[@"tb_tilte"];
        }
    }
    return nil;
}

-(NSString *)getSelsctedID
{
    if (self.selectedIndex >= 0) {
        id data = self.titles[self.selectedIndex];
        if ([data isKindOfClass:[NSDictionary class]]) {           
            return   data[@"tb_id"];
        }
    }    
    return nil;
}

+(instancetype)ChoiceViewInView:(UIView *)view checkModel:(LSCheckModel *)model cancle:(LSActionBlock)action
{
    LSChoiceAddressView *choiceView = [[LSChoiceAddressView alloc] init];
    [view addSubview:choiceView];
    choiceView.frame = view.bounds;
    UIColor *bgcolor = [[UIColor alloc] initWithWhite:0.667 alpha:0.8];
    choiceView.backgroundColor = bgcolor;
    choiceView.checkModel = model;
    LSActionBlock saveAction = ^(UIButton *btn)
    {
        if (choiceView.checkModel) {
            if([choiceView.type isEqualToString:@"1"])
            {
              choiceView.checkModel.index = choiceView.selectedIndex;
            }else
            {
              choiceView.checkModel.index1  = choiceView.selectedIndex21;
              choiceView.checkModel.index2 = choiceView.selectedIndex22;
            }
        }
        if (action) {
            action(btn);
        }
        [choiceView hide];
    };
    choiceView.action =  saveAction;
    return choiceView;
}

-(void)show
{


}

-(void)hide
{
    [self remove];
}

#pragma mark - 单选
+(instancetype)ChoiceViewInView:(UIView *)view titles:(NSArray *)titles checkModel:(LSCheckModel *)model cancle:(LSActionBlock)action
{
    LSChoiceAddressView *choiceView = [LSChoiceAddressView ChoiceViewInView:view checkModel:model cancle:action];
    [view addSubview:choiceView];
    choiceView.frame = view.bounds;
    UIColor *bgcolor = [[UIColor alloc] initWithWhite:0.667 alpha:0.8];
    choiceView.backgroundColor = bgcolor;
    choiceView.titles = titles;
    choiceView.type = @"1";
    [choiceView creatTableView:view];
    return choiceView;
  
}


#pragma mark -选择地址双选
+(instancetype)ChoiceAddressViewInView:(UIView *)view checkModel:(LSCheckModel *)model cancle:(LSActionBlock)action
{
    NSString *addressPath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:addressPath];
     NSArray *titles = [dict objectForKey:@"address"];
    
   LSChoiceAddressView *choiceView = [LSChoiceAddressView ChoiceViewInView:view  checkModel:model cancle:action];
    choiceView.selectedIndex   = -1;
    choiceView.selectedIndex21 = 0;
    choiceView.selectedIndex22 = -1;
    
    choiceView.titles = titles;
    choiceView.titles2 = titles[choiceView.selectedIndex21][@"sub"];
    choiceView.type = @"2";
    [choiceView creatTableView:view];
    
    return choiceView;

}



#pragma mark - 地址选择
+(instancetype)addressViewInView:(UIView *)view  cancle:(LSActionBlock)action
{
    LSChoiceAddressView *choiceView = [[LSChoiceAddressView alloc] init];
    [view addSubview:choiceView];
    choiceView.frame = view.bounds;
    UIColor *bgcolor = [[UIColor alloc] initWithWhite:0.667 alpha:0.8];
    choiceView.backgroundColor = bgcolor;
    LSActionBlock saveAction = ^(UIButton *btn)
    {
        NSDictionary *dic = choiceView.titles2[choiceView.selectedIndex22];
        choiceView.selectedstr  = dic[@"name"];
        if ([choiceView.selectedstr hasSuffix:@"市"]) {
            choiceView.selectedstr = [choiceView.selectedstr substringWithRange:NSMakeRange(0, choiceView.selectedstr.length-1)];
        }
        
        if (action) {
            action(btn);
        }
        [choiceView hide];
    };
    
    choiceView.action = saveAction;

    
    choiceView.selectedIndex   = -1;
    choiceView.selectedIndex21 = 0;
    choiceView.selectedIndex22 = -1;
    
    NSString *addressPath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:addressPath];
    NSArray *titles = [dict objectForKey:@"address"];
    choiceView.titles = titles;
    choiceView.titles2 = titles[choiceView.selectedIndex21][@"sub"];
    choiceView.type = @"2";
    [choiceView creatTableView:view];
    return choiceView;
}

-(void)creatTableView:(UIView *)view
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    self.tableView.backgroundColor = color_bg;
    [view addSubview:self.tableView];
    if ([self.type isEqualToString:@"1"]) {
        NSInteger a = 0;
        if ( self.titles.count >=6) {
            a  = 6;
        }else
        {
            a = self.titles.count;
        }
       self.tableView.frame = CGRectMake(0, (SCREEN_HEIGHT-a*LSChoiceCellH-64)/2, SCREEN_WIDTH, a*LSChoiceCellH);
      
    }
    
    if ([self.type isEqualToString:@"2"]) {
        self.tableView2 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.tableView2.dataSource = self;
        self.tableView2.delegate   = self;
        [view addSubview:self.tableView2];
        self.tableView2.backgroundColor = color_bg;
        self.tableView.frame  = CGRectMake(             0, 0, SCREEN_WIDTH/2, 2*SCREEN_HEIGHT/3);
        self.tableView2.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 2*SCREEN_HEIGHT/3);
    }
    
    
    [self bk_whenTapped:^{
        [self remove];
    }];
 
}

-(void)remove
{
    [self removeFromSuperview];
    if (self.tableView) {
         [self.tableView removeFromSuperview];
    }
    if (self.tableView2) {
        [self.tableView2 removeFromSuperview];
    }
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
         return self.titles.count;
    }else
    {
         return self.titles2.count;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"checkCell";    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID
                             ];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        if (tableView == self.tableView2) {
            cell.contentView.backgroundColor = color_clear;
            cell.backgroundColor = color_clear;
        }
        
    }
    id data ;
    NSString *title;
    if(tableView == self.tableView)
    {
     data = self.titles[indexPath.row];
    }else
    {
     data = self.titles2[indexPath.row];
    }
    if ([self.type  isEqualToString:@"1"]) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            title =data[@"tb_tilte"];
        }
        if (indexPath.row == self.selectedIndex) {
            cell.accessoryType  = UITableViewCellAccessoryCheckmark;
            cell.tintColor = color_bg_yellow;
        }else
        {
            cell.accessoryType  = UITableViewCellAccessoryNone;
        }
        
    }else
    {
        if ([data isKindOfClass:[NSDictionary class]]) {
            title =data[@"name"];
        }
        if (tableView == self.tableView2) {
            if (self.selectedIndex == self.selectedIndex21) {
                if (indexPath.row == self.selectedIndex22) {
                    cell.accessoryType  = UITableViewCellAccessoryCheckmark;
                    cell.tintColor = color_bg_yellow;
                }else
                {
                    cell.accessoryType  = UITableViewCellAccessoryNone;
                }
            }else
            {
                cell.accessoryType  = UITableViewCellAccessoryNone;
            }
           
        }
    }
    cell.textLabel.text = title;
   
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.tableView) {
         self.selectedIndex = indexPath.row;
        if ([self.type isEqual:@"2"]) {
            NSArray *arr =  self.titles[indexPath.row][@"sub"];
            self.titles2 =  arr;
            [self.tableView2 reloadData];
        }else
        {
            //单选
            if (self.action) {
                self.action(nil);
            }
        }
        
    }else
    {
        if(self.selectedIndex == -1)
        {
        self.selectedIndex = 0;
        }
         self.selectedIndex21 = self.selectedIndex;
         self.selectedIndex22 = indexPath.row;
         //多选
        if (self.action) {
            self.action(nil);
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

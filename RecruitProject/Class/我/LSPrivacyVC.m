//
//  LSPrivacyVC.m
//  RecruitProject
//
//  Created by sliu on 15/10/7.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSPrivacyVC.h"
@interface LSPrivacyVC ()

@property (nonatomic,assign) BOOL isAllow;
@end
@implementation LSPrivacyVC

-(void)httpRequest
{
[LSHttpKit getMethod:@"c=Personal&a=getPrivacySettings" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSString *str =  responseObject[@"data"][@"friendsSearch"];
    if (ISNOTNILSTR(str)) {
        if ([str isEqualToString:@"1"]) {
            self.isAllow = YES;
        }else
        {
          self.isAllow = NO;
        }
        [self.tableView reloadData];
    }
    
}];

}
-(void)viewDidLoad
{
    [super viewDidLoad];
    //刷新简历
    UIButton *btn = [UIButton buttonWithTitle:@"保存" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
       //求职隐私设置
        if (self.isAllow) {
            [self.parDic setObject:@"1" forKey:@"friendsSearch"];
        }else
        {
            [self.parDic setObject:@"0" forKey:@"friendsSearch"];
        }
       [LSHttpKit getMethod:@"c=Personal&a=PrivacySettings" parameters:self.parDic  success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [SVProgressHUD showSuccessWithStatus:responseObject[@"msg"]];
           [self.navigationController popViewControllerAnimated:YES];
       }];
        
    }];
    
    [self.view addSubview:btn];
    btn.edgeNearbottom(0,0,0,40);
    
    [self.dataListArr addObject:@[@"是否允许其他会员搜索到您",@"允许",@"禁止",]];
    
    [self creatTableView:@"LSBaseCell"];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,40,0);
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return 35;
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    }];
    self.isAllow = YES;
    __weak LSPrivacyVC *weakSelf  = self;
    self.tableViewKit.configureCellBlock = ^(UITableViewCell *cell,NSString *item,NSIndexPath *index)
    {
        cell.textLabel.text = item;
        if ([item isEqualToString:@"是否允许其他会员搜索到您"]) {
            cell.textLabel.font = [UIFont systemFontOfSize:18];
            cell.textLabel.textColor = color_title_Gray;
        }else
        {
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = color_black;
            if ([item isEqualToString:@"允许"])
            {
            if (weakSelf.isAllow)
            {
             cell.imageView.image = [UIImage imageNamed:@"radio_selected"];
            }else
            {
             cell.imageView.image = [UIImage imageNamed:@"radio_normal"];
            }
            
            }else
            {
                if (weakSelf.isAllow) {
                    cell.imageView.image = [UIImage imageNamed:@"radio_normal"];
                }else
                {
                    cell.imageView.image = [UIImage imageNamed:@"radio_selected"];
                }
            }
        }
    };
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        self.isAllow = YES;
    }
    
    if (indexPath.row == 2) {
        self.isAllow = NO;
    }
    [self.tableView reloadData];
}

//分割线设置
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [cell setSeparatorInset:UIEdgeInsetsZero];
            
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [cell setLayoutMargins:UIEdgeInsetsZero];
            
        }
        
        if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
            
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
        
         tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
     cell.selectionStyle  = UITableViewCellSelectionStyleNone;
}
@end

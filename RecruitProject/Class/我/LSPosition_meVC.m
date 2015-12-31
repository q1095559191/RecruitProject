//
//  LSPosition_meVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/28.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSPosition_meVC.h"
#import "LSPositionModel.h"
@interface LSPosition_meVC ()

@end
@implementation LSPosition_meVC
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self creatTableView:@"LSPositionCell"];
    self.tableView.edge(0,0,0,0);
    self.tableView.delegate = self;
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return 80;
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 15;
    }];
    
     [self creatBottomView];
   
    
}

-(NSString *)getOpenings_id
{
    NSString *Openings_id;
    for (LSPositionModel *model in self.dataListArr) {
        if (model.isSelected) {
            if (Openings_id) {
                 Openings_id = [NSString stringWithFormat:@"%@,%@",Openings_id,model.openings_id];
            }else
            {
                 Openings_id = [NSString stringWithFormat:@"%@",model.openings_id];
            }
        }
    }
    return Openings_id;
}

-(void)creatBottomView
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 55);
    
    self.tableView.tableFooterView = view;
    CGFloat W = 130;
    CGFloat left = (SCREEN_WIDTH-2*W)/3;
    UIButton *deleBtn = [UIButton buttonWithTitle:@"删除所选" titleColor:color_white BackgroundColor:color_black action:^(UIButton *btn) {
        if ([self getOpenings_id]) {
            [self.parDic  setObject:[self getOpenings_id] forKey:@"openings_id"];
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"请选择简历"];
        }
      
        [LSHttpKit getMethod:@"c=Personal&a=delFavOpenings" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功!"];
            [self httpRequest];
        }];
        
    }];
    deleBtn.frame = CGRectMake(left, 0, W, 40);
    [view addSubview:deleBtn];
    [deleBtn setCornerRadius:3];
    
    
    UIButton *sendBtn = [UIButton buttonWithTitle:@"应聘所选" titleColor:color_bg_yellow BackgroundColor:color_white action:^(UIButton *btn) {
        if ([self getOpenings_id]) {
            [self.parDic  setObject:[self getOpenings_id] forKey:@"openings_id"];
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"请选择简历"];
        }
        
        [LSHttpKit getMethod:@"c=Personal&a=applyOpenings" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"应聘成功!"];
            [self httpRequest];
        }];

        
    }];
    sendBtn.frame = CGRectMake(left+W+left, 0, W, 40);
    [view addSubview:sendBtn];
    [sendBtn setCornerRadius:3];
    sendBtn.layer.borderColor = color_bg_yellow.CGColor;
    sendBtn.layer.borderWidth = 1;
    
    [sendBtn setImage:[UIImage imageNamed:@"icon_send_orange"] forState:UIControlStateNormal];
    [deleBtn setImage:[UIImage imageNamed:@"icon_trash_gray"] forState:UIControlStateNormal];
    

}

-(void)httpRequest
{
    NSString *methodStr;
    if (self.isCollection) {
         //收藏
         methodStr = @"c=Personal&a=CollectionPosition";
    }else
    {    //谁看过我的简历
         methodStr = @"c=Personal&a=ReadMyResume";
    }

    [LSHttpKit getMethod:methodStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *arr = responseObject[@"data"][@"list"];
        if (self.page == 1) {
            [self.dataListArr removeAllObjects];
        }
        if (ISNOTNILARR(arr)) {
            for (NSDictionary *dic in arr) {
                LSPositionModel *model = [LSPositionModel objectWithKeyValues:dic];
                if (self.isCollection) {
                    //收藏
                   model.fromType = @"5";
                }else
                {
                   model.fromType = @"6";
                }
                
                [self.dataListArr addObject:model];
            }
            [self.tableView reloadData];
            if (arr.count != 0) {
               
            }
            
           
        }
        
    }];
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSPositionModel *model = (LSPositionModel*)self.dataListArr[indexPath.row];
    if (model.isSelected) {
        model.isSelected = NO;
    }else
    {
       model.isSelected = YES;
    }

    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end

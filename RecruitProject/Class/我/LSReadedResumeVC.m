//
//  LSReadedResumeVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSReadedResumeVC.h"
#import "LSPositionCell.h"
#import "LSCheckResumeVC.h"
#import "LSApplyDetailVC.h"
@interface LSReadedResumeVC ()

@end

@implementation LSReadedResumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addHeaderAndFooterRefresh];
    
    [self creatTableView:@"LSPositionCell"];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,0,0);
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return 60;
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 15;
    }];
    
    
    [self creatBottomView];
    if(self.isCollection)
    {
     [self addHeaderAndFooterRefresh];
    }
   
    
    
}


-(void)creatBottomView
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 55);
    
    self.tableView.tableFooterView = view;
    CGFloat W = 130;
//    CGFloat left = (SCREEN_WIDTH-2*W)/3;
    WeakSelf;
    UIButton *deleBtn = [UIButton buttonWithTitle:@"删除所选" titleColor:color_white BackgroundColor:color_black action:^(UIButton *btn) {
        NSString *resumes_id = [self getResumes_id];
        if (!ISNILSTR(resumes_id)) {
          [LSHttpKit getMethod:@"c=Company&a=delFavResume" parameters:@{@"resumes_id": resumes_id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
          [weakSelf httpRequest];
          [SVProgressHUD showSuccessWithStatus:@"删除成功!"];
          }];
        }else
        {
          [SVProgressHUD showErrorWithStatus:@"请选择简历!"];
        }
        
    }];
   
    [view addSubview:deleBtn];
    [deleBtn setCornerRadius:3];
    

    [deleBtn setImage:[UIImage imageNamed:@"icon_trash_gray"] forState:UIControlStateNormal];
  
    deleBtn.frame = CGRectMake((SCREEN_WIDTH-W)/2, 0, W, 40);
    if(!self.isCollection)
    {
        deleBtn.hidden = YES;
    }
}

#pragma mark -获取选中resumes_id
-(NSString *)getResumes_id
{
    NSString *resumes_id;
    for (LSPositionModel *model in self.dataListArr) {
        if (model.isSelected) {
            if (resumes_id) {
                resumes_id = [NSString stringWithFormat:@"%@,%@",resumes_id,model.resumes_id];
            }else
            {
                resumes_id = [NSString stringWithFormat:@"%@",model.resumes_id];
            }
        }
    }
    return resumes_id;
}


-(void)httpRequest
{
    NSString *methodStr;
    if (self.isCollection) {
        methodStr = @"c=Company&a=CollectResume";
    }else
    {
        methodStr = @"c=Company&a=ViewedResume";
    }
    
[LSHttpKit getMethod:methodStr parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [self endRefresh];
    if (self.page == 1) {
        [self.dataListArr removeAllObjects];
    }

    NSArray *listArr = responseObject[@"data"][@"list"];
    if (ISNOTNILARR(listArr)) {
        for (NSDictionary *dic in listArr) {
            LSPositionModel *model = [LSPositionModel objectWithKeyValues:dic];
            model.fromType = @"8";
            [self.dataListArr addObject:model];
        }
     }
    [self handleNilData];
    [self.tableView reloadData];

}];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSPositionModel *modle  = self.dataListArr[indexPath.row];
  
    LSCheckResumeVC *resumeDetailVC = [[LSCheckResumeVC alloc] init];
    resumeDetailVC.title = modle.truename;
    resumeDetailVC.resumeID = modle.resumes_id;
    resumeDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:resumeDetailVC animated:YES];

}

@end

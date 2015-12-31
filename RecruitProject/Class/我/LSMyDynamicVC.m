//
//  LSMyDynamicVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSMyDynamicVC.h"
#import "LSPersonalDynamicCell.h"
#import "LSMyDynamicDetailVC.h"
#import "LSCircleVC.h"
#import "LSPositionDetailVC.h"
#import "LSCheckResumeVC.h"

@interface LSMyDynamicVC ()

@end

@implementation LSMyDynamicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatTableView:@"LSPersonalDynamicCell"];
    self.tableView.edge(0,0,0,0);
    self.tableView.delegate = self;
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return [LSPersonalDynamicCell GetCellH:self.dataListArr[indexPath.row]];
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    }];
    [self addHeaderAndFooterRefresh];
    WeakSelf;
    self.tableViewKit.configureCellBlock = ^(LSPersonalDynamicCell *cell,LSDynamicModel *item,NSIndexPath *index)
    {
        cell.deleBtn.actionBlock = ^(UIButton *btn)
        {
        
        [LSHttpKit getMethod:@"c=Dynamic&a=deleteDynamics" parameters:@{@"dynamic_id":item.dynamic_id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            [weakSelf httpRequest];
        }];
        
        };
    };
    
    
}


-(void)httpRequest
{

[LSHttpKit getMethod:@"c=Dynamic&a=myDynamics" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
     [self endRefresh];
    if (self.page == 1) {
        [self.dataListArr removeAllObjects];
    }
    
    NSArray *arr = responseObject[@"data"][@"m_dynamic_list"];
    if (ISNOTNILARR(arr)) {
      
        for (NSDictionary *dic in arr) {
         LSDynamicModel *model  = [LSDynamicModel objectWithKeyValues:dic];
         [self.dataListArr addObject:model];
         model.fromType = @"2";
        }
        [self.tableView reloadData];
    }
    
}];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSDynamicModel *model = self.dataListArr[indexPath.row];
//    1：跳到圈子主页
//    2：跳到简历详情
//    3：跳到帖子
//    4，5：跳到职位详细
    switch ([model.tb_type integerValue]) {
        case 1:
        {
            if (model.ext_info) {
                if ([model.ext_info[@"tb_audit"] integerValue] == 1) {
                    LSCircleVC  *circleVC = [[LSCircleVC alloc] init];
                    circleVC.title     = model.ext_info[@"tb_name"];
                    circleVC.circle_id = model.ext_info[@"circle_id"];
                    circleVC.isAdd = YES;
                    [self.navigationController pushViewController:circleVC animated:YES];
                }else
                {
                    [SVProgressHUD showInfoWithStatus:@"圈子正在审核中"];
                }
            }
        }
            break;
            
        case 2:
        {
            //查看简历
            if (model.ext_info) {
            LSCheckResumeVC *resumeDetailVC = [[LSCheckResumeVC alloc] init];
            resumeDetailVC.title    =  model.ext_info[@"truename"];
            resumeDetailVC.resumeID = model.ext_info[@"resumes_id"];
            resumeDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:resumeDetailVC animated:YES];
        }
      }
            break;
        case 3:
        {
            //跳到帖子
            if (model.ext_info) {
                if ([model.ext_info[@"tb_audit"] integerValue] == 1) {
                    LSCircleVC  *circleVC = [[LSCircleVC alloc] init];
                    circleVC.title     = model.ext_info[@"tb_name"];
                    circleVC.circle_id = model.ext_info[@"circle_id"];
                    circleVC.isAdd = YES;
                    [self.navigationController pushViewController:circleVC animated:YES];
                }else
                {
                    [SVProgressHUD showInfoWithStatus:@"圈子正在审核中"];
                }
            }
    
        }
            break;
        case 4:
        {
            if (model.ext_info) {
                LSPositionDetailVC *positionDetailVC = [[LSPositionDetailVC alloc] init];
                positionDetailVC.hidesBottomBarWhenPushed = YES;
                positionDetailVC.openings_id = model.ext_info[@"openings_id"];
                [self.navigationController pushViewController:positionDetailVC animated:YES];
            }
       
        }
            break;
        case 5:
        {
            if (model.ext_info) {
                LSPositionDetailVC *positionDetailVC = [[LSPositionDetailVC alloc] init];
                positionDetailVC.hidesBottomBarWhenPushed = YES;
                positionDetailVC.openings_id = model.ext_info[@"openings_id"];
                [self.navigationController pushViewController:positionDetailVC animated:YES];
            }
        }
            break;
            
        default:
            break;
    }
  
}

@end

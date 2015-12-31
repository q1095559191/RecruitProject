//
//  LSCompanyDetailVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/22.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSCompanyDetailVC.h"
#import "LSPositionModel.h"
#import "LSCompanyDetailCell.h"
#import "LSPositionDetailVC.h"
@interface LSCompanyDetailVC ()<UITableViewDelegate>
{
    LSUserModel *companyModel;
    NSMutableArray *positionData;  //在招职位数组
    NSMutableArray *data1;
 
   
}
@end

@implementation LSCompanyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"企业介绍";
    companyModel = [[LSUserModel alloc] init];
    positionData = [NSMutableArray array];
    data1 = [NSMutableArray arrayWithArray:@[@"1",@"查看地图",@"公司介绍",@"无",@"在招职位(3个)"]];
    [self.dataListArr addObject:data1];
    [self.dataListArr addObject:positionData];
    NSArray *cellArr1 = @[@"LSCompanyDetailCell",@"LSMapCell",@"LSPositionHeadCell",@"LSTextCell",@"LSPositionHeadCell"];
    
    [self creatTableView:@[cellArr1,@"LSRecruitingCell"]];
    self.tableView.delegate  = self;
    self.tableView.edge(0,0,0,0);
    WeakSelf;
    self.tableViewKit.configureCellBlock = ^(id cell,LSUserModel *item,NSIndexPath *index)
    {
        if ([cell isKindOfClass:[LSCompanyDetailCell class]]) {
          LSCompanyDetailCell *cell1 = (LSCompanyDetailCell *)cell;
            cell1.attentionBtn.actionBlock = ^(UIButton *btn)
            {   //加关注
                [LSHttpKit getMethod:@"c=Circleuser&a=addConcern" parameters:@{@"side_id": item.member_id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    item.is_friend = @"1";
                    [weakSelf.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
                }];
            };
        }

    };
    
    [self  SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        if (indexPath.section == 0 ) {
            switch (indexPath.row) {
                case 0:
                    return 140;
                    break;
                case 1:
                    return 35;
                    break;
                case 2:
                    return 40;
                    break;
                case 3:
                {
                    NSString *str  = [data1 objectAtIndex:3];
                    return  [str getStrH:SCREEN_WIDTH-20 font:14]+20;
                }              
                    break;
                case 4:
                    return 40;
                    break;
                default:
                    return 44;
                    break;
            }
    
        }else
        {
            return 40;
        }
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    }];
    
}


-(void)httpRequest
{
    //企业详情
    if (self.companyID) {
        [self.parDic setObject:self.companyID forKey:@"company_id"];
    }
    [LSHttpKit getMethod:@"c=Company&a=CompanyDetails" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [companyModel setKeyValues:responseObject[@"data"]];
        companyModel.is_friend = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"is_friend"]];
        [data1 replaceObjectAtIndex:0 withObject:companyModel];
        if (ISNILSTR(companyModel.remark)) {
            [data1 replaceObjectAtIndex:3 withObject:@"无"];
             }else
        {
          [data1 replaceObjectAtIndex:3 withObject:companyModel.remark];
        }
      if (ISNILSTR(companyModel.addresss)) {
        [data1 replaceObjectAtIndex:1 withObject:@"无"];
      }else
      {
       [data1 replaceObjectAtIndex:1 withObject:companyModel.addresss];
      }
     [self.tableView reloadData];
        
    }];
    
    
    //发布的职位
    [LSHttpKit getMethod:@"c=Company&a=PostOffice" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *arr = responseObject[@"data"][@"list"];
        if (ISNOTNILARR(arr)) {
            for (NSDictionary *dic in arr) {
                LSPositionModel *model = [LSPositionModel objectWithKeyValues:dic];
                [positionData addObject:model];
            }
            [data1 replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"在招职位(%lu个)",(unsigned long)positionData.count]];
            [self.tableView reloadData];
        }
    }];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 1)
    {
        LSPositionModel *model = positionData[indexPath.row];
        LSPositionDetailVC *positionDetailVC = [[LSPositionDetailVC alloc] init];
        positionDetailVC.hidesBottomBarWhenPushed = YES;
        positionDetailVC.positionModel = model;
        [self.navigationController pushViewController:positionDetailVC animated:YES];
    
    }
    
    
}

@end

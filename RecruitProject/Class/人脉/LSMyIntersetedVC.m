//
//  LSMyIntersetedVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSMyIntersetedVC.h"
#import "LSIntersetedCell.h"
#import "LSPersonalHomePageVC.h"
#import "LSCircleVC.h"

@interface LSMyIntersetedVC ()<UITableViewDelegate>

@end

@implementation LSMyIntersetedVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    [self creatTableView:@"LSIntersetedCell"];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,0,0);
    [self addHeaderAndFooterRefresh];
  
    WeakSelf;
    self.tableViewKit.configureCellBlock = ^(id cell ,LSInterstedModel *item,NSIndexPath *index)
    {   UIButton *attentionBtn  = [(LSIntersetedCell *)cell attentionBtn];
        if (weakSelf.isPersonal) {
            
        attentionBtn.actionBlock = ^(UIButton *btn)
        {  //加关注
           [LSHttpKit getMethod:@"c=Circleuser&a=addConcern" parameters:@{@"side_id": item.member_id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
               item.is_friend = @"1";
               [weakSelf.tableView reloadData];
               [SVProgressHUD showSuccessWithStatus:@"关注成功"];
           }];
            
        };
        }else
        {
            attentionBtn.actionBlock = ^(UIButton *btn)
            {  
                //加入圈子
                [LSHttpKit getMethod:@"c=Circle&a=joinCircle" parameters:@{@"circle_id": item.circle_id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    item.is_friend = @"1";
                    [weakSelf.tableView reloadData];
                    [SVProgressHUD showSuccessWithStatus:@"成功加入圈子!"];
                }];

                
            };
            
        }
    };
    
}


-(void)httpRequest
{
    [self.parDic setObject:[NSString stringWithFormat:@"%ld",(long)self.offset] forKey:@"size"];
    if (self.isPersonal) {
        //感兴趣的人
        [self.parDic setObject:@"interestedPeople" forKey:@"a"];
        [self.parDic setObject:@"Circleuser" forKey:@"c"];
        [LSHttpKit getMethod:nil parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (self.page == 1) {
                [self.dataListArr removeAllObjects];
            }
            NSArray *arr = responseObject[@"data"][@"interestedPeople_list"];
            if (ISNOTNILARR(arr)) {
                for (NSDictionary *dic in arr) {
                    LSInterstedModel *model  =  [LSInterstedModel objectWithKeyValues:dic];
                    model.fromType = @"1";
                    [self.dataListArr addObject:model];
                }
                [self.tableView reloadData];
                [self endRefresh];
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"数据异常"];
                [self endRefresh];
            }
           
        }];
       
    }else
    {   //感兴趣的圈子
        [self.parDic setObject:@"interestedCircles" forKey:@"a"];
        [self.parDic setObject:@"Circle" forKey:@"c"];
        [LSHttpKit getMethod:nil parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (self.page == 1) {
                [self.dataListArr removeAllObjects];
            }
            NSArray *arr = responseObject[@"data"][@"circle_list"];
            if (ISNOTNILARR(arr)) {
                for (NSDictionary *dic in arr) {
                    LSInterstedModel *model  =  [LSInterstedModel objectWithKeyValues:dic];
                    model.fromType = @"2";
                    [self.dataListArr addObject:model];
                }
                [self.tableView reloadData];
                [self endRefresh];
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"数据异常"];
                [self endRefresh];
            }

        }];
       
    }

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSInterstedModel *model = self.dataListArr[indexPath.row];
    return [LSIntersetedCell GetCellH:model];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LSInterstedModel *model  = self.dataListArr[indexPath.row];
    if (_isPersonal) {
        LSPersonalHomePageVC *HomePageVC = [[LSPersonalHomePageVC alloc] init];
        HomePageVC.side_id = model.member_id;
        [self.navigationController pushViewController:HomePageVC animated:YES];
    }else
    {
        LSCircleVC  *circleVC = [[LSCircleVC alloc] init];
        circleVC.title = model.tb_name;
        circleVC.circle_id = model.circle_id;
        if ([model.is_friend isEqual:@"1"]) {
            circleVC.isAdd = YES;
        }
        [self.navigationController pushViewController:circleVC animated:YES];    
    }
   
}




@end

//
//  LSFoundVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/21.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSFoundVC.h"
#import "LSMyIntersetedVC.h"
#import "AppDelegate.h"
#import "LSPositionCell.h"
#import "LSIntersetedCell.h"
#import "LSPersonalHomePageVC.h"
#import "LSCircleVC.h"
#import "LSPositionDetailVC.h"
#import "LSCheckResumeVC.h"

@interface LSFoundVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *data1;
    NSMutableArray *data2;
    NSMutableArray *data3;

}
@end

@implementation LSFoundVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     data1 = [NSMutableArray array];
     data2 = [NSMutableArray array];
     data3 = [NSMutableArray array];
    
    if (APPDELEGETE.isCompany) {
        [data1 addObject:@"为您推荐的简历"];
        [data1 addObject:@"查看更多简历"];
    }else
    {
        [data1 addObject:@"为您推荐的职位"];
        [data1 addObject:@"查看更多职位"];
    }
        
    [data2 addObject:@"您可能感兴趣的人"];
    [data2 addObject:@"查看更多感兴趣的人"];
    
    [data3 addObject:@"可能感兴趣的圈子"];
    [data3 addObject:@"查看更多感兴趣的圈子"];
    
    [self.dataListArr addObjectsFromArray:@[data1,data2,data3]];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
   

    [self.tableView registerClass:[LSPositionCell class] forCellReuseIdentifier:@"LSPositionCell"];
    [self.tableView registerClass:[LSIntersetedCell class] forCellReuseIdentifier:@"LSIntersetedCell"];

    
    self.tableView.backgroundColor = color_bg;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.edge(0,0,0,0);
    
    [self addHeaderRefresh];
 
}

-(void)httpRequest
{
   
    if(APPDELEGETE.isCompany)
    {
        //推荐的简历
        [LSHttpKit getMethod:@"c=Company&a=RecommendedResumes" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (self.page == 1) {
                
                [data1 removeObjectsInRange:NSMakeRange(1, data1.count-2)];
            }
            [self endRefresh];
            NSArray *listarr = responseObject[@"data"];
            if(ISNOTNILARR(listarr))
            {
                NSInteger a = listarr.count>=3?3:listarr.count;
                for (int i = 0; i <a ; i++) {
                    LSPositionModel *model = [LSPositionModel objectWithKeyValues:listarr[i]];
                    model.fromType = @"2";
                    [data1 insertObject:model atIndex:1];
 
                }
                [self.tableView reloadData];
            }
        }];
    }else
    {
        //推荐的推荐职位
        NSDictionary *dic =@{@"c": @"Personal",
                             @"a": @"RecommendedPosition",
                             };
        [LSHttpKit getMethod:nil parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (self.page == 1) {
                [data1 removeObjectsInRange:NSMakeRange(1, data1.count-2)];
            }
            [self endRefresh];
            NSArray *listarr = responseObject[@"data"][@"list"];
            if (ISNOTNILARR(listarr)) {
                NSInteger a = listarr.count>=3?3:listarr.count;
                for (int i = 0; i <a ; i++) {
                    LSPositionModel *model = [LSPositionModel objectWithKeyValues:listarr[i]];
                    model.fromType = @"1";
                    [data1 insertObject:model atIndex:1];
                   
                }
//                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                 [self.tableView reloadData];
            }
            
        }];
    }
    
    //感兴趣的人
    NSDictionary *dic2 =@{@"c": @"Circleuser",
                          @"a": @"interestedPeople",
                          };
    [LSHttpKit getMethod:nil parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (self.page == 1) {
             [data2 removeObjectsInRange:NSMakeRange(1, data2.count-2)];
        }
        [self endRefresh];
        NSArray *listarr = responseObject[@"data"][@"interestedPeople_list"];
        if (ISNOTNILARR(listarr)) {
            NSInteger a = listarr.count>=3?3:listarr.count;
            for (int i = 0; i <a ; i++) {
                LSInterstedModel *model = [LSInterstedModel objectWithKeyValues:listarr[i]];
                model.fromType = @"1";
                [data2 insertObject:model atIndex:1];
            }
           
            [self.tableView reloadData];
        }
       
    }];
    
//    //感兴趣的圈子
    NSDictionary *dic1 =@{@"c": @"Circle",
                          @"a": @"interestedCircles",
                         };
    [LSHttpKit getMethod:nil parameters:dic1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (self.page == 1) {
           [data3 removeObjectsInRange:NSMakeRange(1, data3.count-2)];
        }
        [self endRefresh];
        NSArray *listarr =responseObject[@"data"][@"circle_list"];
        if (ISNOTNILARR(listarr)) {
            NSInteger a = listarr.count>=3?3:listarr.count;
            for (int i = 0; i <a ; i++) {
                LSInterstedModel *model = [LSInterstedModel objectWithKeyValues:listarr[i]];
                [data3 insertObject:model atIndex:1];
                model.fromType = @"2";
            }
        [self.tableView reloadData];
        }
     
    }];
    
  
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return [self.dataListArr[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        static NSString *cellID  =  @"headerCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            UILabel *label = [UILabel labelWithText:self.dataListArr[indexPath.section][0] color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
            label.tag = 11;
            [cell.contentView addSubview:label];
            label.edge(0,10,0,0);
        }
        UILabel *label =  (UILabel *)[cell.contentView viewWithTag:11];
        label.text = self.dataListArr[indexPath.section][0];
        
    }else if (indexPath.row+1 == [self.dataListArr[indexPath.section] count]) {
        //最后一行
        static NSString *cellID  =  @"footerCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            UILabel *label = [UILabel labelWithText:self.dataListArr[indexPath.section][indexPath.row] color:color_black font:12 Alignment:LSLabelAlignment_center];
            [cell.contentView addSubview:label];
            label.tag = 11;
            label.edge(0,10,0,0);
        }
        UILabel *label =  (UILabel *)[cell.contentView viewWithTag:11];
        label.text = self.dataListArr[indexPath.section][indexPath.row];
        
    }else
    {
        if (indexPath.section == 0) {
            static NSString *cellID  =  @"LSPositionCell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellID
                                                   forIndexPath:indexPath];
            LSPositionCell *interstedCell = (LSPositionCell*)cell;
            LSPositionModel *model = data1[indexPath.row];
            [interstedCell configCell:model];
        }else
        {
            LSInterstedModel *model;
            static NSString *cellID  =  @"LSIntersetedCell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellID
                                                   forIndexPath:indexPath];
            LSIntersetedCell *interstedCell = (LSIntersetedCell*)cell;
            WeakSelf;
            UIButton *attentionBtn  = [(LSIntersetedCell *)cell attentionBtn];
            if(indexPath.section == 1)
            {   //人
                if (data2.count > 2) {
                    model = data2[indexPath.row];
                    attentionBtn.actionBlock = ^(UIButton *btn)
                    {  //加关注
                        [LSHttpKit getMethod:@"c=Circleuser&a=addConcern" parameters:@{@"side_id": model.member_id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            model.is_friend = @"1";
                            [weakSelf.tableView reloadData];
                            [SVProgressHUD showSuccessWithStatus:@"关注成功!"];
                        }];
                        
                    };
                }
               
             
                
            }else  if(indexPath.section == 2)
            {    //圈子
                if (data3.count > 2) {
                    model = data3[indexPath.row];
                    attentionBtn.actionBlock = ^(UIButton *btn)
                    {  //加入圈子
                        [LSHttpKit getMethod:@"c=Circle&a=joinCircle" parameters:@{@"circle_id": model.circle_id} success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            model.is_friend = @"1";
                            [weakSelf.tableView reloadData];
                            [SVProgressHUD showSuccessWithStatus:@"成功加入圈子!"];
                        }];
                        
                    };
                }
            
            }
          
            [interstedCell configCell:model];
        }
        
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
      //第一行
      return 40;
    }else if (indexPath.row+1 == [self.dataListArr[indexPath.section] count]) {
      //最后一行
      return 30;
    }else
    {
        if (indexPath.section == 0) {
            if (APPDELEGETE.isCompany) {
                 return 60;
            }
             return 80;
        }else
        {
        CGFloat H  = 60;
        if (indexPath.section == 1) {
            //人
            if (data2.count>2) {
                LSInterstedModel *model = data2[indexPath.row];
            H =   [LSIntersetedCell GetCellH:model];
            }
           
        }else
        {   //圈子
            if (data3.count>3) {
            LSInterstedModel *model = data3[indexPath.row];
            H = [LSIntersetedCell GetCellH:model];
            }
        }
           return H;
        }
      
    }
    
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
    if (indexPath.row == 0) {
      
        
    }else if (indexPath.row+1 == [self.dataListArr[indexPath.section] count]) {
        //查看更多
        if (indexPath.section == 1) {
            LSMyIntersetedVC *intersetedVC  = [[LSMyIntersetedVC alloc] init];
            intersetedVC.title = self.dataListArr[indexPath.section][indexPath.row];
            intersetedVC.hidesBottomBarWhenPushed = YES;
            intersetedVC.title = @"可能感兴趣的人";
            intersetedVC.isPersonal = YES;
            [self.navigationController pushViewController:intersetedVC animated:YES];
        }else if (indexPath.section == 2)
        {
            LSMyIntersetedVC *intersetedVC  = [[LSMyIntersetedVC alloc] init];
            intersetedVC.title = self.dataListArr[indexPath.section][indexPath.row];
            intersetedVC.hidesBottomBarWhenPushed = YES;
            intersetedVC.title = @"可能感兴趣的圈子";
            intersetedVC.isPersonal = NO;
            [self.navigationController pushViewController:intersetedVC animated:YES];
        }else
        {
            self.tabBarController.selectedIndex = 1;  
        }
      
    }else
    {
        if (indexPath.section == 1) {
            LSInterstedModel *model  = data2[indexPath.row];
            LSPersonalHomePageVC *HomePageVC = [[LSPersonalHomePageVC alloc] init];
            HomePageVC.side_id = model.member_id;
            HomePageVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:HomePageVC animated:YES];
        }else if (indexPath.section == 2)
        {   LSInterstedModel *model  = data3[indexPath.row];
            LSCircleVC  *circleVC = [[LSCircleVC alloc] init];
            circleVC.title = model.tb_name;
            circleVC.circle_id = model.circle_id;
            if([model.is_friend isEqual:@"1"])
            {
                circleVC.isAdd = YES;
            }
            circleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:circleVC animated:YES];
        }else
        {
            LSPositionModel *model = (LSPositionModel *)data1[indexPath.row];
            if (APPDELEGETE.isCompany) {
            //简历详情
                
                LSCheckResumeVC *checkResumeVC = [[LSCheckResumeVC alloc] init];
                checkResumeVC.title = model.truename;
                checkResumeVC.resumeID = model.resumes_id;
                checkResumeVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:checkResumeVC animated:YES];
                
            }else
            {  //职位详情
                LSPositionDetailVC *positionDetailVC = [[LSPositionDetailVC alloc] init];
                positionDetailVC.positionModel = model;
                positionDetailVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:positionDetailVC animated:YES];
            }
        }
    }

  
}


@end

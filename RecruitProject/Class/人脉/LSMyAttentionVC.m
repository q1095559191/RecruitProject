//
//  LSMyAttentionVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSMyAttentionVC.h"
#import "ChineseString.h"
#import "LSAttentionCell.h"
#import "LSPersonalHomePageVC.h"
#import "LSCompanyDetailVC.h"

@interface LSMyAttentionVC ()<UITableViewDelegate>
@property(nonatomic,retain)NSMutableArray *indexArray;
@property(nonatomic,retain)NSMutableArray *LetterResultArr;
@end

@implementation LSMyAttentionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isAppearRefresh = YES;
   [self creatTableView:@"LSAttentionCell"];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,0,0);
    
}


-(void)httpRequest
{
 
    
    if (self.isPersonal) {
        [self.parDic setObject:@"0" forKey:@"follow_user_type"];
    }else
    {
        [self.parDic setObject:@"1" forKey:@"follow_user_type"];
    }
[LSHttpKit getMethod:@"c=Circleuser&a=followFriend" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
    if (self.page == 1) {
        [self.dataListArr removeAllObjects];
    }
    NSArray * list = responseObject[@"data"][@"m_social_list"];
    if (ISNOTNILARR(list)) {
        NSMutableArray *titleArr = [NSMutableArray array];
        NSMutableArray *modelArr = [NSMutableArray array];
        for (NSDictionary *dic in list) {
            LSAttentionModel *model = [LSAttentionModel objectWithKeyValues:dic];
            if(model.name.length >= 1)
            {
                [titleArr addObject:model.name];
                [modelArr addObject:model];
            }
            
        }
        //处理
        self.indexArray = [ChineseString IndexArray:titleArr];
        self.LetterResultArr = [ChineseString LetterSortArray:titleArr];
       
        for (int i = 0; i < self.indexArray.count; i++) {
            NSArray *arr = self.LetterResultArr[i];
            NSMutableArray *item= [NSMutableArray array];
            for (NSString *name in arr) {
                LSAttentionModel *model = [self getAttentionModel:modelArr name:name];
                if (model) {
                    [item addObject:model];
                }
            }
            [self.dataListArr addObject:item];
        }

     
    }
   
    if (self.isPersonal) {
        [self handleNilData:@"您还未关注任何好友" image:nil];
    }else
    {
        [self handleNilData:@"您还未关注任何企业" image:nil];
    }
    [self.tableView reloadData];
    
}];

}

-(LSAttentionModel *)getAttentionModel:(NSArray*)arr  name:(NSString *)nameStr
{
    for (LSAttentionModel*model in arr) {
       
        NSString *str1 = [NSString stringWithFormat:@"%@",model.name];
        NSString *str2 =[ChineseString RemoveSpecialCharacter:nameStr];
        if ([str1 hasPrefix:str2]) {
            return model;
        }
    }
    
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc] init];
    lab.backgroundColor = [UIColor clearColor];
    if (self.indexArray) {
        if (self.indexArray.count >= 1  && section < self.indexArray.count) {
            lab.text = [NSString stringWithFormat:@"  %@",[self.indexArray objectAtIndex:section]];
        }
      
    }
    lab.textColor = [UIColor blackColor];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.frame = CGRectMake(0, 0, 40, 20);
    
    return lab;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LSAttentionModel *model = self.dataListArr[indexPath.section][indexPath.row];
    if(self.isPersonal)
    {
        LSPersonalHomePageVC *HomePageVC = [[LSPersonalHomePageVC alloc] init];
        HomePageVC.side_id =  model.member_info[@"member_id"];
        HomePageVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:HomePageVC animated:YES];
    }else
    {
        LSCompanyDetailVC *companyDetailVC  = [[LSCompanyDetailVC alloc] init];
        companyDetailVC.companyID = model.member_info[@"member_id"];
        [self.navigationController pushViewController:companyDetailVC animated:YES];
    
    }
}



@end

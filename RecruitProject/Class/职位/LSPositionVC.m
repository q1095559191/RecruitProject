//
//  LSPositionVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/21.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSPositionVC.h"
#import "LSPositionCell.h"
#import "LSPositionDetailVC.h"
#import "LSPositionSearchVC.h"
#import "LSCheckResumeVC.h"
#import "LSChoiceAddressView.h"
@interface LSPositionVC ()<UITableViewDelegate,UISearchBarDelegate>
{
    LSChoiceItems *choiceKit;
    LSCheckView  *choiceView;
    LSCheckModel *checkModel;
    
}
@property (strong, nonatomic)  UISearchBar *searchBar;
@end

@implementation LSPositionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    checkModel = [[LSCheckModel alloc] init];
    self.offset = 10;
    //搜索条
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.backgroundColor = [UIColor clearColor];
    [self.searchBar setKeyboardType:UIKeyboardTypeDefault];
    if(APPDELEGETE.isCompany)
    {
      self.searchBar.placeholder = @"搜索简历";
    }else
    {
         self.searchBar.placeholder = @"搜索职位";
    }
    self.navigationItem.titleView =  self.searchBar;

    
    //搜索页面
    UIButton *btn = [UIButton buttonWithImage:@"btn_screening_wihte" action:^(UIButton *btn) {
        LSPositionSearchVC *searchVC = [[LSPositionSearchVC alloc] init];
        searchVC.checkModel = checkModel;
        searchVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:searchVC animated:YES];
    }];
    btn.frame = CGRectMake(0, 0, 30, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self addHeaderAndFooterRefresh];
    self.isAppearRefresh = YES;
    

}

-(void)httpRequest
{
    [SVProgressHUD show];
    
    if (checkModel.tb_salary) {
        [self.parDic setObject:checkModel.tb_salary forKey:@"tb_salary"];
    }else{
        [self.parDic setObject:@"" forKey:@"tb_salary"];
    }
    if (checkModel.dayscope) {
        [self.parDic setObject:checkModel.dayscope forKey:@"dayscope"];
    }else{
        [self.parDic setObject:@"" forKey:@"dayscope"];
    }
    if (checkModel.tb_degree) {
        [self.parDic setObject:checkModel.tb_degree forKey:@"tb_degree"];
    }else{
        [self.parDic setObject:@"" forKey:@"tb_degree"];
    }
    if (checkModel.keyword) {
        [self.parDic setObject:checkModel.keyword forKey:@"keyword"];
    }else{
        [self.parDic setObject:@"" forKey:@"keyword"];
    }
    if (checkModel.tb_city) {
        if ([checkModel.tb_city hasSuffix:@"市"]) {
            checkModel.tb_city   =  [checkModel.tb_city substringWithRange:NSMakeRange(0, checkModel.tb_city.length-1)];
        }
        [self.parDic setObject:checkModel.tb_city forKey:@"tb_city"];
    }else{
        [self.parDic setObject:@"" forKey:@"tb_city"];
    }
    if (checkModel.tb_jobtype) {
        [self.parDic setObject:checkModel.tb_jobtype forKey:@"tb_jobtype"];
    }else{
        [self.parDic setObject:@"" forKey:@"tb_jobtype"];
    }
    if (checkModel.tb_jobtype_two) {
        [self.parDic setObject:checkModel.tb_jobtype_two forKey:@"tb_jobtype_two"];
    }else{
        [self.parDic setObject:@"" forKey:@"tb_jobtype_two"];
    }
    if (checkModel.tb_worknature) {
        [self.parDic setObject:checkModel.tb_worknature forKey:@"tb_worknature"];
    }else{
        [self.parDic setObject:@"" forKey:@"tb_worknature"];
    }
    if (checkModel.tb_workyear) {
        [self.parDic setObject:checkModel.tb_workyear forKey:@"tb_workyear"];
    }else{
        [self.parDic setObject:@"" forKey:@"tb_workyear"];
    }
    
    
    if (APPDELEGETE.isCompany) {
        //简历搜索
        [self.parDic setObject:@"SearchResume" forKey:@"a"];
        [self.parDic setObject:@"Company" forKey:@"c"];
        [LSHttpKit getMethod:nil parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            if (self.page == 1) {
                [self.dataListArr removeAllObjects];
            }
            [self endRefresh];
            
            for (NSDictionary *dic in responseObject[@"data"][@"list"]) {
            LSPositionModel *model = [LSPositionModel objectWithKeyValues:dic];
            model.fromType = @"4";
            [self.dataListArr addObject:model];
            }
            [self.tableView reloadData];
        }];
        
    }else
    {   //职位搜索
        [self.parDic setObject:@"JobSearch" forKey:@"a"];
        [self.parDic setObject:@"Personal"  forKey:@"c"];
        [LSHttpKit getMethod:nil parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            if (self.page == 1) {
                [self.dataListArr removeAllObjects];
            }
            [self endRefresh];
            for (NSDictionary *dic in responseObject[@"data"][@"list"]) {
                LSPositionModel *model = [LSPositionModel objectWithKeyValues:dic];
                 model.fromType = @"3";
                [self.dataListArr addObject:model];
            }
            [self.tableView reloadData];
        }];
    }
}


-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    LSPositionSearchVC *searchVC = [[LSPositionSearchVC alloc] init];
    searchVC.checkModel = checkModel;
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
    return NO;
}


-(void)creatContentView
{
     NSArray *checkArr1 =  [NSObject getInfo:4];
     NSArray *checkArr2 =  [NSObject getInfo:18];
     NSArray *checkArr3 =  [NSObject getInfo:6];
     NSArray *checkArr  =   @[checkArr1,checkArr2,checkArr3];
    
    [self creatTableView:@"LSPositionCell"];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,40,0);
    NSArray *titles = @[@"月薪范围",@"发布时间",@"最低学历"];
    CGFloat w = SCREEN_WIDTH /3;
    for (int i = 0; i<titles.count; i++) {
        UIButton *btn = [UIButton buttonWithTitle:titles[i] titleColor:[UIColor lightGrayColor] BackgroundColor:color_white action:^(UIButton *btn) {
            if (choiceView) {
                if (!choiceView.superview) {
                    btn.selected = NO;
                }
                [choiceView removeFromSuperview];
            }
            if (btn.selected) {
                btn.selected = NO;
            }else
            {
                choiceView = [LSCheckView checkViewInView:self.view titles:checkArr[i] checkModel:checkModel cancle:^() {
                    if (i == 0) {
                        checkModel.tb_salary = [choiceView getSelsctedStr:checkArr[i]];
                    }
                    if (i == 1) {
                        checkModel.dayscope = [choiceView getSelsctedStr:checkArr[i]];
                    }
                    if (i == 2) {
                        checkModel.tb_degree = [choiceView getSelsctedStr:checkArr[i]];
                    }
                    [self  httpRequest];
                }];
                
                NSString *str ;
                if (i == 0) {
                    str =  checkModel.tb_salary;
                }
                if (i == 1) {
                    str =   checkModel.dayscope;
                }
                if (i == 2) {
                    str =   checkModel.tb_degree;
                }
                //获取记录的选中状态
                choiceView.selectedIndex = [checkModel getSeleted:str data:checkArr[i]];
                btn.selected = YES;
            }
        }];
        [self.tableView addSubview:btn];
        [btn setfont:14];
         btn.frame = CGRectMake(w*i, 0, w, 50);
        [btn setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 35)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, w-20, 0, 0)];
        UIView *line = [[UIView alloc] init];
        [self.tableView addSubview:line];
        line.backgroundColor = color_line;
        line.frame = CGRectMake(w*i, 0, 0.5, 50);
      
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(APPDELEGETE.isCompany)
    {
        return 60;
    }else
    {
     return 80;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 70;
    }
   return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (APPDELEGETE.isCompany) {
      //简历详情
        LSPositionModel *model  =   self.dataListArr[indexPath.row];
        LSCheckResumeVC *resumeDetailVC = [[LSCheckResumeVC alloc] init];
        resumeDetailVC.title = model.truename;
        resumeDetailVC.resumeID = model.resumes_id;
        resumeDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:resumeDetailVC animated:YES];
        
    }else
    {
        //职位详情
        LSPositionDetailVC *positionDetailVC = [[LSPositionDetailVC alloc] init];
        positionDetailVC.hidesBottomBarWhenPushed = YES;
        positionDetailVC.positionModel = self.dataListArr[indexPath.row];
        [self.navigationController pushViewController:positionDetailVC animated:YES];
    }
  
}

@end

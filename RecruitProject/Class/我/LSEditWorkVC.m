//
//  LSEditWorkVC.m
//  RecruitProject
//
//  Created by sliu on 15/10/28.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSEditWorkVC.h"
#import "LSChoiceView.h"

@interface LSEditWorkVC ()
{
    LSTimePickerView *timeView;
    LSChoiceView *choiceView;
    NSArray *salaryArr;
    NSArray *postArr;
}

@end

@implementation LSEditWorkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"工作经历";
    salaryArr = [NSObject getInfoWithBaseModel:4];
    postArr = [NSObject getInfoWithBaseModel2:16 defineStr:nil];

    NSArray *titles = @[@"所在公司",@"开始时间",@"结束时间",@"薪资",@"所在职位",@"工作性质描述"];
    NSArray *recordArr;
    if (self.recordDic) {
        recordArr = @[@"tb_unitname",@"tb_startday",@"tb_endday",@"tb_salary",@"tb_post",@"tb_txt"];
        //添加删除按钮
        UIButton *deletBtn = [UIButton buttonWithTitle:@"删除" titleColor:color_white BackgroundColor:color_clear action:^(UIButton *btn) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:self.recordDic[@"record_id"] forKey:@"record_id"];
            [dic setValue:self.resumes_id forKey:@"resumes_id"];
            
           [LSHttpKit getMethod:@"c=Personal&a=DeleteExperience" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
               [SVProgressHUD showSuccessWithStatus:@"删除成功"];
               [self.navigationController popViewControllerAnimated:YES];
           }];
        }];
        deletBtn.frame = CGRectMake(0, 0, 40, 30);
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:deletBtn];
        [deletBtn setfont:14];
        
    }
    
    for (int i = 0; i < titles.count; i++) {
        NSString *str = titles[i];
        LSBaseModel *model = [[LSBaseModel alloc] init];
        model.title = str;
        if (i == 1|| i == 2|| i == 3|| i == 4) {
            model.type = @"1";
        }else
        {
            model.type = @"0";
        }
        if (recordArr) {
            if (i == 3) {
              model.index = [self.recordDic valueForKey:recordArr[i]];
              model.detailTile = [NSObject getInfoDetail:model.index];
            }else
            {
            model.detailTile = [self.recordDic valueForKey:recordArr[i]];
            }
            
        }
        
        [self.dataListArr addObject:model];
    }
   
    
    [self creatTableView:@"LSMineSettingCell"];
    self.tableView.edge(0,0,40,0);
    self.tableView.delegate = self;
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return 40;
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    }];
    
    UIButton *btn = [UIButton buttonWithTitle:@"保存" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
        
        NSString *record_id;
        if (self.recordDic) {
            //修改
            record_id = self.recordDic[@"record_id"];
        }else
        {   //添加
            record_id = @"0";
        }
        NSString *tb_unitname = [(LSBaseModel*)self.dataListArr[0] detailTile];
        NSString *tb_startday = [(LSBaseModel*)self.dataListArr[1] detailTile];
        NSString *tb_endday   = [(LSBaseModel*)self.dataListArr[2] detailTile];
        NSString *tb_salary   = [(LSBaseModel*)self.dataListArr[3] index];
        NSString *tb_post     = [(LSBaseModel*)self.dataListArr[4] detailTile];
        NSString *tb_txt      = [(LSBaseModel*)self.dataListArr[5] detailTile];
        
        [self.parDic setObject:record_id forKey:@"record_id"];
        [self.parDic setObject:tb_unitname forKey:@"tb_unitname"];
        [self.parDic setObject:tb_startday forKey:@"tb_startday"];
        [self.parDic setObject:tb_endday forKey:@"tb_endday"];
        [self.parDic setObject:tb_salary forKey:@"tb_salary"];
        [self.parDic setObject:tb_post forKey:@"tb_post"];
        [self.parDic setObject:tb_txt forKey:@"tb_txt"];
        
        if (!tb_unitname) {
            [SVProgressHUD showErrorWithStatus:@"请输入公司名称"];
        }
        if (!tb_startday) {
            [SVProgressHUD showErrorWithStatus:@"请选择开始时间"];
        }
        if (!tb_endday) {
            [SVProgressHUD showErrorWithStatus:@"请选择结束时间"];
        }
        if (!tb_salary) {
            [SVProgressHUD showErrorWithStatus:@"请选择薪资"];
        }
        if (!tb_post) {
            [SVProgressHUD showErrorWithStatus:@"请选择所在职位"];
        }
        if (!tb_txt) {
            [SVProgressHUD showErrorWithStatus:@"请填写工作性质"];
        }
        [self.parDic setObject:self.resumes_id forKey:@"resumes_id"];
        [LSHttpKit getMethod:@"c=Personal&a=ChangeWorkingExperience" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }];
    [self.view addSubview:btn];
    btn.edgeNearbottom(0,0,0,30);
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WeakSelf;
    LSBaseModel *model = [self.dataListArr objectAtIndex:indexPath.row];
    if (indexPath.row == 1 || indexPath.row == 2) {
        //时间选择
        timeView = [LSTimePickerView TimePickerView];
        timeView.okBlock = ^(LSTimePickerView *time)
        {
            model.detailTile = time.currentTime;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        [timeView show];
        
    }else if ( indexPath.row == 3)
    {
       //薪资
       choiceView = [LSChoiceView ChoiceViewInView:self.view titles:salaryArr cancle:^(UIButton *btn) {
           LSBaseModel *model_sel = salaryArr[choiceView.selectedIndex];
           model.detailTile = model_sel.title;
           model.index    = model_sel.index;
           [self.tableView reloadData];
       }];
        
    
    }else if ( indexPath.row == 4)
    {
        //所在职位

        choiceView = [LSChoiceView ChoiceViewInView:self.view titles:postArr cancle:^(UIButton *btn) {
           
            LSBaseModel *model_sel1 = postArr[choiceView.selectedIndex];
            LSBaseModel *model_sel = model_sel1.subArr[choiceView.selectedIndex2];
            model.detailTile = model_sel.title;
            model.index    =   model_sel.index;
            [self.tableView reloadData];
        }];
       
    }
   
   
    
   
}


@end

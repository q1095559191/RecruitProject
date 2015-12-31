//
//  LSEditEducationVC.m
//  RecruitProject
//
//  Created by sliu on 15/10/28.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSEditEducationVC.h"
#import "LSChoiceView.h"
@interface LSEditEducationVC ()
{
    LSTimePickerView *timeView;
    LSChoiceView *choiceView;
    NSArray *unitArr;
}

@end

@implementation LSEditEducationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"教育经历";
    unitArr = [NSObject getInfoWithBaseModel:6];
    
    NSArray *titles = @[@"学校名称",@"开始时间",@"结束时间",@"专业名称",@"学历"];
    NSArray *recordArr;
    if (self.recordDic) {
        recordArr = @[@"tb_unitname",@"tb_startday",@"tb_endday",@"tb_unittype",@"tb_post"];
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
        if ([str isEqualToString:@"开始时间"] || [str isEqualToString:@"结束时间"] || [str isEqualToString:@"学历1"]) {
            model.type = @"1";
        }else
        {
            model.type = @"2";
        }
        if(recordArr)
        {
            if (i == 4) {
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
        NSString *tb_unittype = [(LSBaseModel*)self.dataListArr[3] detailTile] ;
        NSString *tb_post     = [(LSBaseModel*)self.dataListArr[4] index];
        
        [self.parDic setObject:record_id      forKey:@"record_id"];
        [self.parDic setObject:tb_unitname    forKey:@"tb_unitname"];
        [self.parDic setObject:tb_startday    forKey:@"tb_startday"];
        [self.parDic setObject:tb_endday      forKey:@"tb_endday"];
        [self.parDic setObject:tb_unittype    forKey:@"tb_unittype"];
        [self.parDic setObject:tb_post        forKey:@"tb_post"];
        
        if (!tb_unitname) {
            [SVProgressHUD showErrorWithStatus:@"请输入学校名称名称"];
        }
        if (!tb_startday) {
            [SVProgressHUD showErrorWithStatus:@"请选择开始时间"];
        }
        if (!tb_endday) {
            [SVProgressHUD showErrorWithStatus:@"请选择结束时间"];
        }
      
        if (!tb_unittype) {
            [SVProgressHUD showErrorWithStatus:@"请填写专业名称"];
        }
        
        if (!tb_post) {
            [SVProgressHUD showErrorWithStatus:@"请选择学历"];
        }
        [self.parDic setObject:self.resumes_id forKey:@"resumes_id"];
        [LSHttpKit getMethod:@"c=Personal&a=ChangeEducationExperience" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }];
    [self.view addSubview:btn];
    btn.edgeNearbottom(0,0,0,30);
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        
    }else if ( indexPath.row == 4)
    {
        //学历
        choiceView = [LSChoiceView ChoiceViewInView:self.view titles:unitArr cancle:^(UIButton *btn) {
            LSBaseModel *model_sel = unitArr[choiceView.selectedIndex];
            model.detailTile = model_sel.title;
            model.index    = model_sel.index;
            [self.tableView reloadData];
        }];
        
    }


}

@end

//
//  LSResumeDetailVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/24.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSResumeDetailVC.h"
#import "LSResumeModel.h"
#import "LSRecordCell.h"
#import "LSHeadCell.h"
#import "LSResumeMyInfoCell.h"
#import "LSEditEducationVC.h"
#import "LSEditEvaluation.h"
#import "LSEditLanguageVC.h"
#import "LSEditWorkVC.h"
#import "LSResumeMimeSettingVC.h"
@interface LSResumeDetailVC ()
{
    UITableView *resumeMeunView;
    
    LSUserModel *userModel;
    LSRecordModel *recordModel1;   //语言能力
    LSRecordModel *recordModel2;   //自我评价
    LSRecordModel *recordModel3;   //工作经历
    LSRecordModel *recordModel4;   //教育经历
    
}
@end
@implementation LSResumeDetailVC

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    //编辑工作经历和教育经历的通知
    [self addObserverIndex:@"edit"];
    WeakSelf;
    self.tableViewKit.configureCellBlock = ^(id cell,id item,NSIndexPath *index)
    {
        //编辑个人资料
        if ([cell isKindOfClass:[LSResumeMyInfoCell class]]) {
            LSResumeMyInfoCell *resumeCell  =   (LSResumeMyInfoCell *)cell;
            LSUserModel *model = (LSUserModel *)item;
            resumeCell.openBtn.actionBlock = ^(UIButton *btn)
            {
                model.isOpen = ! model.isOpen;
                [weakSelf.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
            };
          
            resumeCell.editBtn.actionBlock = ^(UIButton *btn)
            {
                LSResumeMimeSettingVC *settingVC = [[LSResumeMimeSettingVC alloc] init];
                settingVC.userModel = item;
                settingVC.resumes_id = weakSelf.resume_id;
                [weakSelf.navigationController pushViewController:settingVC animated:YES];
            };
        }
        //编辑简历
        if ([cell isKindOfClass:[LSHeadCell class]]) {
            LSHeadCell *resumeCell  =   (LSHeadCell *)cell;
            resumeCell.editBtn.actionBlock = ^(UIButton *btn)
            {
                LSRecordModel *model  = weakSelf.dataListArr[index.section][1];
                if (index.section == 1) {
                LSEditWorkVC  *vc = [[LSEditWorkVC alloc] init];
                vc.resumes_id  = weakSelf.resume_id;
                vc.title =  item[0];
                [weakSelf.navigationController pushViewController:vc animated:YES];
                }
                if (index.section == 2) {
                LSEditEducationVC  *vc = [[LSEditEducationVC alloc] init];
                vc.resumes_id  = weakSelf.resume_id;
                vc.title =  item[0];
                [weakSelf.navigationController pushViewController:vc animated:YES];
                }
                if (index.section == 3) {
                LSEditLanguageVC  *vc = [[LSEditLanguageVC alloc] init];
                vc.languageStr =  model.tb_txt;
                vc.resumes_id  = weakSelf.resume_id;
                vc.title =  item[0];
                [weakSelf.navigationController pushViewController:vc animated:YES];
                    
                }
                if (index.section == 4) {
                 LSEditEvaluation  *vc = [[LSEditEvaluation alloc] init];
                 vc.evaluationStr = model.text;
                 vc.resumes_id  = weakSelf.resume_id;
                 vc.title =  item[0];
                [weakSelf.navigationController pushViewController:vc animated:YES];
                    
                }
            };
        }
    };
   
    self.isAppearRefresh = YES;
}


-(void)httpRequest
{
    //获取简历详情
    
    [self.parDic setValue:self.resume_id forKey:@"resume_id"];    

    [LSHttpKit getMethod:@"c=Personal&a=ResumeDetails" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {

    NSDictionary *dic = responseObject[@"data"][@"list"];
    if (ISNOTNILDIC(dic)) {
        [userModel setKeyValues:dic];
        //语言能力
        if(ISNOTNILSTR(userModel.tb_foreignlanguage))
        {
           if (userModel.tb_foreignlanguage.length != 0) {
              recordModel1.text = [NSString stringWithFormat:@"语言能力      %@",userModel.tb_foreignlanguage];
               recordModel1.tb_txt = userModel.tb_foreignlanguage;
            }else
            {
             recordModel1.text = @"请填写您的语言能力";
            }
           
        }else
        {
             recordModel1.text = @"请填写您的语言能力";
        }
        
        //自我评价
        if (userModel.tb_selfassessment) {
           recordModel2.text = userModel.tb_selfassessment;
        }else
        {
           recordModel2.text = @"请填写您的自我评价";
        }
        
        
        NSArray *records = dic[@"record"];
        if(ISNOTNILARR(records))
        {
            if (!recordModel3.listArr) {
                recordModel3.listArr = [NSMutableArray array];
            }else
            {
                [recordModel3.listArr removeAllObjects];
            }
            if (!recordModel4.listArr) {
                recordModel4.listArr = [NSMutableArray array];
            }else
            {
                [recordModel4.listArr removeAllObjects];
            }
            for (NSDictionary *dic in records) {
                NSString *type = dic[@"tb_type"];
                if ( [type isEqualToString:@"experience"]) {
                   
                    
                    [recordModel3.listArr addObject:dic];
                    if (recordModel3.listArr.count >=1) {
                        userModel.companyName = recordModel3.listArr[0][@"tb_unitname"];
                    }else
                    {
                        userModel.companyName = @"无";
                    }
                    
                }
                
                if ( [type isEqualToString:@"education"]) {
                   
                    [recordModel4.listArr addObject:dic];
                }
                
            }
            
            
        }
        if (recordModel4.listArr.count == 0) {
          recordModel4.text = @"请填写您的教育经历";
        }
        
        if (recordModel3.listArr.count == 0) {
            recordModel3.text = @"请填写您的工作经历";
        }
        
        [self.tableView reloadData];
    }
    
}];

}

-(void)creatContentView
{
    
    userModel  = [[LSUserModel alloc] init];
    [self.dataListArr addObject:@[userModel]];
    
    recordModel3 = [[LSRecordModel alloc] init];
    recordModel3.tb_type = @"3";
    recordModel4 = [[LSRecordModel alloc] init];
    recordModel4.tb_type = @"4";
    recordModel3.isEdit = YES;
    recordModel4.isEdit = YES;
    
    [self.dataListArr addObject:@[@[@"工作经历"],recordModel3]];
    [self.dataListArr addObject:@[@[@"教育经历"],recordModel4]];
    
    recordModel1 = [[LSRecordModel alloc] init];
    recordModel1.tb_type = @"1";
    recordModel2 = [[LSRecordModel alloc] init];
    recordModel2.tb_type = @"2";
    
    
    [self.dataListArr addObject:@[@[@"语言能力"],recordModel1]];
    [self.dataListArr addObject:@[@[@"自我评价"],recordModel2]];
    
    NSMutableArray *cellArr = [NSMutableArray array];
    [cellArr addObject:@[@"LSResumeMyInfoCell"]];
    [cellArr addObject:@[@"LSHeadCell",@"LSRecordCell"]];
    [cellArr addObject:@[@"LSHeadCell",@"LSRecordCell"]];
    [cellArr addObject:@[@"LSHeadCell",@"LSRecordCell"]];
    [cellArr addObject:@[@"LSHeadCell",@"LSRecordCell"]];
    
    [self creatTableView:cellArr];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,30,0);
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        
        if (indexPath.section == 0) {
            if (userModel.isOpen) {
                return 225+2*40;
            }else
            {
                return 225;
            }
            
        }else
        {
            if (indexPath.row == 0) {
                return 50;
            }else
            {
             return [LSRecordCell GetCellH:self.dataListArr[indexPath.section][indexPath.row]];
            }
        }
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 10;
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self creatMenu];

}



-(void)creatMenu
{
    NSArray *titles = @[@"基本信息",@"工作经历",@"教育经历",@"语言能力",@"自我评价"];
    NSArray *images = @[@"icon_resume_info",@"icon_resume_work",@"icon_resume_education",@"icon_resume_language",@"icon_resume_assessment-0"];
    CGFloat  resumeMeunW  = 200;
    CGFloat  top          = 60;
    resumeMeunView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH , 0, resumeMeunW, SCREEN_HEIGHT-60-30) style:UITableViewStyleGrouped];
    resumeMeunView.backgroundColor = RGBACOLOR(70, 70, 70, 1);
    [self.view addSubview:resumeMeunView];
    
    //修改简历名称
    UITextField *nameTF = [[UITextField alloc] init];
    nameTF.backgroundColor = color_white;
    nameTF.text = self.title;
    nameTF.textColor  = color_title_Gray;
    [resumeMeunView addSubview:nameTF];
    
    UIButton *saveBtn = [UIButton buttonWithTitle:@"保存" titleColor:color_white BackgroundColor:RGBCOLOR(250, 112, 41) action:^(UIButton *btn) {
#pragma mark  修改简历名称
       if(ISNILSTR(nameTF.text))
       {
           [SVProgressHUD showErrorWithStatus:@"请输入简历名称"];
       }else
       {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
       [dic setObject:nameTF.text forKey:@"tb_title"];
       [dic setObject:self.resume_id forKey:@"resumes_id"];
       [LSHttpKit getMethod:@"c=Personal&a=ModifiedResumeTitle" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [SVProgressHUD showSuccessWithStatus:@"简历名称修改成功"];
           self.title = nameTF.text;
          //隐藏菜单
           if (resumeMeunView.frame.origin.x != SCREEN_WIDTH) {
               [UIView animateWithDuration:0.5 animations:^{
                   resumeMeunView.frame = CGRectMake(SCREEN_WIDTH , 0, resumeMeunW, SCREEN_HEIGHT-60-30);
               }];
               
           }
       }];
       }
        
    }];
    [resumeMeunView addSubview:saveBtn];
    saveBtn.frame = CGRectMake(140, 10, 50, 30);
    nameTF.frame = CGRectMake(10, 10, 125, 30);
    [saveBtn setCornerRadius:3];
    [nameTF setCornerRadius:3];
    
    //简历目录
    for (int i = 0; i< titles.count; i ++) {
        
        UIView *bgView = [[UIView alloc] init];
        [resumeMeunView addSubview:bgView];
         bgView.frame = CGRectMake(0, top+50*i, resumeMeunW, 30);
        
        UIImageView *view = [[UIImageView alloc] init];
        view.backgroundColor = RGBCOLOR(250, 112, 41);
        [bgView addSubview:view];
        view.image = [UIImage imageNamed:images[i]];
        view.frame = CGRectMake(20, 0, 30, 30);
        [view setCornerRadius:5];
        
        UILabel *label = [UILabel labelWithText:titles[i] color:color_white font:16 Alignment:LSLabelAlignment_left];
        [bgView addSubview:label];
        label.frame = CGRectMake(30+10+20, 0, resumeMeunW-60, 30);
        label.userInteractionEnabled = YES;
        
        [bgView bk_whenTapped:^{
           
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            if (resumeMeunView.frame.origin.x != SCREEN_WIDTH) {
                [UIView animateWithDuration:0.5 animations:^{
                    resumeMeunView.frame = CGRectMake(SCREEN_WIDTH , 0, resumeMeunW, SCREEN_HEIGHT-60-30);
                }];
                
            }
        }];
    }
    
    
    UIButton *btn = [UIButton buttonWithImage:@"btn_screening_wihte" action:^(UIButton *btn) {
        //简历目录
        if (resumeMeunView.frame.origin.x == SCREEN_WIDTH) {
            [UIView animateWithDuration:0.5 animations:^{
                resumeMeunView.frame = CGRectMake(SCREEN_WIDTH -resumeMeunW, 0, resumeMeunW, SCREEN_HEIGHT-60-30);
                
            }];
        }else
        {
            [UIView animateWithDuration:0.5 animations:^{
                resumeMeunView.frame = CGRectMake(SCREEN_WIDTH , 0, resumeMeunW, SCREEN_HEIGHT-60-30);
            }];
        }
        
    }];
    btn.frame = CGRectMake(0, 0, 30, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
  
    //刷新简历
    if (!self.isEdit) {
        UIButton *refrshBtn = [UIButton buttonWithTitle:@"刷新简历" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
            [LSHttpKit getMethod:@"c=Personal&a=ResumeRefresh" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [SVProgressHUD showSuccessWithStatus:@"简历刷新成功"];
            }];
        }];
        [refrshBtn setfont:14];
        [refrshBtn setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
        [self.view addSubview:refrshBtn];
        refrshBtn.edgeNearbottom(0,0,0,30);
        
        [self.view bk_whenTapped:^{
            if (resumeMeunView.frame.origin.x != SCREEN_WIDTH) {
                [UIView animateWithDuration:0.5 animations:^{
                    resumeMeunView.frame = CGRectMake(SCREEN_WIDTH , 0, resumeMeunW, SCREEN_HEIGHT-60-30);
                }];
        } }];
    }
    
}

-(void)notification:(NSNotification *)noti
{
    if ([noti.name isEqualToString:@"edit"]) {
        
        NSDictionary *dic = noti.userInfo;
        NSString *type = dic[@"tb_type"];
        if ([type isEqualToString:@"experience"]) {
            LSEditWorkVC *vc = [[LSEditWorkVC alloc] init];
            vc.recordDic = dic;
            vc.resumes_id = self.resume_id;
            
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            //编辑教育经历
            LSEditEducationVC *vc = [[LSEditEducationVC alloc] init];
            vc.recordDic = dic;
            vc.resumes_id = self.resume_id;
            [self.navigationController pushViewController:vc animated:YES];
        
        }
  
    }


}
@end

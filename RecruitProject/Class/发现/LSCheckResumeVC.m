//
//  LSCheckResumeVC.m
//  RecruitProject
//
//  Created by sliu on 15/10/16.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSCheckResumeVC.h"
#import "LSResumeToolCell.h"
#import "LSResumeHeadCell.h"
#import "LSRecordCell.h"
#import "LSApplyDetailVC.h"

@interface LSCheckResumeVC ()
{
    LSUserModel *userModel;
    LSRecordModel *recordModel1;   //语言能力
    LSRecordModel *recordModel2;   //自我评价
    LSRecordModel *recordModel3;   //工作经历
    LSRecordModel *recordModel4;   //教育经历
    
}

@end

@implementation LSCheckResumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     WeakSelf;
    self.tableViewKit.configureCellBlock = ^(id cell,id item,NSIndexPath *index)
    {
        if ([cell isKindOfClass:[LSResumeToolCell class]]) {
            LSResumeToolCell *toolCell = (LSResumeToolCell*)cell;
            toolCell.collectionBtn.actionBlock = ^(UIButton *btn)
            {
                //收藏简历
                if(btn.selected)
                {
                    [LSHttpKit getMethod:@"c=Company&a=delFavResume" parameters:weakSelf.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        [SVProgressHUD showSuccessWithStatus:@"取消收藏成功!"];
                    }];
                }else
                {
                    [LSHttpKit getMethod:@"c=Company&a=addFavResume" parameters:weakSelf.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        [SVProgressHUD showSuccessWithStatus:@"简历收藏成功!"];
                    }];
                }
                btn.selected = !btn.selected;
                
            };
            toolCell.phoneBtn.actionBlock = ^(UIButton *btn)
            {
                //查看联系方式
                if (!btn.selected) {
                    //询问查看
                    [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"是否消耗一次查看机会查看该简历" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                        
                        if(buttonIndex == 1)
                        {
                            [LSHttpKit getMethod:@"c=Company&a=ViewDownfiles" parameters:weakSelf.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSDictionary *dic = responseObject[@"data"];
                                if (ISNOTNILDIC(dic)) {
                                    [weakSelf showMessage:dic];
                                    btn.selected = YES;
                                }
                            }];
                        }
                    }];
                   
                }else
                {  //直接查看
                    [weakSelf showMessage:nil];
                }
            };
        }
    };
}

-(void)showMessage:(NSDictionary *)dic
{
    [userModel setKeyValues:dic];
    NSString *qq = userModel.qq;
    NSString *email = userModel.email;
    NSString *mobile = userModel.mobile;
    
    if (ISNILSTR(userModel.qq)) {
        qq = @"未填写";
    }
    if(ISNILSTR(userModel.email)) {
        email = @"未填写";
    }
    if (ISNILSTR(userModel.mobile)){
        mobile = @"未填写";
    }
    
    NSString *message = [NSString stringWithFormat:@"手机号:%@\nQQ:%@\nemail:%@\n",mobile,qq,email];
    [UIAlertView bk_showAlertViewWithTitle:@"联系方式" message:message cancelButtonTitle:@"确定" otherButtonTitles:nil handler:nil];
}


-(void)creatContentView
{
    
    userModel  = [[LSUserModel alloc] init];
    [self.dataListArr addObject:@[userModel]];
    [self.dataListArr addObject:@[userModel]];
    
    recordModel3 = [[LSRecordModel alloc] init];
    recordModel3.tb_type = @"3";
    recordModel4 = [[LSRecordModel alloc] init];
    recordModel4.tb_type = @"4";
    
    [self.dataListArr addObject:@[@"工作经历",recordModel3]];
    [self.dataListArr addObject:@[@"教育经历",recordModel4]];
    
    recordModel1 = [[LSRecordModel alloc] init];
    recordModel1.tb_type = @"1";
    recordModel2 = [[LSRecordModel alloc] init];
    recordModel2.tb_type = @"2";
    
    
    [self.dataListArr addObject:@[@"语言能力",recordModel1]];
    [self.dataListArr addObject:@[@"自我评价",recordModel2]];
    

    
    NSMutableArray *cellArr = [NSMutableArray array];
    [cellArr addObject:@[@"LSResumeHeadCell"]];
    [cellArr addObject:@[@"LSResumeToolCell"]];
    [cellArr addObject:@[@"LSHeadCell",@"LSRecordCell"]];
    [cellArr addObject:@[@"LSHeadCell",@"LSRecordCell"]];
    [cellArr addObject:@[@"LSHeadCell",@"LSRecordCell"]];
    [cellArr addObject:@[@"LSHeadCell",@"LSRecordCell"]];
 

    [self creatTableView:cellArr];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,30,0);
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        
        if (indexPath.section == 0) {
            return 230;
        }else if (indexPath.section == 1)
        {
            return 30;
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
    
    
    UIButton *btn = [UIButton buttonWithTitle:@"邀请面试" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
        LSApplyDetailVC *vc = [[LSApplyDetailVC alloc] init];
        vc.isApply = YES;
        vc.apply_id = self.apply_id;
        vc.resumes_id = self.resumeID;
        [self.navigationController pushViewController:vc animated:YES];
   
    }];
    [self.view addSubview:btn];
    [btn setImage:[UIImage imageNamed:@"icon_send_white"] forState:UIControlStateNormal];
    btn.edgeNearbottom(0,0,0,30);
    
}

-(void)httpRequest
{
[self.parDic setObject:self.resumeID forKey:@"resumes_id"];
if (self.apply_id) {
[self.parDic setObject:self.resumeID forKey:@"apply_id"];
}
[LSHttpKit getMethod:@"c=Company&a=ViewResumeDetails" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
   [userModel setKeyValues:responseObject[@"data"][@"0"]];
    //语言能力
    if(ISNOTNILSTR(userModel.tb_foreignlanguage)  && ![userModel.tb_foreignlanguage isEqualToString:@""])
    {
        recordModel1.text = [NSString stringWithFormat:@"语言能力      %@",userModel.tb_foreignlanguage];
    }else
    {
        recordModel1.text = @"无";
    }
    
    //自我评价
    if (userModel.tb_selfassessment) {
        recordModel2.text = userModel.tb_selfassessment;
    }else
    {
        recordModel2.text = @"无";
    }
    NSArray *records = responseObject[@"data"][@"record"];
    if(ISNOTNILARR(records))
    {
        for (NSDictionary *dic in records) {
            NSString *type = dic[@"tb_type"];
            if ( [type isEqualToString:@"experience"]) {
                if (!recordModel3.listArr) {
                    recordModel3.listArr = [NSMutableArray array];
                }
                
                [recordModel3.listArr addObject:dic];
                if (recordModel3.listArr.count >=1) {
                    userModel.companyName = recordModel3.listArr[0][@"tb_unitname"];
                }else
                {
                    userModel.companyName = @"无";
                }
                
            }
            
            if ( [type isEqualToString:@"education"]) {
                if (!recordModel4.listArr) {
                    recordModel4.listArr = [NSMutableArray array];
                }
                [recordModel4.listArr addObject:dic];
            }
            
        }
    }
 
    
    [self.tableView reloadData];
}];

}





@end

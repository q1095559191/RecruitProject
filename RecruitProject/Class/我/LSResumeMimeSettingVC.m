//
//  LSResumeMimeSettingVC.m
//  RecruitProject
//
//  Created by sliu on 15/11/1.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSResumeMimeSettingVC.h"
#import "LSChoiceAddressView.h"

@interface LSResumeMimeSettingVC ()
{
    NSMutableArray *detailStrArr;
    NSArray *degreeArr;
    NSArray *worknatureArr;
    NSArray *positionArr;
    NSArray *salaryArr;
    NSMutableArray *sexArr;
    LSChoiceView *choiceView;
    LSTimePickerView *timeView;
    LSChoiceAddressView *addressView;
  
}
@end

@implementation LSResumeMimeSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"基本信息";
    degreeArr     = [NSObject getInfoWithBaseModel:6];
    worknatureArr = [NSObject getInfoWithBaseModel:1];
    positionArr   = [NSObject getInfoWithBaseModel2:16 defineStr:nil];
    salaryArr     = [NSObject getInfoWithBaseModel:4 ];
    
    NSArray *title_sex = @[@"男",@"女"];
    sexArr  = [NSObject getBasemodel:title_sex define:self.userModel.sex];
    
    NSArray *titles = @[@"姓名",@"性别",@"邮箱",@"手机",@"QQ",@"出生年月",@"地点",@"最高学历",@"工作性质",@"期望职位",@"期望月薪"];
    detailStrArr = [NSMutableArray array];
    [self handleDetailStr:self.userModel.truename info:NO];
    [self handleDetailStr:self.userModel.sex info:NO];
    [self handleDetailStr:self.userModel.email info:NO];
    [self handleDetailStr:self.userModel.mobile info:NO];
    [self handleDetailStr:self.userModel.qq info:NO];
    [self handleDetailStr:self.userModel.birthday info:NO];
    [self handleDetailStr:self.userModel.tb_city info:NO];
    [self handleDetailStr:self.userModel.tb_degree info:YES];
    [self handleDetailStr:self.userModel.tb_worknature info:YES];
    [self handleDetailStr:self.userModel.tb_position info:NO];
    [self handleDetailStr:self.userModel.tb_salary info:YES];
    
  
    for (int i = 0; i < titles.count; i++) {
        NSString *str = titles[i];
        LSBaseModel *model = [[LSBaseModel alloc] init];
        model.title = str;
        model.type = @"1";
        if (i == 7) {
            model.index = self.userModel.tb_degree;
        }
        if (i == 8) {
            model.index = self.userModel.tb_worknature;
        }
        if (i == 9) {
            model.index = self.userModel.tb_position;
        }
        if (i == 10) {
            model.index = self.userModel.tb_salary;
        }
        
        if (i == 0 || i == 2 || i == 3|| i == 4) {
         model.type = @"0";
        }
        model.detailTile = detailStrArr[i];
        [self.dataListArr addObject:model];
    }
   
    [self creatTableView:@"LSMineSettingCell"];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,0,0);
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return 40;
    } Header:nil Footer:nil];
    
    
    UIButton *btn = [UIButton buttonWithTitle:@"保存" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
        NSArray *keys = @[@"truename",@"sex",@"email",@"mobile",@"qq",@"birthday",@"tb_city",@"tb_degree",@"tb_worknature",@"tb_position",@"tb_salary"];
        for (int i = 0; i< self.dataListArr.count; i ++) {
            LSBaseModel *model = self.dataListArr[i];
            if (i == 7 || i == 8|| i == 10) {
                  if (model.index) {
                  [self.parDic setValue:model.index forKey:keys[i]];
                  }else
                  {
                      [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请填写%@",model.title]];
                      return ;
                  }
            }else
            {
                if (model.detailTile) {
                   [self.parDic setValue:model.detailTile forKey:keys[i]];
                }else
                {
                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请填写%@",model.title]];
                    return ;
                }
            }
            
        }
    [self.parDic setObject:self.resumes_id forKey:@"resume_id"];
   [LSHttpKit getMethod:@"c=Personal&a=ModifyResume" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
       [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
       [self.navigationController popViewControllerAnimated:YES];
   }];
        
    }];
    [self.view addSubview:btn];
    btn.edgeNearbottom(0,0,0,30);
    
}



#pragma mark - 处理DetailStr
-(void)handleDetailStr:(NSString *)str info:(BOOL)isInfo
{
    
    if (!ISNILSTR(str)) {
        if (isInfo) {
            NSString *infoStr = [NSObject getInfoDetail:str];
            [detailStrArr addObject:infoStr];
        }else
        {
          [detailStrArr addObject:str];
        }
        
    }else
    {
        [detailStrArr addObject:@"未填写"];
    }

}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LSBaseModel *model = self.dataListArr[indexPath.row];
    WeakSelf;
    if (indexPath.row == 1) {
       choiceView = [LSChoiceView ChoiceViewInView:self.view titles:sexArr cancle:^(UIButton *btn) {
        LSBaseModel *model_selet  =  sexArr[choiceView.selectedIndex];
        model.detailTile = model_selet.title;
        [self.tableView reloadData];
       }];
    }
    if (indexPath.row == 5) {
        //时间选择
        timeView = [LSTimePickerView TimePickerView];
        timeView.okBlock = ^(LSTimePickerView *time)
        {
            model.detailTile = time.currentTime;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        [timeView show];
    }
    
    if (indexPath.row == 6) {
        //选择地址
        addressView = [LSChoiceAddressView addressViewInView:self.view cancle:^(UIButton *btn) {
            model.detailTile = addressView.selectedstr;
            [self.tableView reloadData];
        }];
    }
    
    if (indexPath.row == 7||indexPath.row == 8||indexPath.row == 9||indexPath.row == 10) {
        NSArray *temparr;
        
        if (indexPath.row == 9) {
            //期望职位
            temparr = positionArr;
       
        choiceView  =  [LSChoiceView choiceMoreViewInView:self.view titles:temparr cancle:^(UIButton *btn) {
            NSString *postStr;
            NSString *postindex;
            WeakObj(choiceView);
            for (LSBaseModel *modlesel in choiceViewWeak.moreArr) {
                if (postStr) {
                    postStr = [NSString stringWithFormat:@"%@,%@",postStr,modlesel.title];
                    postindex = [NSString stringWithFormat:@"%@,%@",postindex,modlesel.index];
                }else
                {
                    postStr = [NSString stringWithFormat:@"%@",modlesel.title];
                    postindex = [NSString stringWithFormat:@"%@",modlesel.index];
                }
            }
            
            if (postStr) {
                model.detailTile = postStr;
                model.index = postindex;
                [self.tableView reloadData];
            }
        }];
        
        //初始选中状态
        choiceView.moreArr = [[NSMutableArray alloc] init];
        for (LSBaseModel *model1 in positionArr) {
                for (LSBaseModel *model2 in  model1.subArr) {
                    if (model2.isSelected) {
                        [choiceView.moreArr addObject:model2];
                }
            }
        }
        }else
        {
            //单选
            if (indexPath.row == 7) {
                temparr = degreeArr;
            }
            if (indexPath.row == 8) {
                temparr = worknatureArr;
            }
            
            if (indexPath.row == 10) {
                temparr = salaryArr;
            }
            
            choiceView = [LSChoiceView ChoiceViewInView:self.view titles:temparr cancle:^(UIButton *btn) {
                LSBaseModel *model_selet  =  temparr[choiceView.selectedIndex];
                model.detailTile = model_selet.title;
                model.index = model_selet.index;
                [self.tableView reloadData];
            }];
        
        }
    
    }
    
}


@end

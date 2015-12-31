//
//  LSMineSettingVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSMineSettingVC.h"


@interface LSMineSettingVC ()<UITableViewDelegate>
{
    LSTimePickerView *timeView;
    LSChoiceView *choiceView;
    NSArray *salaryArr;
    NSArray *postArr;
    NSMutableArray *sexArr;

}
@end

@implementation LSMineSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    salaryArr = [NSObject getInfoWithBaseModel:4];
    postArr = [NSObject getInfoWithBaseModel2:16 defineStr:nil];
    NSArray *title_sex = @[@"男",@"女"];
    sexArr  = [NSObject getBasemodel:title_sex define:self.userModel.sex];
    
    NSArray *titles = @[@"真实姓名",@"英文名",@"性别",@"邮箱",@"手机",@"QQ",@"出生年月",@"公司职位",@"所处行业"];
    NSArray *keys = @[@"truename",@"entruename",@"sex",@"email",@"mobile",@"qq",@"birthday",@"position",@"tb_jobtype_two"];

    NSDictionary *userDic   = [APPDELEGETE.user keyValues];
    LSBaseModel  *headModle = [[LSBaseModel alloc] init];
    headModle.imageUrl      = APPDELEGETE.user.img;
    headModle.title         = @"头像";
    NSMutableArray    *dataArr =  [NSObject getBasemodel:titles define:nil];
    for (int i = 0; i < keys.count; i++) {
        LSBaseModel *model = dataArr[i];
        if (i == 8) {
           model.detailTile  =  [NSObject getInfoDetail:[userDic valueForKey:keys[i]]];
           model.index = [userDic valueForKey:keys[i]];
           model.imageUrl = [userDic valueForKey:@"tb_jobtype"];
        }else
        {
         model.detailTile  =  [userDic valueForKey:keys[i]];
        }
        if (i == 2 ||i == 6||i == 8) {
            model.type = @"1";
        }
    }
    
    [self.dataListArr addObject:@[headModle]];
    [self.dataListArr addObject:dataArr];
    [self creatTableView:@[@[@"LSMineHeadCell"],@"LSMineSettingCell"]];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,0,0);
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        if (indexPath.section == 0) {
            return 90;
        }
        return 50;
    } Header:nil Footer:nil];
    
    //修改个人信息
    UIButton *btn = [UIButton buttonWithTitle:@"保存" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
    NSArray *keys =  @[@"truename",@"entruename",@"sex",@"email",@"mobile",@"qq",@"birthday",@"position",@"tb_jobtype_two"];
    NSMutableDictionary *parDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < keys.count; i++) {
        LSBaseModel *model = self.dataListArr[1][i];
        if (i == 8) {
            if (!ISNILSTR(model.imageUrl)) {
                [parDic setObject:model.imageUrl forKey:@"tb_jobtype"];
                [parDic setObject:model.index forKey:@"tb_jobtype_two"];
            }
        }else
        {
            if (!ISNILSTR(model.detailTile)) {
             [parDic setObject:model.detailTile forKey:keys[i]];
            }
        }
    }
        
    [LSHttpKit getMethod:@"c=Personal&a=editMyInfo" parameters:parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
        [self.navigationController popViewControllerAnimated:YES];
     }];
        
    }];
    [self.view addSubview:btn];
    btn.edgeNearbottom(0,0,0,30);
    
}

-(void)httpRequest
{

    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LSBaseModel *model = self.dataListArr[indexPath.section][indexPath.row];
    WeakSelf;
    if (indexPath.section == 0) {
       //上传图片 头像
        [self postImage:@"img"];
    
    }else
    {
        if (indexPath.row == 2) {
            //性别
            choiceView = [LSChoiceView ChoiceViewInView:self.view titles:sexArr cancle:^(UIButton *btn) {
                LSBaseModel *model_selet  =  sexArr[choiceView.selectedIndex];
                model.detailTile = model_selet.title;
                [self.tableView reloadData];
            }];
        }
        
        if (indexPath.row == 6) {
            //时间选择
            timeView = [LSTimePickerView TimePickerView];
            timeView.okBlock = ^(LSTimePickerView *time)
            {
                model.detailTile = time.currentTime;
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
            [timeView show];
        }
    
        if (indexPath.row == 8) {
            // 所处行业
            choiceView = [LSChoiceView ChoiceViewInView:self.view titles:postArr cancle:^(UIButton *btn) {
                LSBaseModel *model_selet  =  postArr[choiceView.selectedIndex];
                LSBaseModel *model_selet2  =  model_selet.subArr[choiceView.selectedIndex2];
                model.detailTile = model_selet2.title;
                model.index = model_selet2.index;
                model.imageUrl = model_selet.index;
                [self.tableView reloadData];
            }];
        }

    
    }
    

}


-(void)postImageSuccess:(NSString *)type imageUrl:(NSString *)url
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

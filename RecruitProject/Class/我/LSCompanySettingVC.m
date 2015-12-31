//
//  LSCompanySettingVC.m
//  RecruitProject
//
//  Created by sliu on 15/11/10.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSCompanySettingVC.h"

@interface LSCompanySettingVC ()
{
    NSArray *industryArr;    //公司行业
    NSArray *unittypeArr;    //公司规模
    NSArray *unitsizeArr;    //公司性质
    
    LSChoiceView *choiceView;;
   

}
@end

@implementation LSCompanySettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1:工作性质2:工作地点3:工作状态4:期望月薪5:工作经验6:学历7:薪资水平8:行业类别9:企业性质10:语种11:职位类别12:公司规模13:热搜职位14:热门搜索15:时间间隔16:行业职位 17:发布时间
    industryArr = [NSObject getInfoWithBaseModel:16];
    unittypeArr = [NSObject getInfoWithBaseModel:12];
    unitsizeArr = [NSObject getInfoWithBaseModel:9];
    
    NSArray *data1 = @[@"头像"];
    NSArray *data2 = @[@"公司名称",@"公司行业",@"公司性质",@"公司规模",@"营业执照",@"组织机构代码证",@"税务登记证",@"公司介绍"];
    NSArray *data3 = @[@"联系地址",@"手机号码",@"座机号码",@"邮箱"];
    NSArray *model1 = [LSBaseModel getBaseModels:data1];
    NSArray *model2 = [LSBaseModel getBaseModels:data2];
    NSArray *model3 = [LSBaseModel getBaseModels:data3];
    
    LSBaseModel *userModel = model1[0];
    userModel.imageUrl = APPDELEGETE.user.img;
  
    [self.dataListArr addObject:model1];
    [self.dataListArr addObject:model2];
    [self.dataListArr addObject:model3];
    
    NSMutableArray *cellarr2 = [[NSMutableArray alloc] init];
    
    NSDictionary *userDic = [APPDELEGETE.user keyValues];
    NSArray *keys1 =  @[@"truename",@"industry",@"unittype",@"unitsize",@"certificatecode",@"organizationcode",@"codeinfo",@"remark"];
    NSArray *keys2 =  @[@"addresss",@"mobile",@"phone",@"email"];
    
    for (int i = 0; i < model2.count; i ++) {
        LSBaseModel *model = model2[i];
        if (4<=i && i<= 6) {
            [cellarr2 addObject:@"LSMineHeadCell"];
        }else
        {
            [cellarr2 addObject:@"LSMineSettingCell"];
        }
        if (i == 1 || i == 2 || i == 3) {
           model.type = @"1";
           model.index = [userDic objectForKey:keys1[i]];
           model.detailTile = [NSObject getInfoDetail:model.index];
        }else
        {   model.type = @"0";
            model.detailTile = [userDic objectForKey:keys1[i]];
            if (i == 4 || i == 5 || i == 6) {
             model.imageUrl = [userDic objectForKey:keys1[i]];
            }
        }
   
    }
  
    
    for (int i = 0; i < model3.count; i ++) {
        LSBaseModel *model = model3[i];
        model.detailTile = [userDic objectForKey:keys2[i]];
     
    }
    
    [self creatTableView:@[@[@"LSMineHeadCell"],cellarr2,@"LSMineSettingCell"]];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,40,0);
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        if (indexPath.section == 0) {
            return 90;
        }else if (indexPath.section == 1)
        {
             if ( 4<=indexPath.row && indexPath.row<= 6) {
                 return 90;
             }
        }
        return 50;
    } Header:nil Footer:nil];
    
    //修改个人信息
    UIButton *btn = [UIButton buttonWithTitle:@"保存" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {

        NSArray *keys1 =  @[@"truename",@"industry",@"unittype",@"unitsize",@"remark"];
        NSArray *keys2 =  @[@"addresss",@"mobile",@"phone",@"email"];
        NSMutableDictionary *parDic = [NSMutableDictionary dictionary];
        NSArray *data1 =  self.dataListArr[1];
        NSArray *data2 =  self.dataListArr[2];
        
        for (int i = 0; i < keys1.count; i++) {
          LSBaseModel *model = data1[i];
          if (i == keys1.count - 1) {
            //公司介绍
            model = data1.lastObject;
           }
            NSString *parStr;
            if (i == 1 || i == 2 || i == 3) {
                parStr = model.index;
            }else
            {
                parStr = model.detailTile;
            }
            
            if (!ISNILSTR(parStr)) {
                [parDic setValue:parStr forKey:keys1[i]];
            }else
            {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请输入%@",model.title]];
                return ;
            }
            
        }
        
        for (int i = 0; i < keys2.count; i++) {
            LSBaseModel *model = data2[i];
            if (!ISNILSTR(model.detailTile)) {
                [parDic setValue:model.detailTile forKey:keys2[i]];
            }else
            {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请输入%@",model.title]];
                return ;
            }
        }
        
        [LSHttpKit getMethod:@"c=Company&a=EditorCompany" parameters:parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }];
    [self.view addSubview:btn];
    btn.edgeNearbottom(0,0,0,30);
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSBaseModel *model = self.dataListArr[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        //上传头像
        [self postImage:@"img"];
    }
    
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
            NSArray *tempArr;
            if (indexPath.row == 1) {
                tempArr = industryArr;
            }
            if (indexPath.row == 2) {
                
                tempArr = unitsizeArr;
            }
            if (indexPath.row == 3) {
                tempArr = unittypeArr;
            }
            choiceView = [LSChoiceView ChoiceViewInView:self.view titles:tempArr cancle:^(UIButton *btn) {
                LSBaseModel *model_selet  =  tempArr[choiceView.selectedIndex];
                model.detailTile          =  model_selet.title;
                model.index               = model_selet.index;
                [self.tableView reloadData];
            }];
        }
    }
   // organizationcode:组织代码 certificatecode:税务登记证 codeinfo:营业执照
    if (indexPath.row == 4) {
        [self postImage:@"organizationcode"];
    }
    if (indexPath.row == 5) {
        [self postImage:@"certificatecode"];
    }
    if (indexPath.row == 6) {
        [self postImage:@"codeinfo"];
    }


}

-(void)postImageSuccess:(NSString *)type imageUrl:(NSString *)url
{
    if ([type isEqualToString:@"organizationcode"]) {
        LSBaseModel *model = self.dataListArr[1][4];
        model.imageUrl = url;
        [self.tableView reloadData];
        
    }
    if ([type isEqualToString:@"certificatecode"]) {
        LSBaseModel *model = self.dataListArr[1][5];
        model.imageUrl = url;
        [self.tableView reloadData];

        
    }
    
    if ([type isEqualToString:@"codeinfo"]) {
        LSBaseModel *model = self.dataListArr[1][6];
        model.imageUrl = url;
        [self.tableView reloadData];  
    }
    
    if ([type isEqualToString:@"img"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }


}

@end

//
//  LSNewPositionVC.m
//  RecruitProject
//
//  Created by sliu on 15/11/9.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSNewPositionVC.h"
#import "LSChoiceAddressView.h"

@interface LSNewPositionVC ()<UIAlertViewDelegate>
{
    BOOL   isEdit;
    
    NSArray *worknatureArr;      //工作性质
    NSArray *workyearArr;        //工作经验
    NSArray *positionArr;        //职位
    NSArray *worknumArr;         //招聘人数
    NSArray *degreeArr;          //最低学历
    NSArray *salaryArr;          //月薪
    
    LSChoiceView *choiceView;
    LSChoiceAddressView *addressView;
    NSArray *titles;

}

@end

@implementation LSNewPositionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1:工作性质2:工作地点3:工作状态4:期望月薪5:工作经验6:学历7:薪资水平8:行业类别9:企业性质10:语种11:职位类别12:公司规模13:热搜职位14:热门搜索15:时间间隔16:行业职位 17:发布时间
    
    worknatureArr = [NSObject getInfoWithBaseModel:1];
    workyearArr   = [NSObject getInfoWithBaseModel:5];
    degreeArr     = [NSObject getInfoWithBaseModel:6];
    salaryArr     = [NSObject getInfoWithBaseModel:4];
    positionArr = [NSObject getInfoWithBaseModel2:16 defineStr:nil];
    
    titles = @[@"岗位名称",@"职位类别",@"工作性质",@"工作经验",@"工作地点",@"招聘人数",@"最低学历",@"月薪",@"职位诱惑",@"职位描述"];
   
    
    
    NSArray *models = [LSBaseModel getBaseModels:titles];
    for (int i = 0;i < models.count; i++) {
        LSBaseModel *model = models[i];
        if (i == 0 || i == 5 || i == 9) {
           model.type = @"0";
        }else
        {
           model.type = @"1";
        }
    }
  
   
    
    NSString *bootomTitleStr ;
    if (self.model) {
        self.title = @"编辑职位";
        isEdit = YES;
        bootomTitleStr = @"保存";
        NSDictionary *dic  =  [self.model keyValues];
        NSArray *keys = @[@"tb_name",@"tb_jobtype",@"tb_worknature",@"tb_workyear",@"tb_city",@"tb_worknum",@"tb_degree",@"tb_salary",@"tb_welfare",@"tb_description"];
        for (int i = 0; i < keys.count; i++) {
            LSBaseModel *model = models[i];
            if (i == 1) {
                model.index = dic[keys[i]];
                model.detailTile = [NSObject getInfoDetail:model.index];
                model.imageUrl = dic[@"tb_jobtype_two"];
            }else if (i == 2 || i == 3  || i == 6 || i == 7)
            {
             model.index = dic[keys[i]];
             model.detailTile = [NSObject getInfoDetail:model.index];
            }else
            {
                model.detailTile = dic[keys[i]];
            }
        }
        
    }else
    {
        self.title = @"新增职位";
        isEdit = NO;
        bootomTitleStr = @"发布";
    }

    [self.dataListArr addObjectsFromArray:models];
    [self creatTableView:@"LSMineSettingCell"];
     self.tableView.edge(0,0,40,0);
     self.tableView.delegate = self;
    //刷新简历
    UIButton *btn = [UIButton buttonWithTitle:bootomTitleStr titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
    
    NSArray *keys = @[@"tb_name",@"tb_jobtype",@"tb_worknature",@"tb_workyear",@"tb_city",@"tb_worknum",@"tb_degree",@"tb_salary",@"tb_welfare",@"tb_description"];
        NSMutableDictionary *pardic = [NSMutableDictionary dictionary];
        for (int i = 0; i < keys.count; i++) {
            LSBaseModel *modle = self.dataListArr[i];
            NSString *valuesStr;
            if (i == 7 || i  == 2 || i  == 3 || i  == 6|| i  == 1){
                valuesStr = modle.index;
            }else
            {
               valuesStr = modle.detailTile ;
            }
            
            if (ISNILSTR(valuesStr)) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请填写%@",titles[i]]];
            }else
            {
               [pardic setObject:valuesStr forKey:keys[i]];
                if (i== 1) {
                     [pardic setObject:modle.imageUrl forKey:@"tb_jobtype_two"];
                }
            }
        }
    if(self.model)
    {   //编辑职位
        [pardic setObject:self.model.openings_id forKey:@"openings_id"];
        [LSHttpKit getMethod:@"c=Company&a=EditorPosition" parameters:pardic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else
    {   //新增职位
        [LSHttpKit getMethod:@"c=Company&a=JobAdded" parameters:pardic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"发布成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
      
        
    }];
    [btn setfont:14];
    [btn setImage:[UIImage imageNamed:@"btn_add_job_white"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.edgeNearbottom(0,0,0,30);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSBaseModel *model = self.dataListArr[indexPath.row];
    
    
    
    
    if (indexPath.row  == 7 || indexPath.row  == 2 || indexPath.row  == 3 || indexPath.row  == 6){
        NSArray *tempArr;
        switch (indexPath.row) {
            case 2:
            {
                tempArr =  worknatureArr;
            }
            break;
            case 3:
            {
                tempArr =  workyearArr;
            }
                break;
         
                break;
            case 6:
            {
                tempArr =  degreeArr;
            }
                break;
            case 7:
            {
                tempArr =  salaryArr;
            }
                break;
           
            default:
                break;
        }
        //薪资
        choiceView = [LSChoiceView ChoiceViewInView:self.view titles:tempArr cancle:^(UIButton *btn) {
            LSBaseModel *model_sel = tempArr[choiceView.selectedIndex];
            model.detailTile = model_sel.title;
            model.index    = model_sel.index;
            [self.tableView reloadData];
        }];
        
    }else if ( indexPath.row == 1)
    {
        //所在职位
        choiceView = [LSChoiceView ChoiceViewInView:self.view titles:positionArr cancle:^(UIButton *btn) {
            LSBaseModel *model_selet  =  positionArr[choiceView.selectedIndex];
            LSBaseModel *model_selet2  =  model_selet.subArr[choiceView.selectedIndex2];
            model.detailTile = model_selet2.title;
            model.index = model_selet2.index;
            model.imageUrl = model_selet.index;
            [self.tableView reloadData];
        }];
        
    }else if ( indexPath.row == 4)
    {
        //地址
        addressView = [LSChoiceAddressView addressViewInView:self.view cancle:^(UIButton *btn) {
            model.detailTile = addressView.selectedstr;
            [self.tableView reloadData];
        }];
       
    }else if ( indexPath.row == 8)
    {
       //职位诱惑
       
   UIAlertView *alertView  =  [[UIAlertView alloc] initWithTitle:@"添加qweq职位诱惑" message: model.detailTile delegate:self cancelButtonTitle:@"清空" otherButtonTitles:@"添加", nil];
    
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alertView show];
        
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    LSBaseModel *modle = self.dataListArr[8];
   
    if (buttonIndex== 0) {
      
         modle.detailTile =  nil;
    }else
    {
        UITextField *textView = [alertView textFieldAtIndex:0];
        if (!ISNILSTR(textView.text)) {
         if(ISNILSTR(modle.detailTile))
         {
             modle.detailTile = textView.text;
         }else
         {
             modle.detailTile = [NSString stringWithFormat:@"%@,%@", modle.detailTile,textView.text];
         }
            
        }
        
    }

    [self.tableView reloadData];
}

@end

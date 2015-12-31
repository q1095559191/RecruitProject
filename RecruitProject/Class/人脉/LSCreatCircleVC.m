//
//  LSCreatCircleVC.m
//  RecruitProject
//
//  Created by sliu on 15/10/12.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSCreatCircleVC.h"


@interface LSCreatCircleVC ()
{
    UIButton *creatBtn;
    NSArray  *industryArr;     //行业类别
    NSArray  *joinTypeArr;     //加入方式
    NSArray  *circleTypeArr;   //圈子类型
    LSChoiceView *choiceView;
    
}
@end
@implementation LSCreatCircleVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"创建圈子";
    NSArray *titles = @[@"圈子名称",@"圈子类型",@"行业类型",@"圈子简介",@"加入方式"];
    NSArray *models  = [LSBaseModel getBaseModels:titles];
    for (int i = 0; i< models.count; i++) {
        LSBaseModel *modle = models[i];
        if (i == 0 || i== 3) {
         modle.type = @"0";
        }else
        {
          modle.type = @"1";
        }
    }
   LSBaseModel *headModel = [[LSBaseModel alloc]init];
   headModel.title = @"圈子头像";
    
   [self.dataListArr addObjectsFromArray:@[@[headModel],models]];
   industryArr = [NSObject getInfoWithBaseModel:16];
   joinTypeArr = [LSBaseModel getBaseModels:@[@"自由加入(不需要批准自由加入圈子)",@"申请加入(得到批准后方可加入圈子)"]];
   circleTypeArr = [LSBaseModel getBaseModels:@[@"职场讨论",@"同事交流",@"校友交流",@"其他交流"]];
   
   [self creatTableView:@[@"LSMineHeadCell",@"LSMineSettingCell"]];
   self.tableView.delegate = self;
   self.tableView.edge(0,0,0,0);
   [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        if (indexPath.section == 0) {
             return 90;
        }else
        {
             return 50;
        }
    } Header:nil Footer:nil];
    
    creatBtn = [UIButton buttonWithTitle:@"创建圈子" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
        //行业类别
        NSArray *keys = @[@"tb_name",@"tb_type",@"tb_industry",@"tb_info",@"tb_joinway"];
         for (int i = 0; i < keys.count; i++) {
            LSBaseModel *model = self.dataListArr[1][i];
            NSString *tempStr;
            if (i == 1 || i==0 || i == 3) {
                tempStr = model.detailTile;
            }else if(i == 2)
            {
               tempStr = model.index;
            }else
            {//加入方式
              if([model.detailTile hasPrefix:@"自由加入"])
              {
                  tempStr = @"1";
              }else
              {   tempStr = @"0";
              }
            }
            if (ISNILSTR(tempStr)) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请输入%@",model.title]];
            }else
            {
            [self.parDic setObject:tempStr forKey:keys[i]];
            }
        }
        LSBaseModel *headModel = self.dataListArr[0][0];
        if (headModel.imageUrl) {
          [self.parDic setObject:headModel.imageUrl forKey:@"tb_img"];
        }else
        {
            NSLog(@"没有头像");
        }
        [LSHttpKit getMethod:@"c=Circle&a=createCircle" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"圈子创建成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }];
    [self.view addSubview:creatBtn];
    creatBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 60 - 40, SCREEN_WIDTH, 40);
    [creatBtn setCornerRadius:3];
  
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *tempArr;
    LSBaseModel *model = self.dataListArr[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        [self postImage:@"circle_create_logo"];
    }else
    {
        if (indexPath.row == 1) {
            tempArr = circleTypeArr;
        }
        if (indexPath.row == 2) {
            tempArr = industryArr;
        }
        if (indexPath.row == 4) {
            tempArr = joinTypeArr;
        }
        
        if (tempArr) {
            choiceView = [LSChoiceView ChoiceViewInView:self.view titles:tempArr cancle:^(UIButton *btn) {
                LSBaseModel *model_selet  =  tempArr[choiceView.selectedIndex];
                model.detailTile = model_selet.title;
                model.index = model_selet.index;
                [self.tableView reloadData];
            }];
        }

    
    }
    
    
}
-(void)postImageSuccess:(NSString *)type imageUrl:(NSString *)url
{
    LSBaseModel *modle =  self.dataListArr[0][0];
    modle.imageUrl = url;
    [self.tableView reloadData];

}

@end

//
//  LSApplyDetailVC.m
//  RecruitProject
//
//  Created by sliu on 15/11/6.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSApplyDetailVC.h"
#import "LSInterviewCell.h"
#import "LSMineSettingCell.h"
#import "LSTimePickerView.h"

@interface LSApplyDetailVC ()
{
 LSTimePickerView *timeView;
}
@end

@implementation LSApplyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.isApply) {
        self.title = @"邀请面试";
    }
    
    NSArray *titles = @[@"面试人",@"公司名称",@"联系人",@"联系电话",@"联系地址",@"备注"];
    if(self.isApply)
    {
     titles = @[@"联系人",@"联系电话",@"联系地址",@"面试时间",@"备注"];
    }
    NSArray *keys = @[@"tb_lxname人",@"tb_companyname",@"tb_lxname",@"tb_lxphone",@"tb_interviewaddress",@"tb_txt"];
    NSArray *modles = [LSBaseModel getBaseModels:titles];
    for (int i = 0; i < modles.count; i++) {
        LSBaseModel *model = modles[i];
        NSString *detailStr ;
        if (ISNOTNILDIC(self.model.otherDic)) {
         detailStr =   [self.model.otherDic objectForKey:keys[i]];
        }
        if (!detailStr) {
            if (!self.isApply) {
               detailStr  = @"未填写";
                
            }else
            {
                if (i == 3) {
                    //面试时间
                    model.type = @"1";
                }
                
                if (i == 1) {
                    //面试时间
                    model.type = @"3";
                }
            }
        }
        model.detailTile =detailStr;
    }
    
    [self.dataListArr addObjectsFromArray:modles];
    
    if (self.isApply) {
       
        UIButton *btn = [UIButton buttonWithTitle:@"邀请面试" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
            
            NSArray *keys =  @[@"tb_lxname",@"tb_lxphone",@"tb_interviewaddress",@"tb_uptime",@"tb_txt"];
            NSMutableDictionary *parDic = [NSMutableDictionary dictionary];
            for (int i = 0; i < keys.count; i++) {
                LSBaseModel *model = self.dataListArr[i];
                if (ISNILSTR(model.detailTile)) {
                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请输入%@",model.title]];
                    return ;
                }else
                {
                    [parDic setValue:model.detailTile forKey:keys[i]];
                }
            }
            if (self.resumes_id) {
                [parDic setValue:self.resumes_id forKey:@"resumes_id"];
            }
            if(self.apply_id)
            {
                [parDic setValue:self.apply_id forKey:@"apply_id"];
            }
            
            [LSHttpKit getMethod:@"c=Company&a=InviteInterview" parameters:parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [SVProgressHUD showSuccessWithStatus:@"邀请成功!"];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
        }];
        [self.view addSubview:btn];
        btn.edgeNearbottom(0,0,0,30);
    [self creatTableView:@"LSMineSettingCell"];
    }else
    {
     [self creatTableView:@"LSInterviewCell"];
    }
    
   
    self.tableView.edge(0,0,40,0);
    self.tableView.delegate = self;
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return [LSInterviewCell  GetCellH:self.dataListArr[indexPath.row]];
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    }];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 3) {
        WeakSelf;
        LSBaseModel *model = self.dataListArr[indexPath.row];
        timeView = [LSTimePickerView TimePickerView];
        timeView.okBlock = ^(LSTimePickerView *time)
        {
            model.detailTile = time.currentTime;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        [timeView show];
    }

}

@end

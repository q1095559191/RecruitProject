//
//  LSAddResumeVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/24.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSAddResumeVC.h"
#import "LSPositionHeadCell.h"
#import "LSResumeDetailVC.h"
@interface LSAddResumeVC ()<UITableViewDelegate>
{

}
@property (nonatomic,strong)UITextField *resumeNameTF;
@end

@implementation LSAddResumeVC
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.dataListArr addObject:@[@"简历名称",@"填写简历名称"]];
    [self creatTableView:@"LSPositionHeadCell"];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,30,0);
    __weak LSAddResumeVC *weakSelf  = self;
    
    self.resumeNameTF  = [[UITextField alloc] init];
    
    
    self.resumeNameTF.frame = CGRectMake(40, 60, SCREEN_WIDTH - 2*40, 35);
    
    [self.resumeNameTF setCornerRadius:3];
    self.resumeNameTF.layer.borderColor = color_title_Gray.CGColor;
    self.resumeNameTF.layer.borderWidth = 1;
    self.resumeNameTF.placeholder =  @"  填写简历名称";
    [self.tableView addSubview: weakSelf.resumeNameTF];
    self.tableViewKit.configureCellBlock = ^(id cell,id item,NSIndexPath *index)
    {   NSString *str = item;
        if ([str isEqualToString:@"填写简历名称"]) {
            LSPositionHeadCell *HeadCell = (LSPositionHeadCell*)cell;
            [HeadCell.headLB removeFromSuperview];
        }
    
    };
    //新增简历
    UIButton *btn = [UIButton buttonWithTitle:@"下一步" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
        NSString *str =  self.resumeNameTF.text;
        if (ISNOTNILSTR(str)) {
        
        [self.parDic setObject:self.resumeNameTF.text forKey: @"tb_title"];
        [LSHttpKit getMethod:@"c=Personal&a=NewResume" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
         //新增成功  -->>  简历编辑
            LSResumeDetailVC *resumeDetailVC = [[LSResumeDetailVC alloc] init];
            NSString *resumeID = responseObject[@"data"][@"resumes_id"];
            resumeDetailVC.resume_id = resumeID;
            resumeDetailVC.isEdit = YES;
            [self.navigationController pushViewController:resumeDetailVC animated:YES];
            
        }];
          
        }else
        {
           [SVProgressHUD showImage:nil status:@"请输入简历名称"];
        }
      
    }];
    
    [self.view addSubview:btn];
    btn.edgeNearbottom(0,0,0,30);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 30;
    }else
    {
        return 60;
    }
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    
}



@end

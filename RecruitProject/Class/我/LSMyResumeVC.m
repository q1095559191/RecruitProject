//
//  LSMyResumeVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/24.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSMyResumeVC.h"
#import "LSResumeDetailVC.h"
#import "LSAddResumeVC.h"
#import "LSMyResumeCell.h"
@interface LSMyResumeVC ()<UITableViewDelegate>
{

}

@end

@implementation LSMyResumeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isAppearRefresh = YES;
    [self creatTableView:@"LSMyResumeCell"];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,30,0);
    WeakSelf;
        
    self.tableViewKit.isEdit = YES;
    self.tableViewKit.editBlock = ^(UITableView * tableView, UITableViewCellEditingStyle editingStyle,NSIndexPath *indexPath)
    {
       
        if (editingStyle ==UITableViewCellEditingStyleDelete) {
            //如果编辑样式为删除样式
            if (indexPath.row<[self.dataListArr count]) {
                LSResumeModel *model = weakSelf.dataListArr[indexPath.section][indexPath.row];
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:model.resumes_id forKey:@"resumes_id"];

               [LSHttpKit getMethod:@"c=Personal&a=deleteResume" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   [weakSelf.dataListArr removeObjectAtIndex:indexPath.section];//移除数据源的数据
                   [weakSelf.tableView reloadData];
                   [SVProgressHUD showSuccessWithStatus:@"删除成功!"];
               }];
            }
        }
    };
    
    //刷新简历
    UIButton *btn = [UIButton buttonWithTitle:@"新增简历" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
        LSAddResumeVC *AddResumeVC = [[LSAddResumeVC alloc] init];
        AddResumeVC.title = @"新增简历";
        [self.navigationController pushViewController:AddResumeVC animated:YES];
    }];
    [btn setfont:14];
    [btn setImage:[UIImage imageNamed:@"btn_add_resume_white"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.edgeNearbottom(0,0,0,30);
   
    self.tableViewKit.configureCellBlock = ^(LSMyResumeCell *cell,LSResumeModel *item,NSIndexPath *index)
    {
       cell.checkImage.userInteractionEnabled = YES;
       [cell.checkImage bk_whenTapped:^{
           [weakSelf.parDic setObject:item.resumes_id forKey:@"resumes_id"];
          [LSHttpKit getMethod:@"c=Personal&a=setResumeDefault" parameters:weakSelf.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
              [weakSelf httpRequest];
          }];
       }];
        
    };
    
}

-(void)httpRequest
{
    
//我的简历
[LSHttpKit getMethod:nil parameters:@{@"c": @"Personal",
                                      @"a": @"MyResume"
                                      } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                          if (self.page == 1) {
                                              [self.dataListArr removeAllObjects];
                                          }
                                          
             NSArray *listArr = [NSArray arrayWithArray:responseObject[@"data"][@"list"]];
             if (listArr) {
             for (NSDictionary *resumeDic in listArr) {
             LSResumeModel *medel = [LSResumeModel objectWithKeyValues:resumeDic];
             [self.dataListArr addObject:@[medel]];
             [self.tableView reloadData];
                 
            }
        }
}];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LSResumeDetailVC *resumeDetailVC = [[LSResumeDetailVC alloc] init];
    LSResumeModel *model  = self.dataListArr[indexPath.section][indexPath.row];
    resumeDetailVC.title = model.tb_title;
    resumeDetailVC.resume_id = model.resumes_id;
    [self.navigationController pushViewController:resumeDetailVC animated:YES];

}




//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath

{
//    [tableView setEditing:YES animated:YES];
    return UITableViewCellEditingStyleDelete;
}

//修改编辑按钮文字

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


@end

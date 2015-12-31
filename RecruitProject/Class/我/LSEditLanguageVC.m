//
//  LSEditLanguageVC.m
//  RecruitProject
//
//  Created by sliu on 15/10/28.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSEditLanguageVC.h"
#import "LSLSEditLanguageCell.h"
#import "LSBaseModel.h"
@interface LSEditLanguageVC ()

@end

@implementation LSEditLanguageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *selectArr;

    if (self.languageStr) {
        selectArr =  [self.languageStr componentsSeparatedByString:@","];
    }
    for (NSDictionary *dic in [NSObject getInfo:10]) {
        LSBaseModel *model = [[LSBaseModel alloc] init];
        model.title = dic[@"tb_tilte"];
        model.index = dic[@"tb_id"];
        if (ISNOTNILARR(selectArr)) {
            for (NSString *str in selectArr) {
                NSArray *arr = [str componentsSeparatedByString:@":"];
                if (ISNOTNILARR(arr)) {
                    if (arr.count >= 1) {
                        if ([model.title isEqualToString:arr[0]]) {
                            model.isSelected = YES;
                            NSLog(@"1%@1",model.title);
                            if (arr.count == 2) {
                                model.detailTile = arr[1];
                            }
                        }
                    }
                }
            }
        }
        
        [self.dataListArr addObject:model];
    }

    [self creatTableView:@"LSLSEditLanguageCell"];
    self.tableView.edge(0,0,40,0);
    self.tableView.delegate = self;
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return 40;
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
         return 0.01;
    }];
    
    
    UIButton *btn = [UIButton buttonWithTitle:@"保存" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
       
        NSString *parstr;
        for (LSBaseModel *model in self.dataListArr) {
            if (model.isSelected) {
            
                if (parstr) {
                    if(model.detailTile)
                    {
                   
                    parstr = [NSString stringWithFormat:@"%@,%@:%@",parstr,model.title,model.detailTile];
                    }else
                    {
                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请%@的语言等级",model.title]];
                    }
                    
                }else
                {
                 
                 parstr = [NSString stringWithFormat:@"%@:%@",model.title,model.detailTile];
                }
            }
        }
        if (!parstr) {
            [SVProgressHUD showErrorWithStatus:@"请选择语言"];
        }
        [self.parDic setObject:parstr forKey:@"tb_foreignlanguage"];
        [self.parDic setObject:self.resumes_id forKey:@"resumes_id"];
        [LSHttpKit getMethod:@"c=Personal&a=ModifyLanguage" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }];
    [self.view addSubview:btn];
    btn.edgeNearbottom(0,0,0,30);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LSBaseModel *model = self.dataListArr[indexPath.row];
    if (model.isSelected) {
        model.isSelected = NO;
    }else
    {
       model.isSelected = YES;
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

}

@end

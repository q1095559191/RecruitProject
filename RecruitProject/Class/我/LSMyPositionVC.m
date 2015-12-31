//
//  LSMyPositionVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/23.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSMyPositionVC.h"
#import "LSPositionCell.h"
#import "LSPopListVIew.h"
#import "LSNewPositionVC.h"
@interface LSMyPositionVC ()<CMPopTipViewDelegate>
{
  LSPopListVIew *popTipView;
  NSString *type;
  UIButton *choiseBtn;
}
@end

@implementation LSMyPositionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我发布的职位";
    self.isAppearRefresh = YES;

    choiseBtn = [UIButton buttonWithTitle:@"全部" titleColor:color_white BackgroundColor:[UIColor orangeColor] action:^(UIButton *btn) {
        if (popTipView.showpop) {
            [popTipView dismissAnimated:YES];
        }else
        {
            [popTipView presentPointingAtBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
        }
    }];
    choiseBtn.frame = CGRectMake(0, 0, 70, 25);
    [choiseBtn setCornerRadius:3];
    [choiseBtn setfont:14];
    [choiseBtn setImage:[UIImage imageNamed:@"icon_angle_up_white"] forState:UIControlStateNormal];
    
    [choiseBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 55, 0, 0)];
    [choiseBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:choiseBtn];
    [self creatPopView];
    [self creatBottomView];
    
}


-(NSString *)getOpenings_id
{
    NSString *Openings_id;
    for (LSPositionModel *model in self.dataListArr) {
        if (model.isSelected) {
            if (Openings_id) {
                Openings_id = [NSString stringWithFormat:@"%@,%@",Openings_id,model.openings_id];
            }else
            {
                Openings_id = [NSString stringWithFormat:@"%@",model.openings_id];
            }
        }
    }
    return Openings_id;
}


-(void)creatBottomView
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 55);
    self.tableView.tableFooterView = view;
    CGFloat W = 130;
    CGFloat left = (SCREEN_WIDTH-2*W)/3;
    UIButton *deleBtn = [UIButton buttonWithTitle:@"删除所选" titleColor:color_white BackgroundColor:color_black action:^(UIButton *btn) {
      NSString *openings_id  = [self getOpenings_id];
      NSMutableDictionary *pardic = [NSMutableDictionary dictionary];
      if (openings_id) {
        [pardic setValue:openings_id forKey:@"openings_id"];
       }else
       {
           [SVProgressHUD showErrorWithStatus:@"请选择职位"];
           return ;
       }
      [LSHttpKit getMethod:@"c=Company&a=delPosition" parameters:pardic success:^(AFHTTPRequestOperation *operation, id responseObject) {
          [self httpRequest];
          [SVProgressHUD showSuccessWithStatus:@"删除成功!"];
      }];
    }];
    deleBtn.frame = CGRectMake(left, 0, W, 40);
    [view addSubview:deleBtn];
    [deleBtn setCornerRadius:3];
    
    
    UIButton *sendBtn = [UIButton buttonWithTitle:@"置顶所选" titleColor:color_bg_yellow BackgroundColor:color_white action:^(UIButton *btn) {
        NSString *openings_id  = [self getOpenings_id];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (openings_id) {
            [dic setValue:openings_id forKey:@"openings_id"];
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"请选择职位"];
            return ;
        }
        
        [LSHttpKit getMethod:@"c=Company&a=TopJob" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"置顶成功!"];
        }];
  
    }];
    sendBtn.frame = CGRectMake(left+W+left, 0, W, 40);
    [view addSubview:sendBtn];
    [sendBtn setCornerRadius:3];
    sendBtn.layer.borderColor = color_bg_yellow.CGColor;
    sendBtn.layer.borderWidth = 1;
    
    [sendBtn setImage:[UIImage imageNamed:@"icon_top_orange"] forState:UIControlStateNormal];
    [deleBtn setImage:[UIImage imageNamed:@"icon_trash_gray"] forState:UIControlStateNormal];
    
    
}

-(void)creatContentView
{
    [self creatTableView:@"LSPositionCell"];
    self.tableView.edge(0,0,40,0);
    self.tableView.delegate = self;
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return  60;
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 15;
    }];
    
    
    //刷新简历
    UIButton *btn = [UIButton buttonWithTitle:@"新增职位" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
        LSNewPositionVC *newVC = [[LSNewPositionVC alloc] init];
        [self.navigationController pushViewController:newVC animated:YES];
        
    }];
    [btn setfont:14];
    [btn setImage:[UIImage imageNamed:@"btn_add_job_white"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.edgeNearbottom(0,0,0,30);

}


-(void)creatPopView
{
    NSArray *titles = @[@"全部",@"已审核",@"未审核"];
    popTipView = [LSPopListVIew popListView:titles];
    popTipView.delegate = self;
}

-(void)chocisePOPView:(NSInteger)index
{
   NSArray *titles = @[@"全部",@"已审核",@"未审核"];

    if (index == 0) {
        type = @"3";
    }
    
    if (index == 1) {
        type = @"1";
    }
    if (index == 2) {
        type = @"0";
    }
    [self httpRequest];
    [choiseBtn setTitle:titles[index] forState:UIControlStateNormal];

}

#pragma mark -LSPopListView代理
- (void)popTipViewWasDismissedByUser:(LSPopListVIew *)popView
{
    popView.showpop = NO;
}

-(void)popTipViewAction:(LSPopListVIew *)popView
{
    [self chocisePOPView:popView.index];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //编辑职位
    LSPositionModel *model = self.dataListArr[indexPath.row];
    LSNewPositionVC *newVC = [[LSNewPositionVC alloc] init];
    newVC.model = model;
    [self.navigationController pushViewController:newVC animated:YES];
  
}



-(void)httpRequest
{
// 	0 未审核，1 已审核 3 全部
    if (!type) {
        type = @"3";
    }
[self.parDic setObject:type forKey:@"tb_audit"];
[LSHttpKit getMethod:@"c=Company&a=PostOffice" parameters:self.parDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
    if(self.page == 1)
    {
       [self.dataListArr removeAllObjects];
    }
    
    NSArray *arr = responseObject[@"data"][@"list"];
    if (ISNOTNILARR(arr)) {
        for (NSDictionary *dic in arr) {
            LSPositionModel *model =  [LSPositionModel objectWithKeyValues:dic];
            model.fromType = @"7";
            [self.dataListArr addObject:model];
        }
    }
    
    [self handleNilData:@"你还没有发布任何职位" image:nil];
    [self.tableView reloadData];
 
}];


}

@end

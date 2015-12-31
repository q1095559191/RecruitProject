//
//  LSPositionSearchVC.m
//  RecruitProject
//
//  Created by sliu on 15/10/10.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSPositionSearchVC.h"
#import "LSChoiceAddressView.h"
#import "LSBaseModel.h"
#import "LSChoiceView.h"
@interface LSPositionSearchVC ()<UISearchBarDelegate>
{
    LSChoiceAddressView *choiceAdress;
    LSChoiceAddressView *choiceView;
    LSChoiceView        *choiceView2; //多选
    NSArray *postArr;
    
    
}
@property (strong, nonatomic)  UISearchBar *searchBar;
@end

@implementation LSPositionSearchVC
- (void)viewDidLoad {
    [super viewDidLoad];
    //搜索条
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.backgroundColor = [UIColor clearColor];
    [self.searchBar setKeyboardType:UIKeyboardTypeDefault];
    
    postArr  = [NSObject getInfoWithBaseModel2:16 defineStr:nil];
    self.searchBar.placeholder = @"可通过职位、公司、城市搜索";
    self.navigationItem.titleView =  self.searchBar;
    NSArray *titles = @[@"地区",@"行业职位",@"工作性质",@"工作经验"];
   
    [self.dataListArr addObjectsFromArray:[LSBaseModel getBaseModels:titles]];
    
    for (int i = 0; i < self.dataListArr.count; i ++) {
    LSBaseModel *model = self.dataListArr[i];
        switch (i) {
            case 0:
                 model.detailTile = self.checkModel.tb_city;
                break;
            case 1:
                model.imageUrl = self.checkModel.tb_jobtype;
                model.index = self.checkModel.tb_jobtype_two;
                model.detailTile = [NSObject getInfoDetail:self.checkModel.tb_jobtype_two];
                break;
            case 2:
                model.index = self.checkModel.tb_worknature;
                model.detailTile = [NSObject getInfoDetail:model.index];
                break;

            case 3:
                model.index = self.checkModel.tb_workyear;
                model.detailTile = [NSObject getInfoDetail:model.index];
                break;

                
            default:
                break;
        }
   
        
    }
    
    
    [self creatTableView:@"LSSearchCell"];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,0,0);
    [self  SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return 40;
    } Header:nil Footer:nil];
    
    //清空搜索条件
    UIButton *removeBtn = [UIButton buttonWithTitle:@"  清空搜索条件" titleColor:color_black BackgroundColor:color_clear action:^(UIButton *btn) {
        [self.checkModel empty];
        [self.dataListArr removeAllObjects];
        [self.dataListArr addObjectsFromArray:[LSBaseModel getBaseModels:titles]];
        [self.tableView reloadData];
    }];
    
    [removeBtn setImage:[UIImage imageNamed:@"icon_trash_gray"] forState:UIControlStateNormal];
    [self.tableView addSubview:removeBtn];
    [removeBtn setfont:14];
    removeBtn.frame = CGRectMake((SCREEN_WIDTH-150)/2, 4*40+10, 180, 40);
    
    
    UIButton *searchBtn = [UIButton buttonWithTitle:@"搜索" titleColor:color_white BackgroundColor:color_main action:^(UIButton *btn) {
    [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:searchBtn];
    searchBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 60 - 40, SCREEN_WIDTH, 40);
    [searchBtn setCornerRadius:3];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (choiceView) {
        [choiceView removeFromSuperview];
    }
    LSBaseModel *model = (LSBaseModel *)self.dataListArr[indexPath.row];
    switch (indexPath.row) {
        case 0:
        {
            choiceAdress = [LSChoiceAddressView ChoiceAddressViewInView:self.view checkModel:self.checkModel cancle:^(UIButton *btn) {
                model.detailTile = [self.checkModel getAddress];
                self.checkModel.tb_city = [self.checkModel getAddress];
                [self.tableView reloadData];
            }];
            choiceAdress.selectedIndex21 = self.checkModel.index1;
            choiceAdress.selectedIndex22 = self.checkModel.index2;
            
        }
        break;
        case 1:
        {   //行业职位
            choiceView2 = [LSChoiceView ChoiceViewInView:self.view titles:postArr cancle:^(UIButton *btn) {
                LSBaseModel *model_selet1      =  postArr[choiceView2.selectedIndex];
                LSBaseModel *model_selet2      =  model_selet1.subArr[choiceView2.selectedIndex2];
                model.detailTile               =  model_selet2.title;
                self.checkModel.tb_jobtype     =  model_selet1.index;
                self.checkModel.tb_jobtype_two =  model_selet2.index;
               
                [self.tableView reloadData];
            }];
        }
             break;
        
        case 2:
        {  //工作性质
            choiceView = [LSChoiceAddressView ChoiceViewInView:self.view titles: [NSObject getInfo:1] checkModel:self.checkModel cancle:^(UIButton *btn) {
                self.checkModel.tb_worknature = [choiceView getSelsctedID];
                model.detailTile = [choiceView getSelsctedStr];
                [self.tableView reloadData];
            }];
            choiceView.selectedIndex = [self.checkModel getSeleted:self.checkModel.tb_worknature data:[NSObject getInfo:1]];
        }
            break;
        case 3:
        {   //工作经验
            choiceView = [LSChoiceAddressView ChoiceViewInView:self.view titles: [NSObject getInfo:5] checkModel:self.checkModel cancle:^(UIButton *btn) {
                self.checkModel.tb_workyear = [choiceView getSelsctedID];
                model.detailTile = [choiceView getSelsctedStr];
                [self.tableView reloadData];
            }];
            choiceView.selectedIndex = [self.checkModel getSeleted:self.checkModel.tb_workyear data:[NSObject getInfo:5]];
        }
            break;
        default:
            break;
    }
  
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.checkModel.keyword = searchBar.text;
    [self.navigationController popViewControllerAnimated:YES];
}
@end

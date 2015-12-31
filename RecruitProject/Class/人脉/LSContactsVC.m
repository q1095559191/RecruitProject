//
//  LSContactsVC.m
//  RecruitProject
//
//  Created by sliu on 15/9/21.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSContactsVC.h"
#import "LSNewFriendVC.h"
#import "LSMyAttentionVC.h"
#import "LSContactsCell.h"
#import "LSMyIntersetedVC.h"
#import "LSMyCircleVC.h"
#import "LSContactsCell.h"
@interface LSContactsVC ()<UITableViewDelegate>

@end

@implementation LSContactsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)creatContentView
{
    NSArray *titles = @[@[@"新的朋友"],@[@"可能感兴趣的人",@"可能感兴趣的圈子"],@[@"我关注的好友",@"我关注的企业"],@[@"我创建的圈子",@"我加入的圈子"]];
    NSArray *images = @[@[@"icon_newfriend_normal"],@[@"icon_myfriend_normal",@"icon_interestedgroup_normal"],@[@"icon_myfriend_normal",@"icon_attentioncompany_normal"],@[@"icon_mygroup_normal",@"icon_mygroup_normal"]];
    
     [self.dataListArr addObjectsFromArray:[LSBaseModel getBaseModels:titles images:images]];
    
    [self creatTableView:@"LSContactsCell"];
    self.tableView.delegate = self;
    self.tableView.edge(0,0,0,0);
    [self SetHeightForRow:^CGFloat(UITableView *view, NSIndexPath *indexPath) {
        return 50;
    } Header:^CGFloat(UITableView *view, NSInteger section) {
        return 0.01;
    } Footer:^CGFloat(UITableView *view, NSInteger section) {
        return 15;
    }];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   LSContactsModel *model = (LSContactsModel *)self.dataListArr[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        //新朋友
        LSNewFriendVC *newFriend = [[LSNewFriendVC alloc] init];
        newFriend.hidesBottomBarWhenPushed = YES;
        newFriend.title = model.title;
        [self.navigationController pushViewController:newFriend animated:YES];
    }else if (indexPath.section == 1)
    {  //感兴趣的人/圈子
        LSMyIntersetedVC *intersetedVC  = [[LSMyIntersetedVC alloc] init];
        intersetedVC.title = model.title;
        intersetedVC.hidesBottomBarWhenPushed = YES;
        if (indexPath.row == 0) {
            intersetedVC.isPersonal = YES;
        }
        [self.navigationController pushViewController:intersetedVC animated:YES];
    } else if (indexPath.section == 2)
    {   //关注的人/企业
        LSMyAttentionVC *attentionVC  = [[LSMyAttentionVC alloc] init];
        attentionVC.title = model.title;
        attentionVC.hidesBottomBarWhenPushed = YES;
        if(indexPath.row == 0)
        {
            attentionVC.isPersonal = YES;
        }
        [self.navigationController pushViewController:attentionVC animated:YES];
    }else
    {
        //我创建的圈子
        LSMyCircleVC *myCircleVC  = [[LSMyCircleVC alloc] init];
      
       
        if (indexPath.row == 0) {
              myCircleVC.title = @"我创建的圈子";
            myCircleVC.ismyCreat = YES;
        }else
        {
              myCircleVC.title = @"我加入的圈子";
             myCircleVC.ismyCreat = NO;
        }
        myCircleVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myCircleVC animated:YES];
    }
   
}



@end

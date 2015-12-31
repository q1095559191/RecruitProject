//
//  LSBaseVC.h
//  RecruitProject
//
//  Created by sliu on 15/9/21.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+LSFactory.h"
#import "LSContactsModel.h"
#import <FBKVOController.h>
#import "VPImageCropperViewController.h"

//设置cell的高度
typedef CGFloat (^TableViewHeightForRowBlock)   (UITableView *view,NSIndexPath *indexPath);
//设置头部的高度
typedef CGFloat (^TableViewHeightForHeaderBlock)(UITableView *view,NSInteger section);
//设置底部的高度
typedef CGFloat (^TableViewHeightForFooterBlock)(UITableView *view,NSInteger section);

@interface LSBaseVC : UIViewController<UITableViewDelegate>

//列表数据
@property (nonatomic ,strong)  NSMutableArray *dataListArr;
@property (nonatomic ,strong)  NSMutableDictionary *parDic;

@property (nonatomic ,assign)  NSInteger page;
@property (nonatomic ,assign)  NSInteger offset;
@property (nonatomic ,assign)  BOOL isAppearRefresh;
@property (nonatomic ,strong)  UITableView    *tableView;
@property (nonatomic ,strong)  LSTableViewKit *tableViewKit;
@property (nonatomic ,strong)  FBKVOController  *fbKVO;

@property (nonatomic, copy)   TableViewHeightForRowBlock    HeightForRowBlock;
@property (nonatomic, copy)   TableViewHeightForHeaderBlock HeightForHeaderBlock;
@property (nonatomic, copy)   TableViewHeightForFooterBlock HeightForFooterBlock;

//设置高度
-(void)SetHeightForRow:(TableViewHeightForRowBlock)HeightForRowBlock Header:(TableViewHeightForHeaderBlock)HeightForHeaderBlock  Footer:(TableViewHeightForFooterBlock)HeightForFooterBlock;


//创建tableView
-(void)creatTableView:(id)cellID;




//上拉刷新下拉加载
-(void)addHeaderRefresh;
-(void)addFooterRefresh;
-(void)addHeaderAndFooterRefresh;
-(void)endRefresh;

//处理空数据
-(void)handleNilData;
@property (nonatomic ,copy) NSString       *nodataStr;
@property (nonatomic ,copy) NSString       *nodataImageSTr;

@property (nonatomic ,strong) UILabel      *noDataLB;
@property (nonatomic ,strong) UIImageView  *noDataimage;

-(void)handleNilData:(NSString *)title image:(NSString *)image;


//上传图片
-(void)postImage:(NSString *)type;
@property (nonatomic ,copy) NSString *imageType;


@end

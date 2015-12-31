//
//  LSCircleCell.h
//  RecruitProject
//
//  Created by sliu on 15/10/13.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSBaseCell.h"
#import "LSCircleModel.h"
@interface LSCircleCell : UITableViewCell


//帖子cell
@property (nonatomic ,strong) UIImageView *headImage;         //头像
@property (nonatomic ,strong) UILabel     *postTypeLB;        //
@property (nonatomic ,strong) UILabel     *titleLB;           //帖子标题
@property (nonatomic ,strong) UILabel     *detailLB;          //帖子内容



@property (nonatomic ,strong) UILabel     *timeLB;            //时间
@property (nonatomic ,strong) UIButton    *commentBtn;        //评论按捏
@property (nonatomic ,strong) UIView      *commentbg;         //评论


@property (nonatomic ,strong) UILabel     *moreLB;            //更多评论
@property (nonatomic ,strong) UIButton    *detailBtn;         //帖子内容详情
@property (nonatomic ,strong) UIButton    *moreBtn;           //查看更多评论


@end

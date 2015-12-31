//
//  LSPersonalDynamicCell.m
//  RecruitProject
//
//  Created by sliu on 15/9/24.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSPersonalDynamicCell.h"

@implementation LSPersonalDynamicCell

- (void)awakeFromNib {
    // Initialization code
    
    _dynamicTypeLB = [UILabel labelWithText:@"张三加入了一个圈子" color:color_black font:14 Alignment:LSLabelAlignment_left];
   
    [self.contentView addSubview:_dynamicTypeLB];
    
    _timeLB = [UILabel labelWithText:@"2014-12-12 10:30" color:color_title_Gray font:12 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_timeLB];
    
    _titleLB = [UILabel labelWithText:nil color:color_main font:16 Alignment:LSLabelAlignment_left];
    _titleLB.numberOfLines = 0;
    [self.contentView addSubview:_titleLB];
    
    _detailLB = [UILabel labelWithText:nil color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
    _detailLB.numberOfLines = 0;
    [self.contentView addSubview:_detailLB];
    
    _headImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImage];
    _headImage.backgroundColor = [UIColor lightGrayColor];
    [_headImage setCornerRadius:3];
    
     self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
    //删除
    self.deleBtn = [UIButton buttonWithTitle:@"删除" titleColor:color_main BackgroundColor:color_white action:^(UIButton *btn) {
        
    }];
    [self.contentView addSubview: self.deleBtn];
    self.deleBtn.frame = CGRectMake(SCREEN_WIDTH-50, 5, 40, 30);
    [self.deleBtn setfont:14];
    
    
}


+(CGFloat)GetCellH:(id)data
{
    BOOL isImage = NO;
    NSString *dynamicTypeStr;
    NSString *timeStr;
    NSString *titleStr;
    NSString *detailStr;
    
    
    CGFloat LabelW = SCREEN_WIDTH-20;
    CGFloat detailH = 0;
    CGFloat TitleH = 0;
    CGFloat detailLeft = 10;
   
    
    if ([data isKindOfClass:[LSDynamicModel class]]) {
        LSDynamicModel *model = (LSDynamicModel *)data;
        
        dynamicTypeStr  = model.tb_title;
        timeStr = [NSObject getTime:model.tb_addtime];
        
        if ([model.tb_type isEqualToString:@"1"]) {
            //加入圈子
            isImage  = YES;
            if(ISNOTNILDIC(model.ext_info))
            {
               titleStr = model.ext_info[@"tb_name"];
               detailStr = model.ext_info[@"tb_info"];
            }
            
        }else if ([model.tb_type isEqualToString:@"2"])
        { //创建简历   添加教育精力
            
        }
        else if ([model.tb_type isEqualToString:@"3"])
        {    //新增帖子
             isImage  = NO;
            if(ISNOTNILDIC(model.ext_info))
            {
                titleStr = model.ext_info[@"tb_title"];
                detailStr = model.ext_info[@"tb_remark"];
            }
            
        }else
        {  //
            
        }
    }
    if (isImage) {
        detailLeft += 50;
        LabelW    -= 50;
    }
    TitleH = [titleStr getStrH:LabelW font:16]+10;
    detailH = [detailStr getStrH:LabelW font:14]+8;
    
    return 50+TitleH+detailH;
}


-(void)configCell:(id)data
{
  
    BOOL isImage = NO;
    NSString *dynamicTypeStr;
    NSString *timeStr;
    NSString *titleStr;
    NSString *detailStr;
  
    if ([data isKindOfClass:[LSDynamicModel class]]) {
        LSDynamicModel *model = (LSDynamicModel *)data;
        if ([model.fromType isEqualToString:@"2"]) {
            self.deleBtn.hidden = NO;
        }else
        {
            self.deleBtn.hidden = YES;
        }
        
        
        dynamicTypeStr  = model.tb_title;
        timeStr = [NSObject getTime:model.tb_addtime];
        if ([model.tb_type isEqualToString:@"1"]) {
         //加入圈子   创建圈子http://103.21.119.31:801/themes/webhtm/images/app_def_head.png
            isImage  = YES;
            if(ISNOTNILDIC(model.ext_info))
            {
                [_headImage setImageWithURL:[NSURL URLWithString:model.ext_info[@"tb_img"]]];
                titleStr = model.ext_info[@"tb_name"];
                detailStr = model.ext_info[@"tb_info"];
                
            }else
            {
               isImage  = NO;
            }

        }else if ([model.tb_type isEqualToString:@"2"])
        { //创建简历   添加教育精力
        
        }
        else if ([model.tb_type isEqualToString:@"3"])
        { //发表动态
            if(ISNOTNILDIC(model.ext_info))
            {
                titleStr = model.ext_info[@"tb_title"];
                detailStr = model.ext_info[@"tb_remark"];
            }
            
        }else
        {  //
           //    3：跳到帖子
           //    4，5：跳到职位详细
            
        }
    }
    
    //赋值
    _dynamicTypeLB.text = dynamicTypeStr;
    _timeLB.text = timeStr;
    _titleLB.text = titleStr;
    _detailLB.text = detailStr;
    
    CGFloat LabelW = SCREEN_WIDTH-20;
    CGFloat detailH = 0;
    CGFloat TitleH = 0;
    CGFloat detailLeft = 10;
    _dynamicTypeLB.frame = CGRectMake(10, 0, LabelW, 30);
    _timeLB.frame = CGRectMake(10, 30, LabelW, 20);
    
     _headImage.frame = _detailLB.frame = CGRectMake(10, 50, 40, 40);
    if (!isImage) {
        _headImage.hidden = YES;
    }else
    {
          _headImage.hidden = NO;
        detailLeft += 50;
        LabelW    -= 50;
    }
    TitleH = [titleStr getStrH:LabelW font:16]+10;
    detailH = [detailStr getStrH:LabelW font:14]+8;
    
    _titleLB.frame = CGRectMake(detailLeft, 50, LabelW, TitleH);
    _detailLB.frame = CGRectMake(detailLeft, 50+TitleH, LabelW, detailH);
    
    
  
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    return self;
}





@end

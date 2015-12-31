//
//  LSCircleCell.m
//  RecruitProject
//
//  Created by sliu on 15/10/13.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSCircleCell.h"

@implementation LSCircleCell
- (void)awakeFromNib {
    // Initialization code
    
    _headImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImage];
    [_headImage setCornerRadius:5];
    _headImage.backgroundColor = [UIColor lightGrayColor];
    
    _titleLB = [UILabel labelWithText:nil color:color_black font:16 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_titleLB];
    
    _detailLB = [UILabel labelWithText:@"帖子内容" color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
    _detailLB.numberOfLines = 0;
    [self.contentView addSubview:_detailLB];
    _detailLB.userInteractionEnabled = YES;
    
    _detailBtn = [UIButton buttonWithImage:nil action:^(UIButton *btn) {
        
    }];
    [_detailLB addSubview:_detailBtn];
    _detailBtn.edge(0,0,0,0);
  
    
    _postTypeLB = [UILabel labelWithText:@"张三 发表了一个帖子" color:color_black font:12 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_postTypeLB];
    
    _commentBtn = [UIButton buttonWithTitle:@"评论" titleColor:color_black BackgroundColor:color_white action:^(UIButton *btn)
                   {
                       
                   }];
    [_commentBtn setImage:[UIImage imageNamed:@"icon_comment_no_normal"] forState:UIControlStateNormal];
    [_commentBtn setfont:12];
    [self.contentView addSubview:_commentBtn];
    
    
    _timeLB = [UILabel labelWithText:@"1小时前" color:color_title_Gray font:14 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_timeLB];
   
    _commentbg  = [[UIView alloc] init];
    _commentbg .backgroundColor = color_bg;
    [_commentbg setCornerRadius:3];
    [self.contentView addSubview:_commentbg];
    
    
    //查看更多回复
    self.moreBtn = [UIButton buttonWithTitle:@"查看更多评论" titleColor:color_main BackgroundColor:color_clear action:^(UIButton *btn) {
        
    }];
    [_commentbg addSubview:self.moreBtn];
    [ self.moreBtn setfont:12];
    self.moreBtn.titleLabel.textAlignment = NSTextAlignmentRight;
  
 
   
}
+(CGFloat)GetCellH:(id)data
{
    if (ISKINDOFCLASS(data, LSCircleModel)) {
        LSCircleModel *model = (LSCircleModel *)data;
        CGFloat  left = 70;
        CGFloat  commentH = 0;
        CGFloat  labelW =  SCREEN_WIDTH-left-10;
        
        //帖子详情的高
        CGFloat  contentH  = [model.tb_connet getStrH:labelW font:12];
        //帖子详情部分显示
        if (!model.isShow) {
            if (contentH >= 60) {
                contentH = 70;
            }
        }
        

        NSMutableArray *arr = [NSMutableArray array];
        NSMutableArray *comment = [NSMutableArray array];;
        for (NSDictionary *dic in model.comment_list) {
            NSString *name = dic[@"name"];
            NSString *txt = dic[@"txt"];
            [arr addObject:name];
            [comment addObject:txt];
        }
        NSInteger count = model.comment_list.count;
        if (!model.isShowReply) {
            if (model.comment_list.count > 4) {
                count  = 4;
            }
        }
        
        for (int i = 0; i < count; i++) {
            NSString *name = [NSString stringWithFormat:@"%@: %@",arr[i],comment[i]];
            CGFloat labelH = [name getStrH:labelW font:12]+10;
            commentH += labelH;
        }
        
        //更多回复
        if (model.comment_list.count > 4) {
        commentH += 30;

        }
        commentH += 8;
        
        //图片
        if (model.imageArr.count > 2) {
            contentH += labelW+10;
        }else if (model.imageArr.count != 0)
        {
            contentH +=  (labelW-10)/2+10;
        }
    
        return 60+contentH+10+commentH+20+10;
    }
    return 100;
}

-(void)configCell:(id)data
{
    if (ISKINDOFCLASS(data, LSCircleModel)) {
        LSCircleModel *model = (LSCircleModel *)data;
        [_headImage setImageWithURL:[NSURL URLWithString:model.img]];
        _titleLB.text = model.tb_title;
       
        _postTypeLB.text = [NSString stringWithFormat:@"%@ 发表了一个帖子",model.truename];
        [_postTypeLB settingSub:[NSString stringWithFormat:@"%@",model.truename] color:color_main font:12];
        _timeLB.text = model.interval_time;
        CGFloat  left = 70;
        CGFloat  commentH = 0;
        CGFloat  labelW =  SCREEN_WIDTH-left-10;
        NSString *conneStr = model.tb_connet;

       //帖子内容
        _detailLB.text = model.tb_connet;
        CGFloat  contentH  = [conneStr getStrH:labelW font:12];
        if(!model.isShow)
        {
          if (contentH >= 60) {
             contentH = 70;
           }
        }
        
        _headImage.frame = CGRectMake(10, 10, 50, 50);
        _postTypeLB.frame = CGRectMake(left, 10, labelW, 20);
        _titleLB.frame = CGRectMake(left, 30, labelW, 30);
        _detailLB.frame = CGRectMake(left,60,labelW,contentH+10);
       
        //图片
        for (UIView *image in self.contentView.subviews) {
            if (image.tag >= 102 && image.tag <= 105) {
                [image removeFromSuperview];
            }
        }
        
        if(model.imageArr)
        {
            for (int i = 0; i < model.imageArr.count; i++) {
                UIImageView *image = [[UIImageView alloc] init];
                [image setImageWithURL:[NSURL URLWithString: model.imageArr[i]] placeholderImage:nil];
                image.tag = 102+i;
                [self.contentView addSubview:image];
                CGFloat imageW = (labelW - 10)/2;
                CGFloat imageY = 60 + contentH+10;
                int a = i%2;
                if (i>=2) {
                    imageY = 60 + contentH+10+imageW+10;
                }
                image.frame = CGRectMake(left+a*(imageW +10),imageY,imageW,imageW);
                image.backgroundColor = color_bg;
            }
            
            if (model.imageArr.count > 2) {
                contentH += labelW+10;
            }else if (model.imageArr.count != 0)
            {
                contentH +=  (labelW-10)/2+10;
            }
        }
        //回复
        NSMutableArray *arr = [NSMutableArray array];
        NSMutableArray *comment = [NSMutableArray array];;
        for (NSDictionary *dic in model.comment_list) {
            NSString *name = dic[@"name"];
            NSString *txt = dic[@"txt"];
            [arr addObject:name];
            [comment addObject:txt];
         }
        
        for (UIView *view in [_commentbg subviews]) {
            if (![view isKindOfClass:[UIButton class]]) {
                 [view removeFromSuperview];
            }
        }
        
        NSInteger count = model.comment_list.count;
        if (!model.isShowReply) {
            if (model.comment_list.count >= 4) {
                count  = 4;
            }
        }
     
        for (int i = 0; i < count; i++) {
            NSString *name = [NSString stringWithFormat:@"%@: ",arr[i]];
            UILabel *label = [UILabel labelWithText:[NSString stringWithFormat:@"%@%@",name,comment[i]] color:color_black font:12 Alignment:LSLabelAlignment_left];            
            [label settingSub:name color:color_main font:12];
            CGFloat labelH = [label.text getStrH:labelW font:12]+10;
            label.frame = CGRectMake(8, commentH, labelW-8, labelH);
            label.backgroundColor = color_bg;
            [_commentbg addSubview:label];
            commentH += labelH;
            label.numberOfLines = 0;
        }
        
        
        if (model.comment_list.count > 4) {
            //更多回复
            self.moreBtn.hidden = NO;
            [self.moreBtn setTitle:[NSString stringWithFormat:@"更多%li条回复...",model.comment_list.count-4] forState:UIControlStateNormal];
            [self.moreBtn setTitle:[NSString stringWithFormat:@"收起"] forState:UIControlStateSelected];
            self.moreBtn.frame  = CGRectMake(10, commentH, labelW -20, 30);
            commentH += 30;
            self.moreBtn.selected = model.isShowReply;
            
        }else
        {
            self.moreBtn.hidden = YES;
        }
        
  
        _commentbg.frame = CGRectMake(left, 60+contentH+10, labelW, commentH);
        commentH += 8;
        _commentBtn.frame = CGRectMake(SCREEN_WIDTH-10-50, 60+contentH+7+commentH, 50, 30);
        _timeLB.frame   = CGRectMake(70,60+contentH+10+commentH, SCREEN_WIDTH-70-70, 20);
    }    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end

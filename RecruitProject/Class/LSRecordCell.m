//
//  LSRecordCell.m
//  RecruitProject
//
//  Created by sliu on 15/10/19.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSRecordCell.h"

@implementation LSRecordCell

-(void)awakeFromNib
{
    _textLB = [UILabel labelWithText:@"qdncanmxlknxama;mama,pcaoillmxdaldldlaNdknldnLKndlKD;" color:color_black font:14 Alignment:LSLabelAlignment_left];
    [self.contentView addSubview:_textLB];
    _textLB.numberOfLines = 0;
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
}

+(CGFloat)GetCellH:(id)data
{
    if ([data isKindOfClass:[LSRecordModel class]]) {
        LSRecordModel *model = (LSRecordModel *)data;
       
        if (!ISNOTNILSTR(model.text)) {
            model.text  = @"无";
           
        }
        CGFloat W = SCREEN_WIDTH-20;
        if (model.isEdit) {
            W -= 50;
        }
        if (ISNOTNILARR(model.listArr)) {
            if (model.listArr.count == 0) {
                CGFloat h = [model.text getStrH:W font:14];
                return 10 +h +5;
            }
        }else
        {
            CGFloat h = [model.text getStrH:W font:14];
            return 10 +h +5;
        }
        
        if ([model.tb_type isEqualToString:@"1"]) {
            CGFloat H = [model.text getStrH:W font:14]+20;
            return H;
        }else if ([model.tb_type isEqualToString:@"2"])
        {  //自我评价
            CGFloat H = [model.text getStrH:W font:14]+20;
            return H;
        }else if ([model.tb_type isEqualToString:@"3"])
        {
            //工作经历
    
            CGFloat  H = 0;
            for (NSDictionary *dic in model.listArr) {
                NSMutableArray *titles = [NSMutableArray array];
                [titles addObject:dic[@"tb_unitname"]];
                [titles addObject:[NSString stringWithFormat:@"工作时间    %@~%@", dic[@"tb_startday"], dic[@"tb_endday"]]];
                [titles addObject:[NSString stringWithFormat:@"薪   资    %@", [NSObject getInfoDetail:dic[@"tb_salary"]]]];
                [titles addObject:[NSString stringWithFormat:@"所在职位    %@",dic[@"tb_post"]]];
                [titles addObject:[NSString stringWithFormat:@"工作描述\n%@",dic[@"tb_txt"]]];
                for (int i = 0; i < 5; i ++) {
                    CGFloat LabelH  = [titles[i] getStrH:W font:14]+20;
                    H += LabelH;
                }
                
            }
            return H;
        }else if ([model.tb_type isEqualToString:@"4"])
        {
            //教育经历
         
            CGFloat  H = 0;
            for (NSDictionary *dic in model.listArr) {
                NSMutableArray *titles = [NSMutableArray array];
                [titles addObject:dic[@"tb_unitname"]];
                
                [titles addObject:[NSString stringWithFormat:@"工作时间    %@~%@",dic[@"tb_startday"], dic[@"tb_endday"]]];
                [titles addObject:[NSString stringWithFormat:@"专业名称    %@", dic[@"tb_unittype"]]];
                [titles addObject:[NSString stringWithFormat:@"学    历    %@", [NSObject getInfoDetail:dic[@"tb_post"]]]];
               
                for (int i = 0; i < titles.count; i ++) {
                    CGFloat LabelH  = [titles[i] getStrH:W font:14]+20;
                   
                    H += LabelH;
                }
                
            }
           return H;
        }
    
    }
     return 100;
}

    
    
    
-(void)configCell:(id)data
{
    for (UIView *view in [self.contentView subviews]) {
        if (view != _textLB) {
            [view removeFromSuperview];
        }
       
    }
    
    
  if ([data isKindOfClass:[LSRecordModel class]]) {
        LSRecordModel *model = (LSRecordModel *)data;
        [_textLB setHidden:NO];
       if (ISNOTNILARR(model.listArr)) {
           if (model.listArr.count >= 1) {
              [_textLB setHidden:YES];
           }
       }
      if (!ISNOTNILSTR(model.text)) {
          model.text  = @"无";
      }
      if (!_textLB.hidden) {
        _textLB.text =[NSString stringWithFormat:@"%@",model.text];
        CGFloat h = [_textLB.text getStrH:SCREEN_WIDTH-20 font:14];
        _textLB.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, h);
          return;
      }
      
      
        if ([model.tb_type isEqualToString:@"1"]) {
            _textLB.text =[NSString stringWithFormat:@"%@",model.text];
            CGFloat h = [_textLB.text getStrH:SCREEN_WIDTH-20 font:14];
            _textLB.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, h);
            if ([model.text hasPrefix:@"语言能力"]) {
                [_textLB settingSub:@"语言能力" color:color_title_Gray font:14];
            }
            
        }else if ([model.tb_type isEqualToString:@"2"])
        {  //自我评价
            _textLB.text = model.text;
            CGFloat h = [_textLB.text getStrH:SCREEN_WIDTH-20 font:14];
            _textLB.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, h);
            
            
        }else if ([model.tb_type isEqualToString:@"3"])
        {
            
            NSArray *heads = @[@"工作时间",@"薪        资",@"所在职位",@"工作描述"];
             //工作经历
            CGFloat  H = 0;
           
            for (int k = 0; k< model.listArr.count; k++) {
                NSDictionary *dic = model.listArr[k];
                if (H!= 0) {
                    UIView *line = [[UIView alloc] init];
                    line.backgroundColor = color_line;
                    [self.contentView addSubview:line];
                    line.frame = CGRectMake(0, H, SCREEN_WIDTH, 1);
                }
                
                NSMutableArray *titles = [NSMutableArray array];
                [titles addObject:dic[@"tb_unitname"]];
                [titles addObject:[NSString stringWithFormat:@"工作时间    %@~%@", dic[@"tb_startday"], dic[@"tb_endday"]]];
                [titles addObject:[NSString stringWithFormat:@"薪        资    %@", [NSObject getInfoDetail:dic[@"tb_salary"]]]];
                [titles addObject:[NSString stringWithFormat:@"所在职位    %@",dic[@"tb_post"]]];
                [titles addObject:[NSString stringWithFormat:@"工作描述\n%@",dic[@"tb_txt"]]];
                CGFloat W = SCREEN_WIDTH-20;
                if (model.isEdit) {
                    W -= 50;
                //添加编辑按钮
                 UIButton *editBtn = [UIButton buttonWithImage:@"btn_edit_resume_orange" action:^(UIButton *btn) {
                     [self senderNotificationIndex:@"edit" userInfo:dic];
                 }];
                editBtn.tag = k + 1000;
                [self.contentView addSubview:editBtn];
                editBtn.frame = CGRectMake(SCREEN_WIDTH-40, H+65, 25, 40);
                }
                for (int i = 0; i < 5; i ++) {
                    UILabel *label;
                    CGFloat LabelH  = [titles[i] getStrH:W font:14]+20;
                    if (i == 0) {
                        label = [UILabel labelWithText:titles[i] color:color_main font:14 Alignment:LSLabelAlignment_left];
                    }else
                    {
                      label = [UILabel labelWithText:titles[i] color:color_black font:14 Alignment:LSLabelAlignment_left];
                       
                        [label settingSub:heads[i-1] color:color_title_Gray font:14];
                    }
                    label.numberOfLines = 0;
                    label.frame = CGRectMake(10, H, W, LabelH);
                    H += LabelH;
                    [self.contentView addSubview:label];
                    
                    if (i != 0  || i != titles.count -1) {
                        UIImageView *lineimage = [[UIImageView alloc] init];
                        lineimage.image = [UIImage imageNamed:@"line_dashed"];
                        [self.contentView addSubview:lineimage];
                        lineimage.frame = CGRectMake(10, H, W, 1);
                    }
                    
                }
            }
            
        }else if ([model.tb_type isEqualToString:@"4"])
        {
             //教育经历
            NSArray *heads = @[@"学习时间",@"专业名称",@"学        历"];
          
            CGFloat  H = 0;
            for (int k = 0; k< model.listArr.count; k++) {
                NSDictionary *dic = model.listArr[k];
                if (H!= 0) {
                    UIView *line = [[UIView alloc] init];
                    line.backgroundColor = color_line;
                    [self.contentView addSubview:line];
                    line.frame = CGRectMake(0, H, SCREEN_WIDTH, 1);
                }
                NSMutableArray *titles = [NSMutableArray array];
                [titles addObject:dic[@"tb_unitname"]];
               
                [titles addObject:[NSString stringWithFormat:@"工作时间    %@~%@", dic[@"tb_startday"], dic[@"tb_endday"]]];
                [titles addObject:[NSString stringWithFormat:@"专业名称    %@", dic[@"tb_unittype"]]];
                [titles addObject:[NSString stringWithFormat:@"学        历    %@", [NSObject getInfoDetail:dic[@"tb_post"]]]];
                CGFloat W = SCREEN_WIDTH-20;
                if (model.isEdit) {
                    W -= 50;
                    //添加编辑按钮
                    UIButton *editBtn = [UIButton buttonWithImage:@"btn_edit_resume_orange" action:^(UIButton *btn) {
                    [self senderNotificationIndex:@"edit" userInfo:dic]; 
                    }];
                    [self.contentView addSubview:editBtn];
                    editBtn.tag = k + 1000;
                    editBtn.frame = CGRectMake(SCREEN_WIDTH-40, H+50, 25, 40);
                }
                
                for (int i = 0; i < titles.count; i ++) {
                    UILabel *label;
                    CGFloat LabelH  = [titles[i] getStrH:W font:14]+20;
                    if (i == 0) {
                        label = [UILabel labelWithText:titles[i] color:color_main font:14 Alignment:LSLabelAlignment_left];
                    }else
                    {
                        label = [UILabel labelWithText:titles[i] color:color_black font:14 Alignment:LSLabelAlignment_left];
                        [label settingSub:heads[i-1] color:color_title_Gray font:14];
                    }
                    label.frame = CGRectMake(10, H, W, LabelH);
                     H += LabelH;
                    label.numberOfLines = 0;
                    [self.contentView addSubview:label];
                    
                    if (i != 0  || i != titles.count -1) {
                        UIImageView *lineimage = [[UIImageView alloc] init];
                        lineimage.image = [UIImage imageNamed:@"line_dashed"];
                        [self.contentView addSubview:lineimage];
                        lineimage.frame = CGRectMake(10, H, W, 1);
                    }

                }
               
            }
  
        }
   
    }

}

@end

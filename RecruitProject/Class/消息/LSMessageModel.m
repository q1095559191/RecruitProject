//
//  LSMessageModel.m
//  RecruitProject
//
//  Created by sliu on 15/11/4.
//  Copyright © 2015年 sliu. All rights reserved.
//

#import "LSMessageModel.h"

@implementation LSMessageModel

-(void)keyValuesDidFinishConvertingToObject
{
    if (ISNOTNILDIC(self.member_info)) {
        self.truename = self.member_info[@"truename"];
        self.img      =  self.member_info[@"img"];
    }

    self.showStr = @"去看看";
    if(ISNOTNILSTR(self.msg_txt))
    {
       NSData *data = [self.msg_txt dataUsingEncoding:NSUTF8StringEncoding];
       NSDictionary *dic  =   [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        if (ISNOTNILDIC(dic)) {
            self.otherDic = dic;
            if (APPDELEGETE.isCompany) {
                 [self handlepersonal];
            }else
            {
                 [self handleCompany];
            }
        }else
        {
            NSLog(@"JSON 异常");
        }
    }
}


-(void)handlepersonal
{
    //信息处理
    switch ([self.msg_type intValue]) {
        case 21:
        {
            //应聘职位
            self.detailStr = [NSString stringWithFormat:@"您好,我是%@,我应聘了贵公司的职位",self.truename];
            self.showStr = @"职位详情";
        }
            break;
        case 22:
        {
            //收藏职位
            self.detailStr = [NSString stringWithFormat:@"您好,我是%@,我收藏了贵公司的职位",self.truename];
            self.showStr = @"简历详情";
        }
            break;
        case 23:
        {
            //关注
            self.detailStr = [NSString stringWithFormat:@"您好,我是%@,我关注了您",self.truename];
            self.showStr = @"去个人主页";
        }
            break;
     
        default:
            break;
    }

}

-(void)handleCompany
{
    //信息处理
    
    switch ([self.msg_type intValue]) {
        case 11:
        {
            //查看简历
            self.detailStr = [NSString stringWithFormat:@"查看了您的简历"];
            self.showStr = @"去公司主页";
        }
            break;
        case 12:
        {
            //企业收藏个人简历
            self.detailStr = [NSString stringWithFormat:@"收藏了您的简历"];
            self.showStr = @"去公司主页";
            
        }
            break;
        case 13:
        {
            //企业发送面试邀请
            self.detailStr = [NSString stringWithFormat:@"您好,我是%@的HR,我看到了您的简历,邀请您参加我公司的面试",self.truename];
            
        }
            break;
        case 14:
        {
            //企业发送面试邀请  带职位
            self.detailStr = [NSString stringWithFormat:@"您好,我是%@的HR,我看到了您的简历,邀请您参加我公司的(%@)的面试",self.otherDic[@"tb_companyname"],self.otherDic[@"openings_name"]];
            
            self.detailStr2 = [NSString stringWithFormat:@"【面试邀请】\n%@\n月薪:%@\n工作地点:%@",self.otherDic[@"openings_name"],self.otherDic[@"tb_companyname"],self.otherDic[@"tb_companyname"]];
            
        }
            break;
            
            
        default:
            
            break;
    }
    
  

}
@end

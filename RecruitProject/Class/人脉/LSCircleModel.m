//
//  LSCircleModel.m
//  RecruitProject
//
//  Created by sliu on 15/10/13.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSCircleModel.h"

@implementation LSCircleModel

//字典转化完毕
-(void)keyValuesDidFinishConvertingToObject
{
    if(self.member_info)
    {
        self.img = self.member_info[@"img"];
        self.truename = self.member_info[@"truename"];
        self.userID = self.member_info[@"member_id"];
    }
    
  if(self.tb_img)
  {
    self.imageArr = [self.tb_img componentsSeparatedByString:@","];
      if (self.imageArr.count == 1) {
          if (![self.imageArr[0] hasPrefix:@"http"]) {
              self.imageArr = [NSArray array];
          }
      }
  }
    

}

@end

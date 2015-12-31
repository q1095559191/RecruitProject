//
//  NSObject+LSSaveKit.m
//  ShoppingProject
//
//  Created by admin on 15/8/3.
//  Copyright (c) 2015年 GuanYisoft. All rights reserved.
//

#import "NSObject+LSSaveKit.h"
#define LSNotificationID @"LSNotificationID"


@implementation NSObject (LSSaveKit)
+(void)removeSaveWithKey:(NSString *)key
{

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)saveDateWithKey:(NSString *)key
{

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:self forKey:key];
    
}

+(id)getSaveDateWithKey:(NSString *)key
{
   NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    return [user objectForKey:key];
}

-(void)senderNotificationIndex:(NSString*)index userInfo:(NSDictionary *)dic{
    
   [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@",index] object:nil userInfo:dic];
}

-(void)addObserverIndex:(NSString*)index
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:[NSString stringWithFormat:@"%@",index] object:nil];
}

-(void)notification:(NSNotification *)noti
{
   
}

//打印属性
+(void)log:(NSDictionary *)dic
{
    NSString *str;
    for (int i =0; i < [[dic allKeys] count]; i++) {
        NSString *key = [dic allKeys][i];
//        NSString *values = [dic allValues][i];
         str = [NSString stringWithFormat:@"%@\n@property (nonatomic ,copy) NSString *%@;",str,key];
    }   
    NSLog(@"%@",str);
}

+(NSString *)getInfoDetail:(NSString *)index
{
    if(ISNOTNILSTR(index))
    {   NSString *str;
        NSDictionary *dic = [NSObject getSaveDateWithKey:LSSAVE_Info_dic];
        str = [dic objectForKey:index];
        if (str) {
             return str;
        }else
        {
        return @"未填写";
        }
       
    }else
    {
        return @"无";
    }
    
}

+(NSString *)getInfoDetail:(NSInteger)index  key:(NSInteger)key
{
    
 NSString *indexStr = [NSString stringWithFormat:@"%li",(long)index];
 NSArray *dataArr = [[NSObject getSaveDateWithKey:LSSAVE_dictInfo][indexStr][@"list"] allValues];
  for (NSDictionary *dic in dataArr) {
      NSArray *detailArr =   dic[@"chd"];
      if(detailArr)
      {  //子行业
          for (NSDictionary *dic in detailArr ) {
              if ([dic[@"tb_id"] integerValue] == key) {
                  return dic[@"tb_tilte"];
              }
          }
      
      }else
      {
          if ([dic[@"tb_id"] integerValue] == key) {
              return dic[@"tb_tilte"];
          }
      }
      
    }    
    return nil;
}

+(NSArray *)getInfo:(NSInteger)index
{
    NSString *indexStr = [NSString stringWithFormat:@"%li",(long)index];
    NSArray *dataArr = [[NSObject getSaveDateWithKey:LSSAVE_dictInfo][indexStr][@"list"] allValues];
    NSMutableArray *infoArr = [NSMutableArray array];
    NSArray *array2 = [dataArr sortedArrayUsingSelector:@selector(compare:)];
    for (NSDictionary *dic in array2) {
        if (ISNOTNILDIC(dic)) {
//            NSString *str = dic[@"tb_tilte"];
            [infoArr addObject:dic];
        }
    }
    return infoArr;
}
//1:工作性质2:工作地点3:工作状态4:期望月薪5:工作经验6:学历7:薪资水平8:行业类别9:企业性质10:语种11:职位类别12:公司规模13:热搜职位14:热门搜索15:时间间隔16:行业职位 17:发布时间

+(NSArray *)getInfoWithBaseModel:(NSInteger)index
{
    NSString *indexStr = [NSString stringWithFormat:@"%li",(long)index];
    NSArray *dataArr = [[NSObject getSaveDateWithKey:LSSAVE_dictInfo][indexStr][@"list"] allValues];
    NSMutableArray *infoArr = [NSMutableArray array];
    NSArray *array2 = [dataArr sortedArrayUsingSelector:@selector(compare:)];
    for (NSDictionary *dic in array2) {
        if (ISNOTNILDIC(dic)) {
            //            NSString *str = dic[@"tb_tilte"];
          
            LSBaseModel *model = [[LSBaseModel alloc] init];
            model.title = dic[@"tb_tilte"];
            model.index = dic[@"tb_id"];
            [infoArr addObject:model];
        }
    }
    return infoArr;
}

+(NSArray *)getInfoWithBaseModel:(NSInteger)index defineStr:(NSString *)str
{
    NSString *indexStr = [NSString stringWithFormat:@"%li",(long)index];
    NSArray *dataArr = [[NSObject getSaveDateWithKey:LSSAVE_dictInfo][indexStr][@"list"] allValues];
    NSMutableArray *infoArr = [NSMutableArray array];
    NSArray *array2 = [dataArr sortedArrayUsingSelector:@selector(compare:)];
    for (NSDictionary *dic in array2) {
        if (ISNOTNILDIC(dic)) {
            //            NSString *str = dic[@"tb_tilte"];
            
            LSBaseModel *model = [[LSBaseModel alloc] init];
            model.title = dic[@"tb_tilte"];
            model.index = dic[@"tb_id"];
            if (!ISNILSTR(str)) {
                if ([str isEqualToString: model.index]) {
                    model.isSelected = YES;
                }
            }
            [infoArr addObject:model];
        }
    }
    return infoArr;

}

+(NSArray *)getInfoWithBaseModel2:(NSInteger)index defineStr:(NSString *)str
{
    //2维数组
    NSString *indexStr = [NSString stringWithFormat:@"%li",(long)index];
    NSArray *dataArr = [[NSObject getSaveDateWithKey:LSSAVE_dictInfo][indexStr][@"list"] allValues];
    NSMutableArray *infoArr = [NSMutableArray array];
    NSArray *array2 = [dataArr sortedArrayUsingSelector:@selector(compare:)];
    for (NSDictionary *dic in array2) {
        if (ISNOTNILDIC(dic)) {
            //            NSString *str = dic[@"tb_tilte"];
            
            LSBaseModel *model = [[LSBaseModel alloc] init];
            model.title = dic[@"tb_tilte"];
            model.index = dic[@"tb_id"];
            NSArray *chd = dic[@"chd"];
            if (ISNOTNILARR(chd)) {
                model.subArr = [[NSMutableArray alloc] init];
                for (NSDictionary *subDic in chd) {
                    LSBaseModel *subModel = [[LSBaseModel alloc] init];
                    subModel.title = subDic[@"tb_tilte"];
                    subModel.index = subDic[@"tb_id"];
                    [model.subArr addObject:subModel];
                    if (!ISNILSTR(str)) {
                        if ([str isEqualToString: subModel.title]) {
                            subModel.isSelected = YES;
                        }
                    }
                }
            }
           
            if (ISNILSTR(str)) {
                if ([str isEqualToString: model.title]) {
                    model.isSelected = YES;
                }
            }
            [infoArr addObject:model];
        }
    }
    return infoArr;

}

- (NSComparisonResult)compare:(NSDictionary *)stu
{
    NSComparisonResult result;
    if ([self isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)self;
        NSString *str1  = dic[@"tb_weight"];
        NSString *str2  = stu[@"tb_weight"];
        if([str1 integerValue] > [str2 integerValue])
        {
            result = NSOrderedDescending;
            
        }else if ([str1 integerValue] == [str2 integerValue])
        {
         result = NSOrderedSame;
        }else
        {
          result = NSOrderedAscending;
        }
    }    
    return result;
}

//转化时间
+(NSString *)getDetailTime:(NSString *)str
{
    if (ISNOTNILSTR(str)) {
        NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
        NSString *timeStr = [dateFormatter stringFromDate: detaildate];
        return timeStr;
        
    }else
    {
        return @"至今";
    }

}

+(NSString *)getTime:(NSString *)str
{
    if (ISNOTNILSTR(str)) {
        NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *timeStr = [dateFormatter stringFromDate: detaildate];
        return timeStr;

    }else
    {
    return @"至今";
    }
    
}

+(NSMutableArray *)getBasemodel:(NSArray *)titles define:(NSString *)str
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *str1 in titles) {
        LSBaseModel *model = [[LSBaseModel alloc] init];
        model.title = str1;
        if (str) {
            if ([str isEqualToString:str1]) {
                model.isSelected = YES;
            }
        }
        [arr addObject:model];
    }
    return arr;
}
@end

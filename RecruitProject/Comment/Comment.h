//
//  Comment.h
//  ShoppingProject
//
//  Created by admin on 15/5/5.
//  Copyright (c) 2015年 GuanYisoft. All rights reserved.
//

//------------------ Comment------------------
#define UMAPPKEY           @"5629992a67e58ef6500034d6"
#define QQAPPKEY           @"1104848804"               //  41DAA7A4
#define QQAPPSECORT        @"mbPImkSZtGCZnGSD"
#define WXAPPKEY           @"wxbbfec5e645d23b4a"       //  41DAA7A4
#define WXAPPSECORT        @"dee43453fa18a616e69c91fe8b48401d"


#define LSNumber_Message          30                //轮询时间
//保存数据Key


#define LSSAVE_USERNAME       @"LSSAVE_USERNAME"      //保存用户名
#define LSSAVE_USERPASSWORD   @"LSSAVE_USERPASSWORD"  //保存密码
#define LSSAVE_dictInfo       @"LSSAVE_dictInfo"      //保存信息字典(数组)
#define LSSAVE_Info_dic       @"LSSAVE_Info_dic"      //保存信息字典字典）
#define LSSAVE_tip_personal   @"LSSAVE_tip_personal"  //保存信息字典字典）

//通知
#define LSNotification_MessageNum   @"LSNotification_MessageNum"  //消息通知


//------------------ Color ------------------
#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define HEXCOLOR(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]                                //16进制color 使用方法：HEXCOLOR(0xffffff)

#define color_main              RGBCOLOR(179, 30, 58)         //主色调
#define color_bg                RGBCOLOR(245, 245, 245)       //背景颜色
#define color_title_main        RGBCOLOR(204, 59, 80)         //字体颜色
#define color_title_Gray        RGBCOLOR(117, 117, 117)       //字体颜色浅灰
#define color_title_Gray_1      RGBCOLOR(134, 134, 134)       //字体颜色浅灰
#define color_title_yellow      RGBCOLOR(193, 119, 92)        //字体颜色橘黄
#define color_bg_yellow         RGBCOLOR(246, 89, 0)          //橘黄s色背景

#define color_listBG            RGBCOLOR(85, 85, 85)          //主色调
#define color_BtnBG             RGBCOLOR(149, 220, 242)       //登录按钮背景
#define color_white             [UIColor whiteColor]           //白色
#define color_clear             [UIColor clearColor]           //无色
#define color_black             [UIColor blackColor]           //黑色


#define color_line              HEXCOLOR(0xd9d9d9)             //分割线灰色 宽度
#define COLORE_BgGray           HEXCOLOR(0xf7f7f7)             //背景灰色
#define COLORE_red              HEXCOLOR(0xff0000)             //提示红点



//
//------------------ Url ------------------
//
#define  URL_Base                     @"http://api.rongyp.com/"
#define  URL_Login                    @"c=member&a=checkLogin"           //登录接口
#define  URL_sendSMS                  @"c=member&a=sendSMS"              //短信验证
#define  URL_add                      @"c=member&a=add"                  //用户注册




//
//------------------ Image ------------------
//
#define IMAGE(img)  [UIImage  imageNamed:img]






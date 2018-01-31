//
//  GovDatasHeader.h
//  GovData
//
//  Created by 朱来飞 on 2018/1/3.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#ifndef LabourServiceHeader_h
#define LabourServiceHeader_h


#pragma mark -
#pragma mark --  System Definition

#define kWindow          [UIApplication sharedApplication].keyWindow
#define kScale           [UIScreen mainScreen].scale
#define kScreenH         [UIScreen mainScreen].bounds.size.height
#define kScreenW         [UIScreen mainScreen].bounds.size.width
#define kNavigationBarH  self.navigationController.navigationBar.frame.size.height
#define kStatusBarH      [[UIApplication sharedApplication] statusBarFrame].size.height
#define kScrTopMarginH   (kNavigationBarH + kStatusBarH)
#define kTabBarH          self.tabBarController.tabBar.bounds.size.height

//高德地图
#define AmapKey @"6e2b6456779c52bfb63f62f012a1147f"
// font
#define Font_12 [UIFont systemFontOfSize:12]
#define Font_13 [UIFont systemFontOfSize:13]
#define Font_14 [UIFont systemFontOfSize:14]
#define Font_15 [UIFont systemFontOfSize:15]
#define Font_16 [UIFont systemFontOfSize:16]
#define Font_17 [UIFont systemFontOfSize:17]
#define Font_18 [UIFont systemFontOfSize:18]

// color
#define UIColor_0x007ed3  UIColorHex(0x007ed3)
#define UIColor_666666  UIColorHex(0x666666)
#define UIColor_999999 UIColorHex(0x999999)
#define UIColor_f3f3f3 UIColorHex(0xf3f3f3)
#define UIColor_333333 UIColorHex(0x333333)
#define UIColor_66b2e4 UIColorHex(0x66b2e4)
#define UIColor_d7d7d7 UIColorHex(0xd7d7d7)
//notification
#define NOTICE_TO_LOGIN   @"NOTICE_TO_LOGIN"
#define NOTICE_LOGIN_SUCCESS @"NOTICE_LOGIN_SUCCESS"
#define NOTICE_LOGIN_OUT   @"NOTICE_LOGIN_OUT"
#define NOTICE_UPDATE_USER_INFO @"NOTICE_UPDATE_USER_INFO"

#endif /* GovDatasHeader_h */

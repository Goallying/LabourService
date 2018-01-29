//
//  AppDelegate+Extension.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/16.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "AppDelegate+Extension.h"
#import <objc/runtime.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

static void * MGRKey  = @"MGRKey";

@interface AppDelegate ()<AMapLocationManagerDelegate>

@property  (nonatomic,strong)AMapLocationManager * locactionManager   ;
@end
@implementation AppDelegate (Extension)

- (void)userLoactionNotifier {
    
    [AMapServices sharedServices].apiKey = AmapKey;
    self.locactionManager = [[AMapLocationManager alloc] init];
    self.locactionManager.delegate = self;
    self.locactionManager.distanceFilter = 200;
    self.locactionManager.locatingWithReGeocode = YES ;
    [self.locactionManager startUpdatingLocation];
}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    
    static BOOL everSucceed = NO ;
    User_Info.formattedAddress = reGeocode.formattedAddress;
    User_Info.province = reGeocode.province ;
    User_Info.city = reGeocode.city;
    User_Info.adcode = reGeocode.adcode;
    
    User_Info.lat = location.coordinate.latitude;
    User_Info.lon = location.coordinate.longitude;
  
    if (everSucceed == NO && User_Info.city && User_Info.adcode && User_Info.province && User_Info.formattedAddress) {
        //之前没有成功过，通知刷新页面，因为页面加载完可能定位信息还没有。退出程序无需保存定位信息，因为下次进入会重新定位
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_UPDATE_USER_INFO object:nil];
        everSucceed = YES ;
    }
}

- (void)setLocactionManager:(AMapLocationManager *)locactionManager{
    objc_setAssociatedObject(self, MGRKey, locactionManager, OBJC_ASSOCIATION_RETAIN);
}
- (AMapLocationManager *)locactionManager{
    return objc_getAssociatedObject(self, MGRKey);
}
@end

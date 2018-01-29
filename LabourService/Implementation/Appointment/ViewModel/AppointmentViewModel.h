//
//  AppointmentViewModel.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/17.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseViewModel.h"
#import "SearchListModel.h"
#import "BannerModel.h"
#import "Cash.h"
@interface AppointmentViewModel : BaseViewModel

//获取项目金额
+ (void)getProjectCash:(NSString *)token
            success:(void(^)(NSString * msg ,Cash * cash))success
            failure:(void(^)(NSString * msg ,NSInteger code))failure;
// 项目预约banner
+ (void)getAppointmentBanner:(NSString *)province
                success:(void (^)(NSString * msg, NSArray * banners ,NSArray * imageURLs))success failure:(void (^)(NSString * msg, NSInteger code))failure;
//项目预约列表
+ (void)getAppointmentList:(NSInteger)page
             parentid:(NSString *)parentid
            parameter:(NSString *)parameter
              success:(void(^)(NSString * msg ,NSArray * projects))success
              failure:(void(^)(NSString * msg ,NSInteger code))failure;
@end

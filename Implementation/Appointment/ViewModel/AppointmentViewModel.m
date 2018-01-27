//
//  AppointmentViewModel.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/17.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "AppointmentViewModel.h"

@implementation AppointmentViewModel

+ (void)getProjectCash:(NSString *)token
               success:(void(^)(NSString * msg ,Cash * cash))success
               failure:(void(^)(NSString * msg ,NSInteger code))failure{
    [ReqManager POST_URLString:@"BaseDictionary/getProAmount" headerParamter:token parameters:nil showIndicatior:YES success:^(id obj) {
        Cash * cash = [Cash yy_modelWithJSON:obj[@"result"]];
        success(obj[@"message"],cash);
    } failure:^(NSError *error) {
        failure(error.domain,error.code);
    }] ;
}
+ (void)getAppointmentBanner:(NSString *)province
                     success:(void (^)(NSString * msg, NSArray * banners ,NSArray * imageURLs))success failure:(void (^)(NSString * msg, NSInteger code))failure{
    
    NSDictionary * dic = @{@"provincesBelong":province};
    [ReqManager POST_URLString:@"AdConfig/getProjectAd" parameters:dic showIndicatior:YES success:^(id obj) {
        NSArray * banners = [NSArray yy_modelArrayWithClass:[BannerModel class] json:obj[@"result"]];
        NSMutableArray * urls = [NSMutableArray array];
        for (BannerModel * m in banners) {
            [urls addObject:m.imageUrl];
        }
        success(obj[@"message"],banners,urls);
    } failure:^(NSError *error) {
        failure(error.domain,error.code);
    }];
}
+ (void)getAppointmentList:(NSInteger)page
                  parentid:(NSString *)parentid
                 parameter:(NSString *)parameter
                   success:(void(^)(NSString * msg ,NSArray * projects))success
                   failure:(void(^)(NSString * msg ,NSInteger code))failure{
    
    NSDictionary * dic = @{@"page":[NSString stringWithFormat:@"%lu",page],
                           @"limit":@"20",
                           @"parentid":parentid,
                           @"parameter":parameter
                           };
    [ReqManager POST_URLString:@"BusProject/sProject" parameters:dic showIndicatior:YES success:^(id obj) {
        NSArray * people = [NSArray yy_modelArrayWithClass:[SearchListModel class] json:obj[@"result"]];
        success(obj[@"message"],people);
    } failure:^(NSError *error) {
        failure(error.domain,error.code);
    }];
}
@end

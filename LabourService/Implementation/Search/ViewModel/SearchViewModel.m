//
//  SearchViewModel.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/16.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "SearchViewModel.h"
#import "SearchListModel.h"
@implementation SearchViewModel

+ (void)contact:(NSString *)token
            orderId:(NSString*)orderId
             sendId:(NSString*)sendId
        messageType:(NSInteger)messageType
            success:(void(^)(NSString * msg))success
            failure:(void(^)(NSString * msg ,NSInteger code))failure{
    
    NSDictionary * dic = @{@"orderId":orderId,
                           @"sendeeId":sendId,
                           @"messageType":@(messageType),
                           };
    [ReqManager POST_URLString:@"SysMessage/sendMessage" headerParamter:token parameters:dic showIndicatior:YES success:^(id obj) {
        success(obj[@"message"]);
    } failure:^(NSError *error) {
        failure(error.domain,error.code);
    }];
    
}
+ (void)getFeeSuccess:(void(^)(NSString * msg ,Cash * cash))success
              failure:(void(^)(NSString * msg ,NSInteger code))failure{
    
    [ReqManager GET_URLString:@"BaseDictionary/getAmount" parameters:nil showIndicatior:YES success:^(id obj) {
        Cash * cash = [Cash yy_modelWithJSON:obj[@"result"]];
        success(obj[@"message"],cash);
    } failure:^(NSError *error) {
        failure(error.domain,error.code);
    }] ;
}
+ (void)getSearchBanner:(NSString *)province success:(void (^)(NSString *, NSArray *, NSArray *))success failure:(void (^)(NSString *, NSInteger))failure{
    
    NSDictionary * dic = @{@"provincesBelong":province};
    [ReqManager POST_URLString:@"AdConfig/getPersonAd" parameters:dic showIndicatior:YES success:^(id obj) {
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
+ (void)getSearchList:(NSInteger)page
             parentid:(NSString *)parentid
            parameter:(NSString *)parameter
              success:(void(^)(NSString * msg ,NSArray * peoples))success
              failure:(void(^)(NSString * msg ,NSInteger code))failure{
    
    NSDictionary * dic = @{@"page":[NSString stringWithFormat:@"%lu",page],
                           @"limit":@"20",
                           @"parentid":parentid,
                           @"parameter":parameter
                           };
    [ReqManager POST_URLString:@"PersonInfo/sPersonInfo" parameters:dic showIndicatior:YES success:^(id obj) {
        NSArray * people = [NSArray yy_modelArrayWithClass:[SearchListModel class] json:obj[@"result"]];
        success(obj[@"message"],people);
    } failure:^(NSError *error) {
        failure(error.domain,error.code);
    }];

}
@end

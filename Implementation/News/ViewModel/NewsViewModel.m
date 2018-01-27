//
//  MainViewModel.m
//  GovData
//
//  Created by 朱来飞 on 2018/1/3.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "NewsViewModel.h"

@implementation NewsViewModel

+ (void)getNewsBannerSuccess:(void (^)(NSString *, NSArray *, NSArray *))success failure:(void (^)(NSString *, NSInteger))failure {
    
    [ReqManager GET_URLString:@"AdConfig/getPageAd" parameters:nil showIndicatior:YES success:^(id obj) {
        NSArray * banners = [NSArray yy_modelArrayWithClass:[BannerModel class] json:obj[@"result"]];
        NSMutableArray * urls = [NSMutableArray array];
        for (BannerModel * m in banners) {
            [urls addObject:m.imageUrl];
        }
        success(obj[@"message"],banners,urls);
    } failure:^(NSError *error) {
        failure(error.domain ,error.code);
    }];
}

+ (void)getNewsList:(NSInteger)page type:(NSInteger)type success:(void (^)(NSString *, NSArray *))success failure:(void (^)(NSString *, NSInteger))failure{
    NSDictionary * dic = @{@"page":@(page),
                           @"limit":@(20),
                           @"type":@(type)
                           };
    [ReqManager POST_URLString:@"NewsInfo/pageList" parameters:dic showIndicatior:YES success:^(id obj) {
        NSArray * news = [NSArray yy_modelArrayWithClass:[NewsModel class] json:obj[@"result"]];
        success(obj[@"message"],news);
    } failure:^(NSError *error) {
        failure(error.domain ,error.code);
    }];
}

+ (void)getNewsTypesSuccess:(void (^)(NSString *, NSArray *))success failure:(void (^)(NSString *, NSInteger))failure{
    
    [ReqManager GET_URLString:@"NewsType/select" parameters:nil showIndicatior:YES success:^(id obj) {
        
        NSArray * datas = [NSArray yy_modelArrayWithClass:[NewsTypeModel class] json:obj[@"result"]];
        success(obj[@"message"],datas);
        
    } failure:^(NSError *error) {
        failure(error.domain ,error.code);
    }];
}
@end

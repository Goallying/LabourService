//
//  SearchViewModel.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/16.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseViewModel.h"
#import "BannerModel.h"
#import "Cash.h"
@interface SearchViewModel : BaseViewModel

//messageType  （数值类型, 1.人才联系 2.项目联系）
+ (void)contact:(NSString *)token
            orderId:(NSString*)orderId
             sendId:(NSString*)sendId
       messageType:(NSInteger)messageType
            success:(void(^)(NSString * msg))success
            failure:(void(^)(NSString * msg ,NSInteger code))failure; 
//获取用户金额
+ (void)getUserCash:(NSString *)token
            success:(void(^)(NSString * msg ,Cash * cash))success
            failure:(void(^)(NSString * msg ,NSInteger code))failure;
//人才搜索页面Banner
+ (void)getSearchBanner:(NSString *)province
                success:(void (^)(NSString * msg, NSArray * banners ,NSArray * imageURLs))success failure:(void (^)(NSString * msg, NSInteger code))failure;
//人才列表
+ (void)getSearchList:(NSInteger)page
             parentid:(NSString *)parentid
            parameter:(NSString *)parameter
              success:(void(^)(NSString * msg ,NSArray * peoples))success
              failure:(void(^)(NSString * msg ,NSInteger code))failure;

@end

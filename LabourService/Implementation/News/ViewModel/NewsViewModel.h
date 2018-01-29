//
//  MainViewModel.h
//  GovData
//
//  Created by 朱来飞 on 2018/1/3.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseViewModel.h"
#import "NewsModel.h"
#import "NewsTypeModel.h"
#import "BannerModel.h"
@interface NewsViewModel : BaseViewModel
//获取新闻banner
+ (void)getNewsBannerSuccess:(void (^)(NSString * msg, NSArray * banners ,NSArray * imageURLs))success failure:(void (^)(NSString * msg, NSInteger code))failure ;
//新闻类型
+ (void)getNewsTypesSuccess:(void(^)(NSString * msg ,NSArray * types))success failure:(void(^)(NSString * msg ,NSInteger code))failure;
//新闻列表
+ (void)getNewsList:(NSInteger)page
               type:(NSInteger)type
            success:(void(^)(NSString * msg ,NSArray * news))success
            failure:(void(^)(NSString * msg ,NSInteger code))failure;
@end

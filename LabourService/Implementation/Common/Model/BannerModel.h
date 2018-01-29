//
//  BannerModel.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/17.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseModel.h"

//多个页面公用的bannerModel，放在common中。
@interface BannerModel : BaseModel
//首页banner 1，人才发布2，项目预约3
@property (nonatomic ,assign)NSInteger pageType ;
//banner 是否启用
@property (nonatomic ,copy)NSString * enableType ;
// 图片路径
@property (nonatomic ,copy)NSString * imageUrl ;
//备注
@property (nonatomic ,copy)NSString * remark ;
@property (nonatomic ,copy)NSString * ID ;
//标题
@property (nonatomic ,copy)NSString * title ;
//0 可点击 ,1 不可点击
@property (nonatomic ,copy)NSString * imageType ;
//跳转的url
@property (nonatomic ,copy)NSString * jumpUrl ;
@property (nonatomic ,copy)NSString * createDate ;

@end

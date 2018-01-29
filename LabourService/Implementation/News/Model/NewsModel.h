//
//  NewsModel.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/15.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseModel.h"
typedef NS_ENUM(NSInteger ,NewsType){
    NewsType_Picture_Article = 1,
    NewsType_Video = 2,
    NewsType_Advertisement = 3
};


@interface File : BaseModel
//图片地址(String)
@property (nonatomic ,copy)NSString * url ;
@end

@interface NewsModel : BaseModel
//广告跳转地址(String)
@property (nonatomic ,copy)NSString *advertUrl ;
//图片数量(int)
@property (nonatomic ,assign)NSInteger fileSize ;
//新闻类别 1：图文 2:视频 3：广告(int)
@property (nonatomic ,assign)NSInteger lb ;
//新闻来源(String)
@property (nonatomic ,copy)NSString *bySource ;
//新闻资讯主键ID(int)
@property (nonatomic ,assign)NSInteger ID ;
//新闻标题(String)
@property (nonatomic ,copy)NSString *title ;
//广告类型：1:图文、视频 2:第三方H5地址(int)
@property (nonatomic ,assign)NSInteger advertType ;
//图片集合(Array)
@property (nonatomic ,strong)NSArray <File *> * fileList ;
@end

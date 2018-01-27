//
//  UserInfo.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/15.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseModel.h"
#import "WorkKind.h"

@interface UserInfo : BaseModel <NSCoding>

//{
//    message = "\U767b\U5f55\U6210\U529f";
//    result =     {
//        age = "<null>";
//        createTime = "2018-01-15 15:30:43";
//        gender = "<null>";
//        headUrl = "http://106.14.157.223:8080/downFile/BaseDictionary/2018-01-09/3b648b08914840e68f126bfda8a43f931515478322058.png";
//        ifPerfect = 0;
//        realName = "<null>";
//        thumbs = 0;
//        token = 93b739f9e8a018926ba48fc8a81d674a;
//        userName = 13063481502;
//        workList =         (
//        );
//    };
//    status = 200;
//    total = 1;
//}
@property (nonatomic ,strong)NSArray<WorkKind *> * workList ;
@property (nonatomic ,copy)NSString * realName ;// 昵称
@property (nonatomic ,assign)NSInteger gender ;
@property (nonatomic ,copy)NSString * createTime ;
@property (nonatomic ,copy)NSString * headUrl ;
@property (nonatomic ,assign)NSInteger  ifPerfect ;
@property (nonatomic ,copy)NSString * userName ;
@property (nonatomic ,assign)NSInteger age ;
@property (nonatomic ,assign)NSInteger thumbs ;
@property (nonatomic ,copy)NSString * token ;


@property (nonatomic, copy) NSString *formattedAddress;
@property (nonatomic ,copy) NSString * province ;
@property (nonatomic ,copy) NSString * city ;
@property (nonatomic, copy) NSString * adcode;
@property (nonatomic ,assign)double lat  ;
@property (nonatomic ,assign)double lon ;

@property (nonatomic ,copy ,readonly)NSString * deviceNo ;

@end

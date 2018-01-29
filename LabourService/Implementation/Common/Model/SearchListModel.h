//
//  SearchListModel.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/16.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseModel.h"
//{
//    address = "\U5b89\U5fbd\U7701\U5408\U80a5\U5e02\U8700\U5c71\U533a\U6de0\U6cb3\U8def126\U53f7\U9760\U8fd1\U5b89\U5fbd\U7701\U8f7b\U5de5\U79d1\U5b66\U6280\U672f\U7814\U7a76\U6240";
//    age = 28;
//    createDate = "2018-01-13 01:43:29";
//    gender = 1;
//    headUrl = "http://106.14.157.223:8080/downFile//ueditor/image/20171230/1514626624507035669.jpg";
//    id = c846f3e7ac1a44ce8c7ea0108eb25363;
//    introduce = "\U5927\U5bb6\U6211\U662f\U5c0f\U9f99";
//    realName =             (
//                            {
//                                realname = "\U6db2\U5316\U77f3\U6cb9\U6c14\U673a\U68b0\U4fee\U7406\U5de5";
//                            },
@interface SearchListModel : BaseModel
@property (nonatomic ,strong)NSArray * realName ;
@property (nonatomic ,copy)NSString *address ;
@property (nonatomic ,assign)NSInteger gender ;
@property (nonatomic ,copy)NSString *introduce ;
@property (nonatomic ,copy)NSString *headUrl ;
@property (nonatomic ,copy)NSString *tel ;
@property (nonatomic ,copy)NSString *ID ;
@property (nonatomic ,copy)NSString *title ;
@property (nonatomic ,copy)NSString *userName ;
@property (nonatomic ,copy)NSString *userId ;
@property (nonatomic ,assign)NSInteger age ;
@property (nonatomic ,copy)NSString *createDate ;

//@property (nonatomic ,assign ,readonly)CGFloat searchTagsHeight ;
//@property (nonatomic ,assign ,readonly)CGFloat appointmentTagsHeight ;

@end

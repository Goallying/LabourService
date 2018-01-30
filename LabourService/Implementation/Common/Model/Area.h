//
//  Area.h
//  YYKitDemo
//
//  Created by 朱来飞 on 2018/1/30.
//  Copyright © 2018年 ibireme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Area : NSObject
@property (nonatomic ,copy)NSString * depict ;
@property (nonatomic ,copy)NSString * areaname ;
@property (nonatomic ,assign)NSInteger level ;
@property (nonatomic ,strong)NSArray<Area *> *childrenList ;
@property (nonatomic ,copy)NSString * ID ;
@property (nonatomic ,copy)NSString * parentId ;
@end

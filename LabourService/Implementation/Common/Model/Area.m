//
//  Area.m
//  YYKitDemo
//
//  Created by 朱来飞 on 2018/1/30.
//  Copyright © 2018年 ibireme. All rights reserved.
//

#import "Area.h"
#import "NSObject+YYModel.h"
@implementation Area

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id",};
}
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"childrenList":Area.class};
}
@end

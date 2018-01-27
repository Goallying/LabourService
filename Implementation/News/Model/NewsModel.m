//
//  NewsModel.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/15.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "NewsModel.h"

@implementation File


@end

@implementation NewsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{@"ID":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{@"fileList":File.class};
}
@end

//
//  NewsTypeModel.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/22.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "NewsTypeModel.h"

@implementation NewsTypeModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [self yy_modelEncodeWithCoder:aCoder];
}

@end

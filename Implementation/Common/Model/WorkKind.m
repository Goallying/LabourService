//
//  WorkKind.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/23.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "WorkKind.h"

@implementation WorkKind

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{@"ID":@"id"};
}
+ (NSArray *)modelPropertyBlacklist{
    return @[@"subKinds",@"selected"];
}

- (NSMutableArray<WorkKind *> *)subKinds{
    if (!_subKinds) {
        _subKinds = [NSMutableArray array];
    }
    return _subKinds ;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [self yy_modelEncodeWithCoder:aCoder];
}
@end

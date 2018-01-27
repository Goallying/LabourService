//
//  UserInfo.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/15.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+ (NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{@"workList":WorkKind.class};
}
+ (NSArray *)modelPropertyBlacklist{
    return @[@"province",@"formattedAddress",@"city",@"adcode",@"lat",@"lon",@"deviceNo"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [self yy_modelEncodeWithCoder:aCoder]; 
}

- (NSString *)deviceNo {
    return  [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

@end







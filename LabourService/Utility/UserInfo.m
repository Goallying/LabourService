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

//默认值
- (NSString *)formattedAddress{
    if (!_formattedAddress) {
        return @"安徽省合肥市蜀山区聚云路靠近白天鹅国际商务中心";
    }
    return _formattedAddress ;
}
- (NSString *)province{
    if (!_province) {
        _province = @"安徽省";
    }
    return _province ;
}
- (NSString *)city{
    if (!_city) {
        _city = @"合肥";
    }
    return _city ;
}
- (NSString *)adcode{
    if (!_adcode) {
        _adcode = @"340104";
    }
    return _adcode ;
}

@end







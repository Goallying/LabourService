//
//  PressViewModel.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/23.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "PressViewModel.h"
@implementation PressViewModel

+ (void)pressProjectToken:(NSString *)token name:(NSString *)name tel:(NSString *)tel title:(NSString *)title intro:(NSString *)intro addr:(NSString *)addr addrID:(NSString *)addrID kinds:(NSArray *)kinds success:(void (^)(NSString *))success failure:(void (^)(NSString *, NSInteger))failure{
    
    NSMutableArray * kindsID = [NSMutableArray array];
    NSString * content = @"因项目需要现招聘";
    for (WorkKind  * k in kinds) {
        [kindsID addObject:[NSString stringWithFormat:@"%ld",(long)k.ID]];
      content = [content stringByAppendingFormat:@"%@%ld人、",k.realName,k.kindCount];
    }
    content =  [content substringToIndex:[content length] - 1];
    NSString * joins = [kindsID componentsJoinedByString:@","];
    NSDictionary * dic = @{@"introduce":intro,
                           @"userName":name ,
                           @"tel":tel ,
                           @"address":addr,
                           @"parentid":addrID,
                           @"personTypeId":joins,
                           @"title":title,
                           @"content":content
                           };
    
    [ReqManager POST_URLString:@"BusProject/iProject" headerParamter:token parameters:dic showIndicatior:YES success:^(id obj) {
        success(obj[@"message"]);
    } failure:^(NSError *error) {
        failure(error.domain,error.code);
    }];
    
}
+ (void)pressPersonToken:(NSString *)token intro:(NSString *)intro addr:(NSString *)addr addrID:(NSString *)addrID kinds:(NSArray *)kinds success:(void (^)(NSString *))success failure:(void (^)(NSString *, NSInteger))failure{
    
    NSMutableArray * kindsID = [NSMutableArray array];
    for (WorkKind  * k in kinds) {
        [kindsID addObject:[NSString stringWithFormat:@"%ld",(long)k.ID]];
    }
    NSString * joins = [kindsID componentsJoinedByString:@","];
    NSDictionary * dic = @{@"introduce":intro,
                           @"address":addr,
                           @"parentid":addrID,
                           @"personTypeId":joins
                           };
    [ReqManager POST_URLString:@"PersonInfo/iPersonInfo" headerParamter:token parameters:dic showIndicatior:YES success:^(id obj) {
        success(obj[@"message"]);
    } failure:^(NSError *error) {
        failure(error.domain ,error.code);
    }];
}

+ (void)getworkKindsListSuccess:(void (^)(NSString *, NSArray *))success failure:(void (^)(NSString *, NSInteger))failure{
    
    [ReqManager GET_URLString:@"PersonType/select" parameters:nil showIndicatior:YES success:^(id obj) {
        
        NSArray * array = [NSArray yy_modelArrayWithClass:[WorkKind class] json:obj[@"result"]];
        NSMutableArray * fatherKinds = [NSMutableArray array];
        NSMutableArray * sonKinds = [NSMutableArray array];
        for (WorkKind * k in array) {
            if (k.pid == 0) {
                [fatherKinds addObject:k];
            }else{
                [sonKinds addObject:k];
            }
        }
        for (WorkKind * k in fatherKinds) {
            for (WorkKind * sk in sonKinds) {
                if (sk.pid == k.ID) {
                    [k.subKinds addObject:sk];
                }
            }
        }
        success(obj[@"message"],fatherKinds);
    } failure:^(NSError *error) {
        failure(error.domain ,error.code);
    }];
}
@end

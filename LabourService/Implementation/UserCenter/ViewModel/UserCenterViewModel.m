//
//  UserCenterViewModel.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/15.
//  Copyright © 2018年 朱来飞. All rights reserved.
//
#import "UserCenterViewModel.h"
#import "WorkKind.h"
@implementation UserCenterViewModel

+ (void)deletePress:(NSString *)token
         deleteType:(NSInteger)type
            pressID:(NSString *)ID
            success:(void(^)(NSString * msg))success
            failure:(void(^)(NSString * msg ,NSInteger code))failure{
    
    NSDictionary * dic = @{@"id":ID};
    
    NSString * url = type == 1?@"PersonInfo/dPersonInfo":@"BusProject/dProject";
    [ReqManager POST_URLString:url headerParamter:token parameters:dic showIndicatior:YES success:^(id obj) {
        success(obj[@"message"]);
    } failure:^(NSError *error) {
        failure(error.domain,error.code);
    }];
}
+ (void)getUserPressPage:(NSInteger)page
               pressType:(NSInteger)type
                 success:(void(^)(NSString * msg ,NSArray * pressRecords))success
                 failure:(void(^)(NSString * msg ,NSInteger code))failure{
    
    
    NSDictionary * dic = @{@"page":[NSString stringWithFormat:@"%ld",page],
                           @"limit":@"20",
                           };
    NSString * url = nil;
    if (type == 1) {
        url = @"PersonInfo/sPerson";
    }else{
        url = @"BusProject/sPerson";
    }
    [ReqManager POST_URLString:url parameters:dic showIndicatior:YES success:^(id obj) {
        NSArray * records = [NSArray yy_modelArrayWithClass:[SearchListModel class] json:obj[@"result"]];
        success(obj[@"message"],records);
    } failure:^(NSError *error) {
        failure(error.domain ,error.code);
    }];
}
+ (void)getUserMessage:(NSString *)token page:(NSInteger)page status:(NSInteger)status success:(void (^)(NSString *, NSArray *))success failure:(void (^)(NSString *, NSInteger))failure{
    
    NSDictionary * dic = @{@"page":[NSString stringWithFormat:@"%ld",page],
                           @"limit":@"20",
                           @"messageStatus":[NSString stringWithFormat:@"%ld",status]
                           };
    [ReqManager POST_URLString:@"SysMessage/personMessage" headerParamter:token parameters:dic showIndicatior:YES success:^(id obj) {
        NSArray * messages = [NSArray yy_modelArrayWithClass:[MessageModel class] json:obj[@"result"]];
        success(obj[@"message"], messages);
        
    } failure:^(NSError *error) {
        failure(error.domain ,error.code);
    }] ;
}
+ (void)updateUserInfo:(NSString *)token
                header:(UIImage *)header
                  name:(NSString *)name
                gender:(NSString *)gender
                   age:(NSString *)age
                 kinds:(NSArray *)kinds
               success:(void(^)(NSString * msg ,id obj))success
               failure:(void(^)(NSString * msg ,NSInteger code))failure{
    
    NSMutableArray * ks = [NSMutableArray array];
    for (WorkKind * k in kinds) {
        [ks addObject:[NSString stringWithFormat:@"%ld",(long)k.ID]];
    }
    NSString * s = [ks componentsJoinedByString:@","];
    NSInteger sex = [gender isEqualToString:@"男"]?1:2 ;
    
    NSData * data = UIImagePNGRepresentation(header);
    NSString * dataS = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary * dic = @{@"realName":[NSString stringWithFormat:@"%@",name],
                           @"gender":@(sex),
                           @"age":@([age integerValue]),
                           @"personTypeId":s,
                           @"picture":dataS?dataS:@""
                           };
    [ReqManager POST_URLString:@"MemberUser/perfectInformation" headerParamter:token parameters:dic showIndicatior:YES success:^(id obj) {
            success(obj[@"message"],obj[@"result"]);
    } failure:^(NSError *error) {
                failure(error.domain,error.code);

    }];
}

+ (void)getCityList:(NSString *)code success:(void (^)(NSString *, NSArray *))success failure:(void (^)(NSString *, NSInteger))failure{
    
    NSDictionary * dic = @{@"code":code};
    [ReqManager POST_URLString:@"SysArea/select" parameters:dic showIndicatior:YES success:^(id obj) {
        NSArray * array = [NSArray yy_modelArrayWithClass:[CityModel class] json:obj[@"result"]];
        success(obj[@"message"] ,array);
    } failure:^(NSError *error) {
        failure(error.domain,error.code);
    }];
}
+ (void)getUserInfo:(NSString *)token
            success:(void(^)(NSString * msg, NSString * balance,BOOL ifPerfect,NSInteger thumbs ,NSString * messageCount))success
            failure:(void(^)(NSString * msg ,NSInteger code))failure{
    [ReqManager POST_URLString:@"MemberUser/queryMyData" headerParamter:token parameters:nil showIndicatior:YES success:^(id obj) {
        success(obj[@"message"],nonullString(obj[@"result"][@"balance"]),[obj[@"result"][@"ifPerfect"] boolValue],[obj[@"result"][@"thumbs"] integerValue],nonullString(obj[@"result"][@"messageCount"]));
    } failure:^(NSError *error) {
        failure(error.domain,error.code);
    }];
}

+ (void)loginOut:(NSString *)token success:(void (^)(NSString *))success failure:(void (^)(NSString *, NSInteger))failure{
    
    [ReqManager POST_URLString:@"LoginApi/loginOut" headerParamter:token parameters:nil showIndicatior:YES success:^(id obj) {
        success(obj[@"message"]);
    } failure:^(NSError *error) {
        failure(error.domain ,error.code);
    }];
}

+ (void)resetPswName:(NSString *)name psw:(NSString *)psw success:(void (^)(NSString *))success failure:(void (^)(NSString *, NSInteger))failure{
    
    NSDictionary * dic = @{@"userName":name,
                           @"passWord":psw
                           };
    [ReqManager POST_URLString:@"LoginApi/resetPwd" parameters:dic showIndicatior:YES success:^(id obj) {
        success(obj[@"message"]);
    } failure:^(NSError *error) {
        failure(error.domain,error.code);
    }];
}

+ (void)login:(NSString *)name psw:(NSString *)psw success:(void (^)(NSString *, id))success failure:(void (^)(NSString *, NSInteger))failure{
    
    NSDictionary * dic = @{@"userName":name,
                           @"passWord":psw,
                           @"deviceNo":User_Info.deviceNo,
                           @"platf":@"IOS"
                           };
    [ReqManager POST_URLString:@"LoginApi/login" parameters:dic showIndicatior:YES success:^(id obj) {
        success(obj[@"message"] ,obj[@"result"]);
    } failure:^(NSError *error) {
        failure(error.domain ,error.code);
    }];
}
+(void)getCode:(NSString *)phoneNum
          type:(NSInteger)type
       success:(void (^)(NSString *, NSString *))success
       failure:(void (^)(NSString *, NSInteger))failure{
    
    NSDictionary * dic = @{@"userName":phoneNum,
                           @"type":[NSString stringWithFormat:@"%lu",type]
                           };
    [ReqManager POST_URLString:@"LoginApi/sendCode" parameters:dic showIndicatior:YES success:^(id obj) {
        success(obj[@"message"] ,obj[@"result"]);
    } failure:^(NSError *error) {
        failure(error.domain ,error.code);
    }];
}

+(void)registerName:(NSString *)name psw:(NSString *)psw inviteNo:(NSString *)inviteNo success:(void (^)(NSString *, id))success failure:(void (^)(NSString *, NSInteger))failure{
    
    NSDictionary * dic = @{@"userName":name,
                           @"passWord":psw,
                           @"deviceNo":User_Info.deviceNo,
                           @"platf":@"IOS",
                           @"invitationPhone":inviteNo?inviteNo:@""
                           };
    [ReqManager POST_URLString:@"LoginApi/memberRegister" parameters:dic showIndicatior:YES success:^(id obj) {
        success(obj[@"message"],obj[@"result"]);
    } failure:^(NSError *error) {
        failure(error.domain ,error.code);
    }];
}

@end

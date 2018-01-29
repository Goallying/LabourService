//
//  UserCenterViewModel.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/15.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseViewModel.h"
#import "CityModel.h"
#import "MessageModel.h"
@interface UserCenterViewModel : BaseViewModel
+ (void)getUserMessage:(NSString *)token
                  page:(NSInteger)page
                status:(NSInteger)status
               success:(void(^)(NSString * msg ,NSArray * message))success
               failure:(void(^)(NSString * msg ,NSInteger code))failure;

+ (void)updateUserInfo:(NSString *)token
                header:(UIImage *)header
                  name:(NSString *)name
                gender:(NSString *)gender
                   age:(NSString *)age
                 kinds:(NSArray *)kinds
               success:(void(^)(NSString * msg ,id obj))success
               failure:(void(^)(NSString * msg ,NSInteger code))failure;

+ (void)getCityList:(NSString *)code
            success:(void(^)(NSString * msg , NSArray * cities))success
            failure:(void(^)(NSString * msg ,NSInteger code))failure;
+ (void)getUserInfo:(NSString *)token
            success:(void(^)(NSString * msg, NSString * balance,BOOL ifPerfect,NSInteger thumbs ,NSString * messageCount))success
            failure:(void(^)(NSString * msg ,NSInteger code))failure;
//登出
+ (void)loginOut:(NSString *)token
         success:(void(^)(NSString * msg))success
         failure:(void(^)(NSString * msg ,NSInteger code))failure;
//重置密码
+ (void)resetPswName:(NSString *)name
                 psw:(NSString *)psw
             success:(void(^)(NSString * msg))success
             failure:(void(^)(NSString * msg ,NSInteger code))failure;
//获取验证码 1.注册 2.修改密码
+ (void)getCode:(NSString *)phoneNum
           type:(NSInteger)type
        success:(void(^)(NSString * msg ,NSString *code))success
        failure:(void(^)(NSString * msg ,NSInteger code))failure;
//注册
+ (void)registerName:(NSString *)name
                 psw:(NSString *)psw
            inviteNo:(NSString *)inviteNo
             success:(void(^)(NSString * msg ,id obj))success
             failure:(void(^)(NSString * msg ,NSInteger code))failure;

+ (void)login:(NSString *)name
          psw:(NSString *)psw
      success:(void(^)(NSString * msg , id obj))success
      failure:(void(^)(NSString * msg ,NSInteger code))failure;
@end

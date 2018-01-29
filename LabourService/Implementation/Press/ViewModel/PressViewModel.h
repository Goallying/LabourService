//
//  PressViewModel.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/23.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseViewModel.h"
#import "WorkKind.h"
@interface PressViewModel : BaseViewModel
+ (void)pressProjectToken:(NSString *)token
                     name:(NSString *)name
                      tel:(NSString *)tel
                    title:(NSString *)title
                   intro:(NSString *)intro
                    addr:(NSString *)addr
                  addrID:(NSString *)addrID
                   kinds:(NSArray *)kinds
                 success:(void(^)(NSString * msg))success
                 failure:(void(^)(NSString * msg ,NSInteger code))failure ;
+ (void)pressPersonToken:(NSString *)token
             intro:(NSString *)intro
              addr:(NSString *)addr
            addrID:(NSString *)addrID
             kinds:(NSArray *)kinds
           success:(void(^)(NSString * msg))success
           failure:(void(^)(NSString * msg ,NSInteger code))failure ;

+ (void)getworkKindsListSuccess:(void(^)(NSString * msg,NSArray * kinds))success
                        failure:(void(^)(NSString * msg ,NSInteger code))failure;
@end

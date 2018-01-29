//
//  ApplicationManager.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/15.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "ApplicationManager.h"

@implementation ApplicationManager

+(instancetype)manager{
    
    static ApplicationManager * _manager = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[ApplicationManager alloc]init];
    });
    return _manager ;
}
- (instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resaveInfo) name:NOTICE_UPDATE_USER_INFO object:nil];
    }
    return  self ;
}
- (void)resaveInfo{
    [self save];
}
- (UserInfo *)userInfo {
    if (!_userInfo) {
        NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo"];
        _userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    }
    if (!_userInfo) {
        _userInfo = [[UserInfo alloc]init];
    }
    return _userInfo ;
}
- (void)setUserNewsTypes:(NSArray *)userNewsTypes{
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"newsTypes"];
    [NSKeyedArchiver archiveRootObject:userNewsTypes toFile:file];
    
}
-(NSArray *)userNewsTypes{
    
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"newsTypes"];
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:file];

}
- (void)saveLocalUserInfo:(id)obj{
    
    NSString * createTime = User_Info.createTime ;
    NSString * token = User_Info.token ;
    NSString * userName = User_Info.userName;
    
    //修改用户信息，填空信息。
     _userInfo =  [UserInfo yy_modelWithJSON:obj];
    if (!_userInfo.createTime) {
        _userInfo.createTime = createTime ;
    }
    if (!_userInfo.token) {
        _userInfo.token = token ;
    }
    if (!_userInfo.userName) {
        _userInfo.userName = userName;
    }
    [self save];
}



- (void)save {
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo"];
    [NSKeyedArchiver archiveRootObject:_userInfo toFile:file];
}
@end

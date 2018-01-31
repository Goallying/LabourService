//
//  ApplicationManager.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/15.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

#ifndef AppManager
#define AppManager  [ApplicationManager manager]
#endif

#ifndef User_Info
#define User_Info    AppManager.userInfo
#endif

@interface ApplicationManager : NSObject

@property (nonatomic ,strong)UserInfo * userInfo ;
@property (nonatomic ,strong)NSArray * userNewsTypes ;
+ (instancetype)manager ;
- (void)saveLocalUserInfo:(id)obj ;
- (void)clearUserInfo ;
@end

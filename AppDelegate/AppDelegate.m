//
//  AppDelegate.m
//  GovData
//
//  Created by 朱来飞 on 2018/1/3.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Extension.h"
#import "CSTabController.h"
#import "NewsViewController.h"
#import "SearchViewController.h"
#import "PressViewController.h"
#import "AppointmentViewController.h"
#import "UserCenterViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    
    [self userLoactionNotifier];
    [self pushToMain];
    
    return YES;
}

- (void)pushToMain{
    
    NewsViewController * news = [NewsViewController new];
    UINavigationController * newsNav = [[UINavigationController alloc]initWithRootViewController:news];
    newsNav.tabBarItem.image = [UIImage imageNamed:@"menu_news_icon"]  ;
    newsNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"menu_news_icon_activate"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    newsNav.tabBarItem.title = @"新闻资讯";
    newsNav.navigationBar.translucent = NO ;
    
    SearchViewController * search = [SearchViewController new];
    UINavigationController * searchNav = [[UINavigationController alloc]initWithRootViewController:search];
    searchNav.tabBarItem.image = [UIImage imageNamed:@"menu_personnel_icon"] ;
    searchNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"menu_personnel_icon_activate"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    searchNav.tabBarItem.title = @"人才搜索";
    searchNav.navigationBar.translucent = NO ;
    
//    PressViewController * press = [PressViewController new];
//    UINavigationController * pressNav = [[UINavigationController alloc]initWithRootViewController:press];
////    pressNav.tabBarItem.image = [[UIImage imageNamed:@"menu_release_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
//    pressNav.navigationBar.translucent = NO ;
    
    AppointmentViewController * Appointment = [AppointmentViewController new];
    UINavigationController * AppointmentNav = [[UINavigationController alloc]initWithRootViewController:Appointment];
    AppointmentNav.tabBarItem.image = [UIImage imageNamed:@"menu_item_icon"] ;
    AppointmentNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"menu_item_icon_activate"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    AppointmentNav.tabBarItem.title = @"项目预约";
    AppointmentNav.navigationBar.translucent = NO ;
    
    UserCenterViewController * UserCenter = [UserCenterViewController new];
    UINavigationController * UserCenterNav = [[UINavigationController alloc]initWithRootViewController:UserCenter];
    UserCenterNav.tabBarItem.image = [UIImage imageNamed:@"menu_user_icon"] ;
    UserCenterNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"menu_user_icon_activate"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    UserCenterNav.tabBarItem.title = @"个人中心";
    UserCenterNav.navigationBar.translucent = NO ;
    
    CSTabController * tab = [[CSTabController alloc]init];
    tab.viewControllers = @[newsNav, searchNav  ,AppointmentNav ,UserCenterNav];
    [self.window setRootViewController:tab];
    
}

@end

//
//  UIApplication+StatusBar.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/31.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "UIApplication+StatusBar.h"
#import <objc/runtime.h>
static void * StatusBarKey = "StatusBarKey";
static void * StatusBarColorKey = "StatusBarColorKey";
@implementation UIApplication (StatusBar)

//- (UIView *)statusBar{
//    
//    UIView * bar =  objc_getAssociatedObject(self, StatusBarKey);
//    if (!bar) {
//        bar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//        if ([bar respondsToSelector:@selector(setBackgroundColor:)])
//        {
//            bar.backgroundColor = UIColor_0x007ed3;
//        }
//    }
//    return bar ;
//}
//- (void)setStatusBar:(UIView *)statusBar{
//    objc_setAssociatedObject(self, StatusBarKey, statusBar, OBJC_ASSOCIATION_RETAIN);
//}
//- (void)setStatusBarColor:(UIColor *)statusBarColor{
//    self.statusBar.backgroundColor = statusBarColor ;
//    objc_setAssociatedObject(self, StatusBarColorKey, statusBarColor, OBJC_ASSOCIATION_RETAIN);
//}
//- (UIColor *)statusBarColor{
//    return  objc_getAssociatedObject(self, StatusBarColorKey);
//}
@end

//
//  CSTabBar.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/11.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSTabBar ;
@protocol CSTabBarDelegate<NSObject>
- (void)csTabBarCenterBtnClick:(CSTabBar *)bar;
@end
@interface CSTabBar : UITabBar
@property (nonatomic,weak) id<CSTabBarDelegate>csTabBarDelegate ;
@end

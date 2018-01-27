//
//  CSPageController.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/12.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSPageController ;
@protocol CSPageControllerDelegate<NSObject>
@required

- (NSInteger)numberOfPagesInPageController:(CSPageController *)pageController;
- (UIViewController *)pageController:(CSPageController *)pageController viewControllerAtIndex:(NSInteger)index;
- (NSString *)pageController:(CSPageController *)pageController titleForViewControllerAtIndex:(NSInteger)index ;

@optional
- (void)pageControllerAddBtnClick:(CSPageController *)pageController ;

@end

@interface CSPageController : UIViewController
@property (nonatomic ,weak)id<CSPageControllerDelegate>delegate ;
//此属性应在CSPageController 初始化过后立即赋值，避免Viewcontrollers 已经有值而selectIndex却无值。
@property (nonatomic ,assign)NSInteger selectedIndex ;
- (void)reloadData ;
@end

@interface CSBaselineButton : UIButton
@property (nonatomic,assign) CGFloat buttonlineWidth;
@end







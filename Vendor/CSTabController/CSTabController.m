//
//  CSTabController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/11.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "CSTabController.h"
#import "PressView.h"
#import "PressViewController.h"
@interface CSTabController ()<CSTabBarDelegate>

@property (nonatomic ,strong)CSTabBar * bar ;
@end

@implementation CSTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setValue:self.bar forKey:@"tabBar"];
    
}
-(void)csTabBarCenterBtnClick:(CSTabBar *)bar{
    
    NSArray * source  = @[@{@"title":@"人才发布",
                            @"image":@"login_weixin_icon"
                            }
                          ,@{@"title":@"项目发布",
                             @"image":@"login_zhifubao_icon"}];
    [PressView pressView:source didFinishPicker:^(NSInteger PressType) {
        
            UINavigationController * nav =  self.selectedViewController ;
            PressViewController * press = [PressViewController new];
            press.pressType = PressType;
            [nav pushViewController:press animated:YES];
    }];
    
}
- (CSTabBar *)bar {
    if (!_bar) {
        _bar = [[CSTabBar alloc]init];
        _bar.csTabBarDelegate = self ;
    }
    return _bar ;
}
-(CSTabBar *)tabBar{
    return _bar;
}
@end

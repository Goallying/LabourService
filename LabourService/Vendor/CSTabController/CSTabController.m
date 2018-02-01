//
//  CSTabController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/11.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "CSTabController.h"
#import "PressView.h"
#import "PressProjectViewController.h"
#import "PressPersonViewController.h"
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
                            @"image":@"post_job_information_btn"
                            }
                          ,@{@"title":@"项目发布",
                             @"image":@"post_project_information_btn"}];
    [PressView pressView:source didFinishPicker:^(NSInteger PressType) {
        
            UINavigationController * nav =  self.selectedViewController ;
        if (PressType == 1) {
            PressPersonViewController * person = [PressPersonViewController new];
            [nav pushViewController:person animated:YES];
        }else if (PressType == 2){
            PressProjectViewController * project = [PressProjectViewController new];
            [nav pushViewController:project animated:YES];
        }
    
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

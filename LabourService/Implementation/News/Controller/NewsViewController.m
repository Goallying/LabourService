//
//  ViewController.m
//  GovData
//
//  Created by 朱来飞 on 2018/1/3.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "NewsViewController.h"
#import "CSPageController.h"
#import "NewsViewModel.h"
#import "NewsPageViewController.h"
#import "NewsCustomViewController.h"
@interface NewsViewController ()<CSPageControllerDelegate>
@property (nonatomic ,strong)NSArray * types ;
@property (nonatomic ,strong)CSPageController * pageController  ;
@end


@implementation NewsViewController

- (NSString *)titleText{
    return @"首页";
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarBackItemHidden = YES ;
    //数据请求完成才加载字视图
    [self newsTypeRequest:^{
        [self setPageController];
    }];
}
- (void)newsTypeRequest:(void(^)(void))finish {
    
    if (AppManager.userNewsTypes && AppManager.userNewsTypes.count>0   ) {
        _types = AppManager.userNewsTypes ;
        finish();
        return;
    }
    
    [NewsViewModel getNewsTypesSuccess:^(NSString *msg, NSArray *types) {
        _types = [types copy];
        finish();
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];
    }];
}

- (void)setPageController {
    _pageController = [CSPageController new];
    _pageController.delegate = self ;
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];
    _pageController.view.maker.topTo(self.navigationBar, 0).leftTo(self.view, 0).rightTo(self.view, 0).bottomTo(self.view, 0);
}

- (NSInteger)numberOfPagesInPageController:(CSPageController *)pageController{
    
    return _types.count;
}
- (UIViewController *)pageController:(CSPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    NewsTypeModel * m = _types[index];
    NewsPageViewController * vc = [NewsPageViewController new] ;
    vc.type =  m.value ;
    return vc ;
}

- (NSString *)pageController:(CSPageController *)pageController titleForViewControllerAtIndex:(NSInteger)index{
    
    NewsTypeModel * m = _types[index];
    return m.name;
}
- (void)pageControllerAddBtnClick:(CSPageController *)pageController{
    
    NewsCustomViewController * customVC = [NewsCustomViewController new];
    customVC.menus = [_types mutableCopy];
    [customVC setFinishSelect:^(NSArray *selectedMenus) {
        _types = [selectedMenus copy];
        [_pageController reloadData];
    }];
    [self.navigationController pushViewController:customVC animated:YES];
}


@end

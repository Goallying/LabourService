//
//  ViewController.m
//  App_iOS
//
//  Created by 朱来飞 on 2017/9/26.
//  Copyright © 2017年 上海递拎宝网络科技有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"

@interface BaseViewController ()

@property  (nonatomic,strong)UILabel * emptyLabel  ;
@property (nonatomic,strong) UIImageView * emptyImageView;


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor_f3f3f3;
    [self setupNavigationBar];
    [self setupEmptyView];
    
    //接收登录通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(needLogin) name:NOTICE_TO_LOGIN object:nil];
}

- (void)needLogin {
    
    UINavigationController  * currentNav =  self.tabBarController.selectedViewController;
    UIViewController * currentVC = currentNav.topViewController ;
    if ([currentVC isKindOfClass:[self class]]) {
        LoginViewController * login = [LoginViewController new];
        [currentNav pushViewController:login animated:YES];
    }
}
#pragma mark -
#pragma mark -- NavigationBar Set
- (void)setupNavigationBar {
    
    self.navigationController.navigationBar.barTintColor = UIColor_0x007ed3;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    if ([self respondsToSelector:@selector(setLeftBarButtonItems:)]) {
        [self.navigationItem setLeftBarButtonItems:self.leftBarButtonItems];
    }
    if ([self respondsToSelector:@selector(setRightBarButtonItems:)]) {
        [self.navigationItem setRightBarButtonItems:self.rightBarButtonItems];
    }
    if (!self.leftBarButtonItems || self.leftBarButtonItems.count == 0) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_return_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(backforward)];
        [item setTintColor:[UIColor whiteColor]];
        self.navigationItem.leftBarButtonItem = item ;
    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont systemFontOfSize:18],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
   
}
- (void)backforward {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark -- EmptyView
-(void)setupEmptyView{
    [self.view addSubview:self.emptyLabel];
    [self.view addSubview:self.emptyImageView];
    
    _emptyLabel.maker.centerXTo(self.view, 0).centerYTo(self.view, 45).widthEqualTo(kScreenW).heightEqualTo(21);
    
    _emptyImageView.maker.centerXTo(self.view, 0)
    .bottomTo(_emptyLabel, 10)
    .widthEqualTo(80)
    .heightEqualTo(80);
}
-(void)setShowEmptyView:(BOOL)showEmptyView {
    _emptyLabel.hidden = !showEmptyView ;
    _emptyImageView.hidden = !showEmptyView;
    if (showEmptyView) {
        [self.view bringSubviewToFront:_emptyLabel];
        [self.view bringSubviewToFront:_emptyImageView];
    }
}
#pragma mark -
#pragma mark --  Lazy
-(UILabel *)emptyLabel {
    if (!_emptyLabel) {
        _emptyLabel = [[UILabel alloc]init];
        _emptyLabel.text = @"此页面为空";
        _emptyLabel.font = Font_15;
        _emptyLabel.textAlignment = NSTextAlignmentCenter ;
        _emptyLabel.textColor = [UIColor blackColor];
        _emptyLabel.hidden = YES ;
    }
    return _emptyLabel ;
}
-(UIImageView *)emptyImageView
{
    if (!_emptyImageView) {
        _emptyImageView = [[UIImageView alloc]init];
        [_emptyImageView setImage:[UIImage imageNamed:@"empty_icon"]];
        [_emptyImageView setHidden:YES];
        
    }
    return _emptyImageView ;
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end



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

@property (nonatomic,strong)UIView * navigationBarView ;
@property (nonatomic ,strong)UILabel * titleL  ;
@property (nonatomic,strong)UILabel * emptyLabel  ;
@property (nonatomic,strong) UIImageView * emptyImageView;
@property (nonatomic ,strong)UIButton * goBackBtn ;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor_f3f3f3;
    [self setupNavigationBar];
    [self setupEmptyView];
    
    //接收登录通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:NOTICE_TO_LOGIN object:nil] subscribeNext:^(id x) {
        [self needLogin];
    }];
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
    
    self.navigationController.navigationBarHidden = YES ;
    [self.view addSubview:self.navigationBarView];
    _navigationBarView.maker.topTo(self.view, 0).leftTo(self.view, 0).rightTo(self.view, 0).heightEqualTo(kScrTopMarginH);
    
    if ([self respondsToSelector:@selector(setLeftBarButtonItems:)]) {
        for (NSInteger i = 0; i< self.leftBarButtonItems.count; i ++) {
            UIButton * b = self.leftBarButtonItems[i];
            b.frame = CGRectMake(16 + (24 + 10)* i, 32, 24, 24);
            [_navigationBarView addSubview:b];
        }
    }
    if ([self respondsToSelector:@selector(setRightBarButtonItems:)]) {
        for (NSInteger i = 0; i< self.rightBarButtonItems.count; i ++) {
            UIButton * b = self.rightBarButtonItems[i];
            b.frame = CGRectMake(kScreenW - 16 - 24 - (10 + 24)* i, 32, 24, 24);
            [_navigationBarView addSubview:b];
        }
    }
    if ([self respondsToSelector:@selector(setTitleText:)]) {
        self.titleL.text = self.titleText ;
    }
    if (!self.leftBarButtonItems || self.leftBarButtonItems.count == 0) {
        [_navigationBarView addSubview:self.goBackBtn];
        _goBackBtn.maker.leftTo(_navigationBarView,16).widthEqualTo(24).heightEqualTo(19.5).topTo(_navigationBarView , 32);
    }
   
}
- (void)backforward {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setNavigationBarHidden:(BOOL)navigationBarHidden{
    self.navigationBarView.hidden = navigationBarHidden ;
}
- (UIView *)navigationBar{
    return self.navigationBarView ;
}
- (void)setNavigationBarBackItemHidden:(BOOL)navigationBarBackItemHidden{
    self.goBackBtn.hidden = navigationBarBackItemHidden;
}
-(UIButton *)goBackBtn{
    if (!_goBackBtn) {
        
        _goBackBtn = [UIButton new];
        [_goBackBtn addTarget:self action:@selector(backforward) forControlEvents:UIControlEventTouchUpInside];
        UIImage * image = [[UIImage imageNamed:@"nav_return_btn"] imageWithColor:[UIColor whiteColor]];
        [_goBackBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
    return _goBackBtn ;
}
- (UIView *)navigationBarView{
    
    if (!_navigationBarView) {
        _navigationBarView = [UIView new];
        _navigationBarView.backgroundColor = UIColor_0x007ed3 ;
        
        _titleL = [UILabel new];
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.font = Font_18 ;
        _titleL.textColor = [UIColor whiteColor];
        [_navigationBarView addSubview:_titleL];
        _titleL.maker.topTo(_navigationBarView, 32).centerXTo(_navigationBarView,0).widthGraterThan(44).heightEqualTo(19.5);
    }
     return _navigationBarView;
} ;
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
        _emptyLabel.text = @"暂无数据";
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



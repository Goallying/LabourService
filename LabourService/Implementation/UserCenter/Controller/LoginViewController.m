//
//  LoginViewController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/15.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "LoginViewController.h"
#import "UserCenterViewModel.h"
#import "RegisteViewController.h"
#import "ResetPswViewController.h"
@interface LoginViewController ()

@property (nonatomic ,strong)UIScrollView * scrollView ;
@property (nonatomic ,strong)UIImageView * loginLogo ;
@property (nonatomic ,strong)UIView * loginView ;
@property (nonatomic ,strong)UITextField * userNameTF ;
@property (nonatomic ,strong)UITextField * pswTF ;
@property (nonatomic ,strong)UIButton * loginBtn ;
@property (nonatomic ,strong)UIButton * backBtn ;
@property (nonatomic ,strong)UIButton * forgetPswBtn ;
@property (nonatomic ,strong)UIButton * registeBtn ;
@end

@implementation LoginViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    _scrollView.maker.sidesMarginZero() ;
}

- (void)loginClick {
    
    [[RACSignal combineLatest:@[_userNameTF.rac_textSignal ,_pswTF.rac_textSignal] reduce:^id (NSString * acount ,NSString * psw){
        return @(acount.length && psw.length);
    }] subscribeNext:^(NSNumber * x) {
        if ([x boolValue]) {
            [self login];
        }
    }];
    
   
}
- (void)login {
    [UserCenterViewModel login:_userNameTF.text psw:_pswTF.text success:^(NSString *msg , id obj) {
        
        [AppManager saveLocalUserInfo:obj];
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_LOGIN_SUCCESS object:nil];
        
        [CToast showWithText:msg duration:1.5];
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:NO];
        
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];
    }];
}
- (void)otherLogin:(UIButton *)b {
    
    if (b.tag == 1) {
        //wexin
    }else if (b.tag == 2){
        //zhifubao
    }
}
- (void)forgetPswClick{
    ResetPswViewController * reset = [ResetPswViewController new];
    [self.navigationController pushViewController:reset animated:YES];
}
- (void)registeClick{
    RegisteViewController * vc = [RegisteViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)back {
    
    if (!User_Info.token || User_Info.token.length == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(UIButton *)forgetPswBtn{
    if (!_forgetPswBtn) {
        _forgetPswBtn = [UIButton new];
        [_forgetPswBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPswBtn.titleLabel setFont:Font_14];
        [_forgetPswBtn setTitleColor:UIColor_666666 forState:UIControlStateNormal];
        [_forgetPswBtn addTarget:self action:@selector(forgetPswClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPswBtn;
}
-(UIButton *)registeBtn{
    if (!_registeBtn) {
        _registeBtn = [UIButton new];
        [_registeBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
        [_registeBtn.titleLabel setFont:Font_14];
        [_registeBtn setTitleColor:UIColor_666666 forState:UIControlStateNormal];
        [_registeBtn addTarget:self action:@selector(registeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registeBtn;
}
-(UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton new];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"nav_return_btn"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn ;
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor whiteColor];
        
        [_scrollView addSubview:self.backBtn];
        [_scrollView addSubview:self.loginLogo];
        [_scrollView addSubview:self.loginView];
        [_scrollView addSubview:self.forgetPswBtn];
        [_scrollView addSubview:self.registeBtn];
        [_scrollView addSubview:self.loginBtn];
        
        CGFloat w = stringSize(_registeBtn.currentTitle, 14, CGSizeMake(CGFLOAT_MAX, 30)).width;
        _backBtn.maker.leftTo(_scrollView, 16).topTo(_scrollView, 32).widthEqualTo(24).heightEqualTo(20);
        _loginLogo.maker.topTo(_scrollView, 80).centerXTo(_scrollView, 0).widthEqualTo(100).heightEqualTo(100);
        _loginView.maker.topTo(_loginLogo,40).leftTo(_scrollView,20).heightEqualTo(88).widthEqualTo(kScreenW - 40);
        _forgetPswBtn.maker.topTo(_loginBtn, 20).leftTo(_scrollView, 20).widthGraterThan(44).heightEqualTo(30);
        _registeBtn.maker.topTo(_loginBtn, 20).leftTo(_scrollView, kScreenW - w - 20).heightEqualTo(30).widthEqualTo(w);
        _loginBtn.maker.topTo(_loginView, 32).leftTo(_scrollView, 20).widthEqualTo(kScreenW - 40).heightEqualTo(40);
        
        UILabel * l = [UILabel new];
        l.text = @"其他登录方式";
        l.textColor = UIColor_999999;
        l.font = Font_14;
        [_scrollView addSubview:l];
        l.maker.centerXTo(_scrollView, 0).topTo(_loginBtn, 80).widthGraterThan(44).heightEqualTo(20);
        
        UIView * leftV = [UIView new];
        leftV.backgroundColor = UIColor_f3f3f3  ;
        [_scrollView addSubview:leftV];
        leftV.maker.leftTo(_scrollView, 20).centerYTo(l,0).rightTo(l, 8).heightEqualTo(1);
        
        UIView * rightV = [UIView new];
        rightV.backgroundColor = UIColor_f3f3f3  ;
        [_scrollView addSubview:rightV];
        rightV.maker.leftTo(l, 8).centerYTo(l,0).heightEqualTo(1).widthEqualTo(kScreenW - l.right - 8 - 20);
        
        UIButton  * weXin = [UIButton new];
        [weXin setBackgroundImage:[UIImage imageNamed:@"login_weixin_icon"] forState:UIControlStateNormal];
        weXin.tag = 1 ;
        [weXin addTarget:self action:@selector(otherLogin:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:weXin];
        weXin.maker.topTo(l, 24).centerXTo(_scrollView,-30).widthEqualTo(40).heightEqualTo(40);
        
        UIButton  * aliPay = [UIButton new];
        [aliPay setBackgroundImage:[UIImage imageNamed:@"login_zhifubao_icon"] forState:UIControlStateNormal];
        aliPay.tag = 2 ;
        [aliPay addTarget:self action:@selector(otherLogin:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:aliPay];
        aliPay.maker.topTo(l, 24).centerXTo(_scrollView,30).widthEqualTo(40).heightEqualTo(40);

        _scrollView.contentSize = CGSizeMake(kScreenW, aliPay.bottom + 20);

    }
    return _scrollView ;
}
- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton new];
        _loginBtn.layer.cornerRadius = 5 ;
        [_loginBtn setBackgroundColor:UIColor_0x007ed3];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn addTarget: self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn ;
}

- (UIView *)loginView{
    
    if (!_loginView) {
        _loginView = [UIView new];
        _loginView.layer.borderWidth = 1 ;
        _loginView.layer.borderColor = UIColor_f3f3f3.CGColor;
        _loginView.layer.cornerRadius = 5 ;
        
        UIImageView * userImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
        userImg.image = [UIImage imageNamed:@"login_user_icon"];
        [_loginView addSubview:userImg];
        
        _userNameTF = [[UITextField alloc]init];
        _userNameTF.placeholder = @"请输入账户";
        _userNameTF.borderStyle = UITextBorderStyleNone ;
        _userNameTF.placeholderFont = Font_14 ;
        [_loginView addSubview:_userNameTF];
        _userNameTF.maker.leftTo(userImg, 14).topTo(_loginView, 0).heightEqualTo(43).rightTo(_loginView, 0);
        
        //seperator
        UIView * seperator = [[UIView alloc]init];
        seperator.backgroundColor = UIColorHex(0xf3f3f3);
        [_loginView addSubview:seperator];
        seperator.maker.leftTo(_loginView, 10).topTo(_loginView, 44).rightTo(_loginView, 0).heightEqualTo(1);
        
        UIImageView * pswImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12 + 44, 20, 20)];
        pswImg.image = [UIImage imageNamed:@"login_password_icon"];
        [_loginView addSubview:pswImg];
        
        _pswTF = [[UITextField alloc]init];
        _pswTF.placeholder = @"请输入密码";
        _pswTF.borderStyle = UITextBorderStyleNone ;
        _pswTF.placeholderFont = Font_14 ;
        [_loginView addSubview:_pswTF];
        _pswTF.maker.leftTo(userImg, 14).topTo(seperator, 0).heightEqualTo(43).rightTo(_loginView, 0);
    }
    return _loginView ;
}
-(UIImageView *)loginLogo{
    if (!_loginLogo) {
        _loginLogo = [[UIImageView alloc]init];
        _loginLogo.image = [UIImage imageNamed:@"login_logo"];
    }
    return _loginLogo ;
}
- (void)dealloc{
    NSLog(@" +++++++++ login dealloc +++++++");
}

@end

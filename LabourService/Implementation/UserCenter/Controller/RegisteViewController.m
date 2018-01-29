//
//  RegisteViewController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/15.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "RegisteViewController.h"
#import "UserCenterViewModel.h"
@interface RegisteViewController ()
@property (nonatomic ,strong)UIScrollView * scrollView ;
@property (nonatomic ,strong)UITextField * phoneTF ;
@property (nonatomic ,strong)UITextField * verifyTF ;
@property (nonatomic ,strong)UITextField * pswTF ;
@property (nonatomic ,strong)UITextField * inviteTF ;
@property (nonatomic ,strong)UIButton * codeBtn ;

@property (nonatomic ,copy)NSString * code ;
@end

@implementation RegisteViewController

-(NSString *)title{
    return @"注册" ;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.scrollView];
    _scrollView.maker.sidesMarginZero();
}



- (void)getCode:(UIButton *)b {
    
    [UserCenterViewModel getCode:_phoneTF.text
                            type:1
                         success:^(NSString *msg, NSString *code) {
        _code = [code copy];
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];
    }];
}
- (void)registeClick{
    
    if (![_code isEqualToString:_verifyTF.text]) {
        [CToast showWithText:@"验证码错误"];
        return;
    }
    if (_pswTF.text.length < 6) {
        [CToast showWithText:@"密码过短"];
        return;
    }
    
    [UserCenterViewModel registerName:_phoneTF.text
                                  psw:_pswTF.text
                             inviteNo:_inviteTF.text
                              success:^(NSString *msg ,id obj) {
    
      [AppManager.userInfo yy_modelSetWithJSON:obj];
      [CToast showWithText:msg];
                      
      self.tabBarController.selectedIndex = 0;
      [self.navigationController popToRootViewControllerAnimated:NO];
                                  
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];
    }];
}
- (UIScrollView *)scrollView{

    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = UIColor_f3f3f3;
        
        UIView * phoneV = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenW, 44)];
        phoneV.backgroundColor = [UIColor whiteColor];
        UILabel * phoneTip = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 44)];
        phoneTip.text = @"手机号码";
        phoneTip.font = Font_14 ;
        [phoneV addSubview:phoneTip];
        
        _phoneTF = [[UITextField  alloc]initWithFrame:CGRectMake(phoneTip.right + 10, 0, kScreenW - phoneTip.right - 10, 44)];
        _phoneTF.borderStyle = UITextBorderStyleNone ;
        _phoneTF.placeholder = @"请输入手机号码";
        _phoneTF.placeholderFont = Font_14 ;
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad ;
        [phoneV addSubview:_phoneTF];
        [_scrollView addSubview:phoneV];
        
        //verify
        UIView * verifyV = [[UIView alloc]initWithFrame:CGRectMake(0,phoneV.bottom+10, kScreenW, 44)];
        verifyV.backgroundColor = [UIColor whiteColor];
        UILabel * verifyTip = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 44)];
        verifyTip.text = @"验证码";
        verifyTip.font = Font_14 ;
        [verifyV addSubview:verifyTip];
        
        _verifyTF = [[UITextField  alloc]initWithFrame:CGRectMake(verifyTip.right + 10, 0, kScreenW - verifyTip.right - 10 - 80, 44)];
        _verifyTF.borderStyle = UITextBorderStyleNone ;
        _verifyTF.placeholder = @"请输入验证码";
        _verifyTF.placeholderFont = Font_14 ;
        _verifyTF.keyboardType = UIKeyboardTypeNumberPad ;
        [verifyV addSubview:_verifyTF];
        
        _codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenW - 80, 0, 80, 44)];
        [_codeBtn.titleLabel setFont:Font_14];
        [_codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_codeBtn setTitleColor:UIColor_0x007ed3 forState:UIControlStateNormal];
        [_codeBtn addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
        [verifyV addSubview:_codeBtn];
        [_scrollView addSubview:verifyV];
        
        //password
        UIView * pswV = [[UIView alloc]initWithFrame:CGRectMake(0,verifyV.bottom+10, kScreenW, 44)];
        pswV.backgroundColor = [UIColor whiteColor];
        UILabel * pswTip = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 44)];
        pswTip.text = @"用户密码";
        pswTip.font = Font_14 ;
        [pswV addSubview:pswTip];
        
        _pswTF = [[UITextField  alloc]initWithFrame:CGRectMake(pswTip.right + 10, 0, kScreenW - pswTip.right - 10, 44)];
        _pswTF.borderStyle = UITextBorderStyleNone ;
        _pswTF.placeholder = @"请填写不少于6位用户密码";
        _pswTF.placeholderFont = Font_14 ;
        [pswV addSubview:_pswTF];
        [_scrollView addSubview:pswV];
        
        //invite
        UIView * inviteV = [[UIView alloc]initWithFrame:CGRectMake(0,pswV.bottom+10, kScreenW, 44)];
        inviteV.backgroundColor = [UIColor whiteColor];
        UILabel * inviteTip = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 44)];
        inviteTip.text = @"邀请码";
        inviteTip.font = Font_14 ;
        [inviteV addSubview:inviteTip];
        
        _inviteTF = [[UITextField  alloc]initWithFrame:CGRectMake(inviteTip.right + 10, 0, kScreenW - inviteTip.right - 10, 44)];
        _inviteTF.borderStyle = UITextBorderStyleNone ;
        _inviteTF.placeholder = @"请输入推荐码或手机号(可不填)";
        _inviteTF.placeholderFont = Font_14 ;
        [inviteV addSubview:_inviteTF];
        [_scrollView addSubview:inviteV];
        
        UIButton  * regBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, inviteV.bottom + 30, kScreenW - 40, 40)];
        regBtn.layer.cornerRadius = 5 ;
        regBtn.backgroundColor = UIColor_0x007ed3 ;
        [regBtn.titleLabel setFont:Font_14];
        [regBtn setTitle:@"完成注册" forState:UIControlStateNormal];
        [regBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [regBtn addTarget:self action:@selector(registeClick) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:regBtn];
        _scrollView.contentSize = CGSizeMake(kScreenW, regBtn.bottom + 20);

    }
    return _scrollView ;

}


@end

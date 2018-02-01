//
//  SearchH5ViewController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/17.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "SearchH5ViewController.h"
#import "SearchViewModel.h"
#import "AppointmentViewModel.h"
#import "PayViewController.h"
@interface SearchH5ViewController ()
@property (nonatomic ,strong)UILabel * moneyLabel ;
@end

@implementation SearchH5ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView.bottomConstraint.constant = kTabBarH ;
    
    [self layoutSubviews];
    [self cashRequest];
}
- (void)cashRequest{
    
    if (self.showType == ShowType_Person) {
        [SearchViewModel getUserCash:User_Info.token success:^(NSString *msg, Cash *cash) {
            _moneyLabel.text = [cash.rmb stringByAppendingString:@"元"];
        } failure:^(NSString *msg, NSInteger code) {
            [CToast showWithText:msg];
        }];
    }else if (self.showType == ShowType_Project){
        [AppointmentViewModel getProjectCash:User_Info.token success:^(NSString *msg, Cash *cash) {
            _moneyLabel.text = [cash.rmb stringByAppendingString:@"元"];
        } failure:^(NSString *msg, NSInteger code) {
            [CToast showWithText:msg];
        }];
    }

}
- (void)phoneClick{
    PayViewController * pay = [PayViewController new];
    [self.navigationController pushViewController:pay animated:YES];
}

- (void)contactClick {
    
    [SearchViewModel contact:User_Info.token orderId:_searchModel.ID sendId:_searchModel.userId messageType:self.showType success:^(NSString *msg) {
        [CToast showWithText:msg];

    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];
    }];
}

- (void)layoutSubviews{
    
    UIImageView * moneyIcon = [UIImageView new];
    moneyIcon.image = [UIImage imageNamed:@"money_icon"];
    [self.view addSubview:moneyIcon];
    moneyIcon.maker.leftTo(self.view, 16).bottomTo(self.view, (kTabBarH - 30)/2).heightEqualTo(30).widthEqualTo(30);
    
    _moneyLabel = [UILabel new];
    _moneyLabel.textColor = [UIColor redColor];
    [self.view addSubview:_moneyLabel];
    _moneyLabel.maker.leftTo(moneyIcon, 16).centerYTo(moneyIcon, 0).widthGraterThan(1).heightEqualTo(30);
    
    UIButton * contactBtn = [UIButton new];
    contactBtn.layer.cornerRadius = 5;
    [contactBtn.titleLabel setFont:Font_14];
    [contactBtn setBackgroundColor:UIColor_0x007ed3];
    [contactBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contactBtn setTitle:@"请联系我" forState:UIControlStateNormal];
    [contactBtn addTarget:self action:@selector(contactClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:contactBtn];
    contactBtn.maker.rightTo(self.view, 16).centerYTo(moneyIcon, 0).widthEqualTo(80).heightEqualTo(40);
    
    UIButton * phoneBtn = [UIButton new];
    phoneBtn.layer.cornerRadius = 5;
    [phoneBtn.titleLabel setFont:Font_14];
    [phoneBtn setBackgroundColor:UIColor_0x007ed3];
    [phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [phoneBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
    [phoneBtn addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneBtn];
    phoneBtn.maker.rightTo(contactBtn, 16).centerYTo(moneyIcon, 0).widthEqualTo(80).heightEqualTo(40);
   
}

@end

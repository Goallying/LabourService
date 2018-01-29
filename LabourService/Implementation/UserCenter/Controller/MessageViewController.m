//
//  MessageViewController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/27.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "MessageViewController.h"
#import "SwitchView.h"
#import "UserCenterViewModel.h"
@interface MessageViewController ()
@property (nonatomic ,strong)SwitchView * swithView ;
@property (nonatomic ,assign)NSInteger page ;
@end

@implementation MessageViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO ;
    self.tabBarController.tabBar.hidden = YES ;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.swithView];
    _swithView.maker.topTo(self.view, 0).leftTo(self.view, 0).rightTo(self.view, 0).heightEqualTo(50);
    
    [self getMessage:0];
    
}
- (void)getMessage:(NSInteger)status {
    
    [UserCenterViewModel getUserMessage:User_Info.token
                                   page:1 status:status
                                success:^(NSString *msg, NSArray *message) {
    } failure:^(NSString *msg, NSInteger code) {
        
    }];
}
- (SwitchView *)swithView{
    if (!_swithView) {
        _swithView = [[SwitchView alloc]init];
        _swithView.source = @[@"未读消息",@"已读消息"];
        __weak typeof(self) wSelf = self ;
        [_swithView setClicked:^(NSInteger option) {
            [wSelf getMessage:option - 1];
        }];
    }
    return _swithView ;
}

@end

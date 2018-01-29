//
//  BaseH5ViewController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/15.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseH5ViewController.h"

@interface BaseH5ViewController ()
@property(nonatomic,strong) UIWebView * webV ;

@end

@implementation BaseH5ViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO ;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webV];
    _webV.maker.topTo(self.view, 0).leftTo(self.view, 0).bottomTo(self.view,0).rightTo(self.view, 0);
}

-(UIWebView *)webV{
    if (!_webV) {
        _webV = [[UIWebView alloc]init];
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        [_webV loadRequest:request];
    }
    return _webV ;
}
- (UIWebView *)webView{
    return _webV;
}
@end

//
//  BaseH5ViewController.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/15.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseViewController.h"

//此类可直接使用，也可作为基础类拓展
@interface BaseH5ViewController : BaseViewController

@property (nonatomic,strong,readonly)UIWebView * webView;
@property (nonatomic,copy)NSString * url ;

@end

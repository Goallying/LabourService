//
//  NewsCustomViewController.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/22.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseViewController.h"

@interface NewsCustomViewController : BaseViewController

@property (nonatomic ,strong)NSMutableArray * menus ;

@property (nonatomic ,strong)void (^finishSelect)(NSArray * selectedMenus);
@end

//
//  ViewController.h
//  App_iOS
//
//  Created by 朱来飞 on 2017/9/26.
//  Copyright © 2017年 上海递拎宝网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSTabController.h"
#import "CToast.h"
#import "MJRefresh.h"
typedef NS_ENUM(NSInteger , PullType) {
    Pull_Refresh,
    Pull_More 
};
@interface BaseViewController : UIViewController

@property (nonatomic,strong ,readonly)UIView * navigationBar ;
@property (nonatomic,assign)BOOL navigationBarHidden ;
@property (nonatomic,assign)BOOL navigationBarBackItemHidden ;
@property (nonatomic,copy)NSString * titleText ;
@property (nonatomic ,assign)BOOL showEmptyView ;
/**
 *NavigantionBar Set
 */
@property  (nonatomic,strong) NSArray<UIButton *> *leftBarButtonItems;
@property  (nonatomic,strong) NSArray<UIButton *> *rightBarButtonItems;

// you can override this method.
- (void)backforward ;
@end






//
//  UIColor+Add.h
//  App_iOS
//
//  Created by 朱来飞 on 2017/9/26.
//  Copyright © 2017年 上海递拎宝网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef UIColorHex
#define UIColorHex(_hex_)   [UIColor colorWithHex:_hex_]
#endif

#ifndef UIColorHex_Alpha
#define UIColorHex_Alpha(_hex_ , _alpha_)   [UIColor colorWithHex:_hex_  alpha:_alpha_]
#endif


@interface UIColor (Add)

+ (UIColor *)colorWithHex:(long)hex;
+ (UIColor *)colorWithHex:(long)hex alpha:(CGFloat)alpha ;

@end

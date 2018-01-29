//
//  UIColor+Add.m
//  App_iOS
//
//  Created by 朱来飞 on 2017/9/26.
//  Copyright © 2017年 上海递拎宝网络科技有限公司. All rights reserved.
//

#import "UIColor+Add.h"

@implementation UIColor (Add)

+(UIColor *)colorWithHex:(long)hex alpha:(CGFloat)alpha {
    
    float red = ((float)((hex & 0xFF0000)>>16))/255.0;
    float green = ((float)((hex & 0xFF00)>>8))/255.0;
    float blue = ((float)(hex & 0xFF))/255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
}
+ (UIColor *)colorWithHex:(long)hex{

    return [UIColor colorWithHex:hex alpha:1];
    
}
+ (UIColor *)colorWith255Red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

@end

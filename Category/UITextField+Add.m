//
//  UITextField+Add.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/15.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "UITextField+Add.h"
#import <objc/runtime.h>

static void * FontKey  = @"FontKey";

@implementation UITextField (Add)

- (void)setPlaceholderFont:(UIFont *)placeholderFont{
    [self setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
    objc_setAssociatedObject(self, FontKey, placeholderFont, OBJC_ASSOCIATION_RETAIN);
}
- (UIFont *)placeholderFont{
    return objc_getAssociatedObject(self, FontKey);
}

@end

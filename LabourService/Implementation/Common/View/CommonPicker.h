//
//  CommonPicker.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/19.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>
// 最多两列
@interface CommonPicker : UIView

+ (instancetype)pickerSource:(NSArray *)source finish:(void(^)(NSString * s1 , NSString * s2))finish ;

@end

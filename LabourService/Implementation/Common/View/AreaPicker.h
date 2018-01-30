//
//  CommonPicker.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/19.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Area.h"
@interface AreaPicker : UIView

+ (instancetype)pickerSelectfinish:(void(^)(Area * a1 , Area * a2))finish ;

@end

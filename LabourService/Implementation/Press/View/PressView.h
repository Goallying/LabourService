//
//  PressView.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/21.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger , PressType) {
    PressType_Person  = 1,
    PressType_Project = 2
};

@interface PressView : UIView

+ (instancetype)pressView:(NSArray *)source didFinishPicker:(void(^)(NSInteger PressType))finish ;

@end

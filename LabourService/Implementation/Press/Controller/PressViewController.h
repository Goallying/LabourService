//
//  PressViewController.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/11.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger ,Press_VC_Type){
    Person = 1,
    Project = 2
};
@interface PressViewController : BaseViewController

@property (nonatomic ,assign)Press_VC_Type pressType;
@end

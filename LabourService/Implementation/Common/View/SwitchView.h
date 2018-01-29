//
//  SwitchView.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/27.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchView : UIView
@property (nonatomic ,strong)NSArray * source ;
@property (nonatomic ,copy)void(^clicked)(NSInteger option);
@end

//
//  SideSelectView.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/23.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideSelectView : UIView

- (instancetype)initWithSource:(NSArray *)source finish:(void(^)(NSArray * selected))finish ;
@property (nonatomic ,assign) NSInteger maxSelectCount ;
@end

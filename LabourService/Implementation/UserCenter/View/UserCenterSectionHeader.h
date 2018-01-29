//
//  UserCenterSectionHeader.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/18.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger , ClickOperation) {
    Click_Left,
    Click_Right
};
@interface UserCenterSectionHeader : UIView

@property (nonatomic ,copy)void(^clickOperation)(ClickOperation operation);

@end

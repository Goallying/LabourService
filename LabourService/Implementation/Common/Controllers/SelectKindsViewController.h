//
//  SelectKindsViewController.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/23.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectKindsViewController : BaseViewController
@property (nonatomic ,copy)void(^finishSelect)(NSArray * kinds) ;
@property (nonatomic ,assign)NSInteger maxSelectCount ;
@property (nonatomic ,assign)BOOL selectKindMaxPersonNumLimited ;
@end

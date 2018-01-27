//
//  WorkKind.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/23.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseModel.h"

@interface WorkKind : BaseModel<NSCoding>

@property (nonatomic ,copy)NSString * realName ;
@property (nonatomic ,assign)NSInteger ID ;
@property (nonatomic ,assign)NSInteger  pid ;

@property (nonatomic ,strong)NSMutableArray<WorkKind *> * subKinds ;
@property (nonatomic ,assign)BOOL  selected ;
@end

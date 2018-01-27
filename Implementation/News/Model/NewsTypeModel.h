//
//  NewsTypeModel.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/22.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseModel.h"

@interface NewsTypeModel : BaseModel<NSCoding>

@property (nonatomic ,copy)NSString *name ;
@property (nonatomic ,assign)NSInteger value ;

@end

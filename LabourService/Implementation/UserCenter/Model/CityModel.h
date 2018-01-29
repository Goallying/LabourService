//
//  CityModel.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/19.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseModel.h"

@interface CityModel : BaseModel

@property (nonatomic ,copy)NSString * depict ;
@property (nonatomic ,copy)NSString * areaname ;
@property (nonatomic ,assign)NSInteger level ;
@property (nonatomic ,copy)NSString * ID ;
@property (nonatomic ,copy)NSString * parentId ;
@end

//
//  MessageModel.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/29.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel

@property (nonatomic ,copy)NSString * ID ;
@property (nonatomic ,assign)NSInteger messageStatus ;
@property (nonatomic ,copy)NSString * messageTitle ;
@property (nonatomic ,copy)NSString * messageContent ;
@property (nonatomic ,assign)NSInteger messageType ;
@property (nonatomic ,copy)NSString * orderId ;
@property (nonatomic ,copy)NSString * sendTime ;
@end

//
//  NSString+Add.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/13.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_INLINE NSString * nonullString(id s){
    return [NSString stringWithFormat:@"%@",s];
}
NS_INLINE CGSize stringSize(NSString * s , CGFloat fontValue ,CGSize sizeRange){
    return [s boundingRectWithSize:sizeRange options:0 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontValue]} context:nil].size;
}

@interface NSString (Add)

@end

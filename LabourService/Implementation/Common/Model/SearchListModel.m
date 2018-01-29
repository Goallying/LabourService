//
//  SearchListModel.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/16.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "SearchListModel.h"
#define Margin  4
#define MAX_TAGS 5
@implementation SearchListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{@"ID":@"id"};
}
+ (NSArray *)modelPropertyBlacklist{
    return @[@"tagsHeight",@"appointmentTagsHeight"];
}

//- (CGFloat)appointmentTagsHeight{
//    CGFloat viewWidth = kScreenW - 16 - 16 - 48 ;
//    return [self heightWithviewWidth:viewWidth];
//}
//- (CGFloat)searchTagsHeight{
//    
//    CGFloat viewWidth = kScreenW - 64 - 32 - 16 ;
//    return [self heightWithviewWidth:viewWidth];
//}

//- (CGFloat)heightWithviewWidth:(CGFloat)viewWidth {
//
//    CGFloat currentX = 0;
//    CGFloat countRow = 1;
//    NSMutableArray * tags = [NSMutableArray array];
//    for (NSDictionary * dic in self.realName) {
//        [tags addObject:dic[@"realname"]];
//    }
//    NSInteger c = self.realName.count > MAX_TAGS ? MAX_TAGS:self.realName.count ;
//    for (int i = 0; i < c; i++) {
//        CGFloat sw = stringSize(tags[i], 12, CGSizeMake(CGFLOAT_MAX, 20)).width + 8;
//        if (sw + Margin + currentX > viewWidth) {
//            currentX =  sw + Margin ;
//            countRow ++ ;
//        }else {
//            if ((i == c   -  1)&& currentX == 0 && c!=1) {
//                countRow ++ ;
//            }else{
//                currentX = currentX + sw + Margin ;
//            }
//        }
//    }
//    return countRow * 20 + (countRow - 1) * Margin ;
//}
@end

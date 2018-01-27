//
//  TagView.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/16.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "TagView.h"
#define Margin  4
#define MAX_TAGS 5

@implementation TagView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        for (NSInteger i = 0; i < MAX_TAGS; i ++) {
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = UIColor_66b2e4;
            label.layer.cornerRadius = 3;
            label.clipsToBounds = YES;
            label.textAlignment = NSTextAlignmentCenter;
            label.height = 20 ;
            label.hidden = YES;
            [self addSubview:label];
        }
    }
    return self ;
}
- (void)layoutSubviews{
    
    CGFloat currentX = 0;
    CGFloat currentY = 0;
    CGFloat countRow = 0;
    CGFloat countCol = 0;
    for (int i = 0; i < self.subviews.count; i++) {
        UILabel *subView = self.subviews[i];
        if (i > _tags.count - 1 || !_tags ||_tags.count == 0) {
            subView.text = nil;
            subView.hidden = YES ;
        }else{
            subView.hidden = NO;
            CGFloat sw = stringSize(_tags[i], 12, CGSizeMake(CGFLOAT_MAX, 20)).width + 8;
            subView.text = _tags[i];
            subView.width = sw ;
            if (subView.width > self.width) subView.width = self.width;
            if (currentX + subView.width + Margin * countRow > self.width) {
                subView.left = 0;
                subView.top = (currentY += subView.height) + Margin * ++countCol;
                currentX = subView.width;
                countRow = 1;
            } else {
                subView.left = (currentX += subView.width) - subView.width + Margin * countRow;
                subView.top = currentY + Margin * countCol;
                countRow ++;
            }
        }
    }

}
- (void)setTags:(NSArray *)tags{
    
    _tags = tags ;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (CGFloat)pressTagsHeight{
    CGFloat viewWidth = kScreenW - 16 - 16;
    return [self heightWithviewWidth:viewWidth] ;
}

- (CGFloat)appointmentTagsHeight{
    CGFloat viewWidth = kScreenW - 16 - 16 - 48 ;
    return [self heightWithviewWidth:viewWidth];
}
- (CGFloat)searchTagsHeight{
    
    CGFloat viewWidth = kScreenW - 64 - 32 - 16 ;
    return [self heightWithviewWidth:viewWidth];
}


- (CGFloat)heightWithviewWidth:(CGFloat)viewWidth {
    
    CGFloat currentX = 0;
    CGFloat countRow = 1;

    NSInteger c = _tags.count > MAX_TAGS ? MAX_TAGS:_tags.count ;
    for (int i = 0; i < c; i++) {
        CGFloat sw = stringSize(_tags[i], 12, CGSizeMake(CGFLOAT_MAX, 20)).width + 8;
        if (sw + Margin + currentX > viewWidth) {
            currentX =  sw + Margin ;
            countRow ++ ;
        }else {
            if ((i == c   -  1)&& currentX == 0 && c!=1) {
                countRow ++ ;
            }else{
                currentX = currentX + sw + Margin ;
            }
        }
    }
    return countRow * 20 + (countRow - 1) * Margin ;
}

@end

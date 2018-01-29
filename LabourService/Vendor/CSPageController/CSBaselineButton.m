//
//  CSBaselineButton.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/27.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "CSBaselineButton.h"


@implementation CSBaselineButton
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.selected) {
        CGFloat lineWidth = 2.0;
        CGColorRef color = UIColorHex(0x007ed3).CGColor;
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(ctx, color);
        CGContextSetLineWidth(ctx, lineWidth);
        CGContextMoveToPoint(ctx, 10, self.frame.size.height-lineWidth);
        CGContextAddLineToPoint(ctx, self.frame.size.width - 10, self.frame.size.height-lineWidth);
        CGContextStrokePath(ctx);
    }
}
@end

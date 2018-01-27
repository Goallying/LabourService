//
//  CSTabBar.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/11.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "CSTabBar.h"
@interface CSTabBar ()

@property (nonatomic, strong) UIButton *centerBtn;

@end
@implementation CSTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.centerBtn];
    }
    return self ;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    NSMutableArray *tabBarButtonArray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonArray addObject:view];
        }
    }
    CGFloat barWidth = self.bounds.size.width;
    CGFloat barHeight = self.bounds.size.height;
    CGFloat centerBtnWidth = self.centerBtn.width;
    CGFloat centerBtnHeight = self.centerBtn.height;
    self.centerBtn.center = CGPointMake(barWidth / 2, barHeight - centerBtnHeight/2);
    CGFloat barItemWidth = (barWidth - centerBtnWidth) / tabBarButtonArray.count;
    
    [tabBarButtonArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = view.frame;
        if (idx >= tabBarButtonArray.count / 2) {
            // 重新设置x坐标，如果排在中间按钮的右边需要加上中间按钮的宽度
            frame.origin.x = idx * barItemWidth + centerBtnWidth;
        } else {
            frame.origin.x = idx * barItemWidth;
        }
        frame.size.width = barItemWidth;
        view.frame = frame;
    }];
    [self bringSubviewToFront:self.centerBtn];
}
- (void)clickCenterBtn{
    if ([self.csTabBarDelegate respondsToSelector:@selector(csTabBarCenterBtnClick:)]) {
        [self.csTabBarDelegate csTabBarCenterBtnClick:self];
    }
}
- (UIButton *)centerBtn
{
    if (!_centerBtn) {
        _centerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
        [_centerBtn setImage:[UIImage imageNamed:@"menu_release_icon"] forState:UIControlStateNormal];
        [_centerBtn addTarget:self action:@selector(clickCenterBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
}
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//
//    UIView *result = [super hitTest:point withEvent:event];
//    // 如果事件发生在tabbar里面直接返回
//    if (result) {
//        return result;
//    }
//    CGPoint subPoint = [_centerBtn convertPoint:point fromView:self];
//    result = [_centerBtn hitTest:subPoint withEvent:event];
//    // 如果事件发生在subView里就返回
//    if (result) {
//        return result;
//    }
//    return nil;
//}
//- (void)layoutSubviews {
//    
//    UIView * topLine = [UIView new];
//    topLine.backgroundColor = UIColorHex_Alpha(0xd7d7d7, 0.5);
//    [self addSubview:topLine];
//    topLine.maker.leftTo(self, 0).topTo(self, 0).rightTo(self, 0).heightEqualTo(1);
//    
//    CGFloat w = kScreenW / self.title_images.count ;
//    CGFloat gap = w/2 - 10 ;
//    
//    for (NSInteger i = 0; i< self.title_images.count; i++) {
//        
//        NSDictionary * d = self.title_images[i];
//        
//        if (i == 2) {
//            UIImageView * v = [[UIImageView alloc]initWithFrame:CGRectMake(w * i, -8, 64, 64)];
//            v.image = [UIImage imageNamed:d[@"imageName"]];
//            [self addSubview:v];
//        }else{
//            
//            UIImageView * v = [[UIImageView alloc]initWithFrame:CGRectMake(gap + w * i, 9, 20, 22)];
//            v.image = [UIImage imageNamed:d[@"imageName"]];
//            
//            UILabel * l = [UILabel new];
//            l.font = Font_12 ;
//            l.textAlignment = NSTextAlignmentCenter ;
//            l.text = d[@"title"];
//            [self addSubview:v];
//            [self addSubview:l];
//            
//            l.maker.centerXTo(v, 0).widthGraterThan(44).topTo(v, 6).heightEqualTo(11);
//        }
//        
//        UIButton * b = [[UIButton alloc]initWithFrame:CGRectMake(w * i, 0, 80, kBarHeight)];
//        b.tag = i + 1 ;
//        [b addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:b];
//    }
//}


@end

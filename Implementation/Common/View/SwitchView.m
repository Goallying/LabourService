//
//  SwitchView.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/27.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "SwitchView.h"
#import "CSBaselineButton.h"

@interface SwitchView()

@property (nonatomic ,strong)NSMutableArray * btns ;
@end

@implementation SwitchView

- (void)layoutSubviews{
    
    CGFloat w = self.width / _source.count ;
    CGFloat h= self.height ;
    for (NSInteger i = 0 ; i<_source.count; i ++) {
        CSBaselineButton * b = self.btns[i];
        b.frame = CGRectMake(w * i, 0, w, h) ;
        b.tag = i + 1 ;
        [b setTitle:_source[i] forState:UIControlStateNormal];
        [b setTitleColor:UIColor_0x007ed3 forState:UIControlStateSelected];
        [b setTitleColor:UIColor_666666 forState:UIControlStateNormal];
        [b addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            b.selected = YES ;
        }
        [self addSubview:b];
    }
    
}
- (void)setSource:(NSArray *)source {
    _source = source ;
    for (NSInteger i = 0; i< _source.count; i++) {
        CSBaselineButton * b =[[CSBaselineButton alloc]init];
        [self.btns addObject: b];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (NSMutableArray *)btns{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns ;
}
- (void)click:(CSBaselineButton *) b {
    
    static NSInteger lastIdx = 1 ;
    CSBaselineButton * last = self.btns[lastIdx - 1];
    last.selected = NO ;
    
    b.selected = YES ;
    lastIdx = b.tag ;
    
    if (self.clicked) {
        self.clicked(b.tag);
    }
}

@end

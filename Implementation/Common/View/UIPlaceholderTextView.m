//
//  UIPlaceholderTextView.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/23.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "UIPlaceholderTextView.h"

@interface UIPlaceholderTextView()<UITextViewDelegate>
@property (nonatomic ,strong)UILabel * l ;
@property (nonatomic ,strong)UITextView * txtView ;
@end

@implementation UIPlaceholderTextView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.txtView];
        _txtView.maker.sidesMarginZero();
    }
    return self ;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (textView.text.length > 0) {
        _l.hidden = YES ;
    }else{
        _l.hidden = NO ;
    }
    return YES ;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _l.textColor = placeholderColor ;
}
- (void)setPlaceholderFont:(UIFont *)placeholderFont{
    _l.font = placeholderFont ;
}
- (void)setPlaceholder:(NSString *)placeholder{
    _l.text = placeholder ;
}
- (UITextView *)txtView{
    if (!_txtView) {
        _txtView = [UITextView  new];
        _txtView.delegate = self ;
        [_txtView addSubview:self.l];
        _l.maker.leftTo(_txtView, 10).topTo(_txtView, 5).widthGraterThan(44).heightEqualTo(20);
    }
    return _txtView;
}
- (UILabel *)l{
    if (!_l) {
        _l = [[UILabel alloc]init];
        _l.font = Font_15 ;
        _l.textColor = UIColor_333333 ;
    }
    return _l;
}
@end

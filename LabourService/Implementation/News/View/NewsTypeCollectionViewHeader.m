//
//  NewsTypeCollectionViewHeader.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/22.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "NewsTypeCollectionViewHeader.h"
@interface NewsTypeCollectionViewHeader ()
@property (nonatomic ,strong)UILabel  * l ;
@end
@implementation NewsTypeCollectionViewHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.l];
        _l.maker.sidesMarginZero();
    }
    return self ;
}
- (void)setTitle:(NSString *)title{
    _l.text = title ;
}
- (UILabel *)l{
    if (!_l) {
        _l = [UILabel new];
        _l.textColor = [UIColor blackColor];
        _l.font = Font_16 ;
        _l.backgroundColor = UIColor_f3f3f3 ;
    }
    return _l;
}
@end

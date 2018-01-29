//
//  NewsTypeCollectionVIewCell.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/22.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "KindCell.h"

@interface KindCell()
@property (nonatomic ,strong)UILabel * l ;
@end

@implementation KindCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.l];
        _l.maker.sidesMarginZero();
    }
    return self;
}

- (void)setKind:(WorkKind *)kind{
    _l.text = kind.realName ;
    if (kind.selected) {
        _l.backgroundColor = UIColor_0x007ed3 ;
        _l.textColor = [UIColor whiteColor];
    }else{
        _l.textColor = UIColor_333333 ;
        _l.backgroundColor = UIColor_f3f3f3;
    }
}
- (UILabel *)l{
    if (!_l) {
        _l = [UILabel new];
        _l.textColor = UIColor_333333 ;
        _l.font = Font_15 ;
        _l.textAlignment = NSTextAlignmentCenter;
        _l.backgroundColor = UIColor_f3f3f3;
    }
    return _l ;
}

@end

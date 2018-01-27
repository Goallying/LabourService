//
//  NewsTypeCollectionVIewCell.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/22.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "NewsTypeCollectionVIewCell.h"

@interface NewsTypeCollectionVIewCell()
@property (nonatomic ,strong)UILabel * l ;
@end

@implementation NewsTypeCollectionVIewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.l];
        _l.maker.sidesMarginZero();
    }
    return self;
}

- (void)setTypeModel:(NewsTypeModel *)typeModel{
    _l.text = typeModel.name ;
    if (typeModel.value == 19 || typeModel.value == 20) {
        _l.textColor = UIColor_333333 ;
    }else{
        _l.textColor = UIColor_0x007ed3 ;
    }
}

- (UILabel *)l{
    if (!_l) {
        _l = [UILabel new];
        _l.textColor = UIColor_333333 ;
        _l.font = Font_15 ;
        _l.textAlignment = NSTextAlignmentCenter;
        _l.backgroundColor = [UIColor whiteColor];
    }
    return _l ;
}

@end

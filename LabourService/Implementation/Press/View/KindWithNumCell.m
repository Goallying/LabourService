//
//  KindWithNumCell.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/29.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "KindWithNumCell.h"

@interface KindWithNumCell()
@property (nonatomic ,strong)UILabel * kindLabel ;
@property (nonatomic ,strong)UILabel * countLabel ;
@end
@implementation KindWithNumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.kindLabel];
        [self.contentView addSubview:self.countLabel];
        _kindLabel.maker.centerYTo(self.contentView, 0).leftTo(self.contentView, 0).widthGraterThan(44).heightEqualTo(20);
        _countLabel.maker.centerYTo(self.contentView, 0).rightTo(self.contentView, 0).widthGraterThan(44).heightEqualTo(20);
    }
    return self ;
}
- (void)setKind:(WorkKind *)kind{
    _kindLabel.text = [NSString stringWithFormat:@" %@  ",kind.realName] ;
    _countLabel.text = [NSString stringWithFormat:@"%ld人",kind.kindCount];
}
- (UILabel *)countLabel{
    if (!_countLabel){
        _countLabel = [UILabel new];
        _countLabel.font = Font_12 ;
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.textColor = UIColor_333333 ;
    }
    return _countLabel ;
}
- (UILabel *)kindLabel{
    if (!_kindLabel) {
        
        _kindLabel = [UILabel new];
        _kindLabel.font = Font_12;
        _kindLabel.textColor = [UIColor whiteColor];
        _kindLabel.backgroundColor = UIColor_66b2e4;
        _kindLabel.layer.cornerRadius = 3;
        _kindLabel.clipsToBounds = YES;
        _kindLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _kindLabel ;
}




@end

//
//  MainNewsCell.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/12.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "NewsSingleImageCell.h"
@interface NewsSingleImageCell ()

@property (nonatomic ,strong)UILabel * titleLabel ;
@property (nonatomic ,strong)UILabel * mediaLabel ;
//@property (nonatomic ,strong)UILabel * timeLabel ;
@property (nonatomic ,strong)UIImageView * singleImageView ;
@end

@implementation NewsSingleImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.singleImageView];
        [self.contentView addSubview:self.mediaLabel];
//        [self.contentView addSubview:self.timeLabel];
        
        _singleImageView.maker.topTo(self.contentView,16).rightTo(self.contentView,16).widthEqualTo(116).heightEqualTo(77);
        _titleLabel.maker.topTo(self.contentView, 16).leftTo(self.contentView, 16).rightTo(_singleImageView,10).heightGraterThan(1);
        _mediaLabel.maker.leftTo(self.contentView, 16).topTo(_titleLabel, 28).widthGraterThan(1).heightEqualTo(20).bottomTo(self.contentView, 15);
//        _timeLabel.maker.leftTo(_mediaLabel, 28).topTo(_titleLabel,28).widthGraterThan(1).heightEqualTo(20);
    
    }
    return self;
}
- (void)setNewsModel:(NewsModel *)newsModel{
    _titleLabel.text = newsModel.title ;
    
    File * f = newsModel.fileList.firstObject ;
    [_singleImageView sd_setImageWithURL:[NSURL URLWithString:f.url]];
    
    _mediaLabel.text = newsModel.bySource;
}
- (UIImageView *)singleImageView{
    if (!_singleImageView) {
        _singleImageView = [UIImageView new];
    }
    return _singleImageView;
}
-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = Font_16 ;
        _titleLabel.numberOfLines = 0 ;
        _titleLabel.textColor = UIColor_333333;
    }
    return _titleLabel;
}
- (UILabel *)mediaLabel{
    if (!_mediaLabel) {
        _mediaLabel = [UILabel new];
        _mediaLabel.font = Font_14 ;
        _mediaLabel.textColor = UIColor_0x007ed3;
    }
    return _mediaLabel;
}
//- (UILabel *)timeLabel{
//    if (!_timeLabel) {
//        _timeLabel = [UILabel new];
//        _timeLabel.font = Font_14 ;
//        _timeLabel.textColor = UIColor_999999;
//    }
//    return _timeLabel;
//}

@end

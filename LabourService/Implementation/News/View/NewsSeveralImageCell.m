//
//  NewsSeveralImageCell.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/15.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "NewsSeveralImageCell.h"
@interface NewsSeveralImageCell ()

@property (nonatomic ,strong)UILabel * titleLabel ;
@property (nonatomic ,strong)UILabel * mediaLabel ;
//@property (nonatomic ,strong)UILabel * timeLabel ;
@property (nonatomic ,strong)UIImageView * imageViewOne ;
@property (nonatomic ,strong)UIImageView * imageViewTwo ;
@property (nonatomic ,strong)UIImageView * imageViewThree ;

@end

@implementation NewsSeveralImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.imageViewOne];
        [self.contentView addSubview:self.imageViewTwo];
        [self.contentView addSubview:self.imageViewThree];
        [self.contentView addSubview:self.mediaLabel];
//        [self.contentView addSubview:self.timeLabel];
        
        CGFloat w = (kScreenW - 16 * 2 - 20)/3 ;
        _titleLabel.maker.topTo(self.contentView, 16).leftTo(self.contentView, 16).rightTo(self.contentView,16).heightGraterThan(1);
        
        _imageViewOne.maker.leftTo(self.contentView, 16).topTo(_titleLabel, 8).heightEqualTo(72).widthEqualTo(w);
        _imageViewTwo.maker.leftTo(_imageViewOne, 10).topTo(_titleLabel, 8).heightEqualTo(72).widthEqualTo(w);
        _imageViewThree.maker.leftTo(_imageViewTwo, 10).topTo(_titleLabel, 8).heightEqualTo(72).widthEqualTo(w);

        _mediaLabel.maker.leftTo(self.contentView, 16).topTo(_imageViewOne, 14).widthGraterThan(1).heightEqualTo(20).bottomTo(self.contentView, 15);
//        _timeLabel.maker.leftTo(_mediaLabel, 28).topTo(_imageViewTwo,14).widthGraterThan(1).heightEqualTo(20);
        
    }
    return self;
}
- (void)setNewsModel:(NewsModel *)newsModel{
    
    _titleLabel.text = newsModel.title ;
    _mediaLabel.text = newsModel.bySource;
    
    if (newsModel.fileSize >= 3) {
        File * f0 = newsModel.fileList.firstObject ;
        [_imageViewOne sd_setImageWithURL:[NSURL URLWithString:f0.url]];
        
        File * f1 = newsModel.fileList[1] ;
        [_imageViewTwo sd_setImageWithURL:[NSURL URLWithString:f1.url]];

        File * f2 = newsModel.fileList[2] ;
        [_imageViewThree sd_setImageWithURL:[NSURL URLWithString:f2.url]];
    }
}
//- (UILabel *)timeLabel{
//    if (!_timeLabel) {
//        _timeLabel = [UILabel new];
//        _timeLabel.font = Font_14 ;
//        _timeLabel.textColor = UIColor_999999;
//    }
//    return _timeLabel;
//}
- (UILabel *)mediaLabel{
    if (!_mediaLabel) {
        _mediaLabel = [UILabel new];
        _mediaLabel.font = Font_14 ;
        _mediaLabel.textColor = UIColor_0x007ed3;
    }
    return _mediaLabel;
}
- (UIImageView *)imageViewOne{
    if (!_imageViewOne) {
        _imageViewOne = [UIImageView new];
    }
    return _imageViewOne ;
}
- (UIImageView *)imageViewTwo{
    if (!_imageViewTwo) {
        _imageViewTwo = [UIImageView new];
    }
    return _imageViewTwo;
}
-(UIImageView *)imageViewThree{
    if (!_imageViewThree) {
        _imageViewThree = [UIImageView new];
    }
    return _imageViewThree ;
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

@end

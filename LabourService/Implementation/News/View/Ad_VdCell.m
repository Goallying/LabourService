//
//  Ad_VdCell.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/15.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "Ad_VdCell.h"
@interface Ad_VdCell ()

@property (nonatomic ,strong)UILabel * titleLabel ;
@property (nonatomic ,strong)UILabel * mediaLabel ;
@property (nonatomic ,strong)UILabel * tagLabel ;
@property (nonatomic ,strong)UIImageView * singleImageView ;
@property (nonatomic ,strong)UIImageView * playImageView ;
@end
@implementation Ad_VdCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.singleImageView];
        [self.contentView addSubview:self.mediaLabel];
        [self.contentView addSubview:self.tagLabel];
        
        _titleLabel.maker.topTo(self.contentView, 16).leftTo(self.contentView, 16).rightTo(self.contentView,16).heightGraterThan(1);
        _singleImageView.maker.leftTo(self.contentView, 16).topTo(_titleLabel, 8).rightTo(self.contentView, 16).heightEqualTo(185);
        _mediaLabel.maker.leftTo(self.contentView, 16).topTo(_singleImageView, 14).widthGraterThan(1).heightEqualTo(20).bottomTo(self.contentView, 10);
        _tagLabel.maker.leftTo(_mediaLabel, 16).topTo(_singleImageView, 14).widthGraterThan(35).heightEqualTo(20);
    }
    return self ;
}

- (void)setNewsModel:(NewsModel *)newsModel{
    _titleLabel.text = newsModel.title ;
    _mediaLabel.text = newsModel.bySource;
  
    File * f = newsModel.fileList.lastObject ;
    [_singleImageView sd_setImageWithURL:[NSURL URLWithString:f.url]];
    
    if (newsModel.lb == NewsType_Advertisement) {
        _tagLabel.text = @"广告";
        _tagLabel.hidden = NO ;
        _playImageView.hidden = YES;
    }else if(newsModel.lb == NewsType_Video){
        _tagLabel.text = nil ;
        _tagLabel.hidden = YES ;
        _playImageView.hidden = NO ;
    }
    
    
}

- (UIImageView *)singleImageView{
    if (!_singleImageView) {
        _singleImageView = [UIImageView new];
        _singleImageView.userInteractionEnabled = YES;
        
        _playImageView = [UIImageView new];
        _playImageView.image = [UIImage imageNamed:@"video_play_btn"];
        [_singleImageView addSubview:_playImageView];
        _playImageView.maker.centerXTo(_singleImageView, 0).centerYTo(_singleImageView, 0).widthEqualTo(50).heightEqualTo(50);
    }
    return _singleImageView;
}
- (UILabel *)tagLabel{
    if (!_tagLabel) {
        _tagLabel = [UILabel new];
        _tagLabel.font = Font_14 ;
        _tagLabel.textColor = UIColor_0x007ed3;
        _tagLabel.layer.cornerRadius = 2 ;
        _tagLabel.layer.borderWidth = 0.5 ;
        _tagLabel.textAlignment = NSTextAlignmentCenter ;
        _tagLabel.layer.borderColor = UIColor_0x007ed3.CGColor ;
        
    }
    return _tagLabel;
}
-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = Font_16 ;
        _titleLabel.numberOfLines = 0 ;
        _titleLabel.textColor = UIColor_333333;
        _tagLabel.backgroundColor = [UIColor redColor];
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
@end

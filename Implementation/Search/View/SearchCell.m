//
//  SearchCell.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/16.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "SearchCell.h"
#import "TagView.h"
@interface SearchCell()

@property (nonatomic ,strong)UIImageView * headerImageView ;
@property (nonatomic ,strong)UILabel *nameLabel ;
@property (nonatomic ,strong)UILabel *detailLabel ;
@property (nonatomic ,strong)UIImageView * locImageView ;
@property (nonatomic ,strong)TagView * tagView ;
@property (nonatomic ,strong)UILabel *locLabel ;

@end

@implementation SearchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.headerImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.tagView];
        [self.contentView addSubview:self.locImageView];
        [self.contentView addSubview:self.locLabel];
        
        _headerImageView.maker.centerYTo(self.contentView, 0).leftTo(self.contentView, 16).widthEqualTo(64).heightEqualTo(64);
        _nameLabel.maker.leftTo(_headerImageView, 16).topTo(self.contentView, 20).widthGraterThan(1).heightEqualTo(15);
        _detailLabel.maker.topTo(_nameLabel, 8).leftTo(_headerImageView, 16).widthGraterThan(1).heightEqualTo(15);
        _tagView.maker.leftTo(_headerImageView, 16).topTo(_detailLabel, 8).rightTo(self.contentView, 16).heightEqualTo(1);
        _locImageView.maker.leftTo(_headerImageView, 16).topTo(_tagView, 8).widthEqualTo(13).heightEqualTo(16);
        _locLabel.maker.leftTo(_locImageView, 5).topTo(_tagView, 8).rightTo(self.contentView, 16).heightGraterThan(1).bottomTo(self.contentView, 20);

        
    }
    return  self ;
}

- (void)setSearchModel:(SearchListModel *)searchModel{
    
    _searchModel = searchModel ;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:searchModel.headUrl]];
    _nameLabel.text = searchModel.userName ;
    
    NSString * gender = searchModel.gender == 1?@"男":@"女" ;
    _detailLabel.text = [NSString stringWithFormat:@"%@,%lu周岁",gender ,searchModel.age];
    
    NSMutableArray * tags = [NSMutableArray array];
    for (NSDictionary * dic in searchModel.realName) {
        [tags addObject:dic[@"realname"]];
    }
    _tagView.tags = tags ;
//    _tagView.heightConstraint.constant = _searchModel.searchTagsHeight ;
    _tagView.heightConstraint.constant = _tagView.searchTagsHeight ;
    _locLabel.text = searchModel.address ;
}

- (void)phoneClick{
    
}
- (UILabel *)locLabel{
    if (!_locLabel) {
        _locLabel  = [UILabel new];
        _locLabel.numberOfLines = 0 ;
        _locLabel.textColor = UIColor_999999 ;
        _locLabel.font = Font_14 ;
    }
    return _locLabel ;
}
- (TagView *)tagView{
    if (!_tagView) {
        _tagView = [TagView new];
    }
    return _tagView ;
}
- (UIImageView *)locImageView{
    if (!_locImageView) {
        _locImageView = [UIImageView new];
        _locImageView.image = [UIImage imageNamed:@"location_icon_gray"];
    }
    return _locImageView ;
}
- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.textColor = UIColor_999999;
        _detailLabel.font = Font_14 ;
    }
    return _detailLabel ;
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = UIColor_333333 ;
        _nameLabel.font = Font_16 ;
    }
    return _nameLabel ;
}
- (UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]init];
        _headerImageView.layer.cornerRadius = 32;
        _headerImageView.clipsToBounds = YES;
    }
    return _headerImageView;
}

@end

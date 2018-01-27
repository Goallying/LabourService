//
//  SearchCell.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/16.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "AppointmentListCell.h"
#import "TagView.h"
@interface AppointmentListCell()

@property (nonatomic ,strong)UILabel *nameLabel ;
@property (nonatomic ,strong)UILabel *detailLabel ;
@property (nonatomic ,strong)UILabel * timeLabel ;
@property (nonatomic ,strong)TagView * tagView ;
@property (nonatomic ,strong)UIButton * phoneBtn ;
@property (nonatomic ,strong)UILabel * contactLabel ;

@end

@implementation AppointmentListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.tagView];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.phoneBtn];
        [self.contentView addSubview:self.contactLabel];
        
        _phoneBtn.maker.centerYTo(self.contentView, 0).rightTo(self.contentView, 16).widthEqualTo(48).heightEqualTo(48);
        _nameLabel.maker.leftTo(self.contentView, 16).topTo(self.contentView, 20).rightTo(_phoneBtn, 0).heightGraterThan(15);
        _tagView.maker.leftTo(self.contentView, 16).topTo(_nameLabel, 8).rightTo(_phoneBtn, 0).heightEqualTo(1);
        _detailLabel.maker.topTo(_tagView, 8).leftTo(self.contentView, 16).heightGraterThan(15).rightTo(_phoneBtn, 0);
        _timeLabel.maker.topTo(_detailLabel, 8).leftTo(self.contentView, 16).widthGraterThan(1).heightEqualTo(15).bottomTo(self.contentView, 20);
        _contactLabel.maker.topTo(_phoneBtn, 8).centerXTo(_phoneBtn, 0).widthGraterThan(44).heightEqualTo(15);
        
    }
    return  self ;
}

- (void)setSearchModel:(SearchListModel *)searchModel{
    
    _searchModel = searchModel ;
    _nameLabel.text = searchModel.title ;
    _detailLabel.text = searchModel.address;
    _timeLabel.text = searchModel.createDate ;
    
    NSMutableArray * tags = [NSMutableArray array];
    for (NSDictionary * dic in searchModel.realName) {
        [tags addObject:dic[@"realname"]];
    }
    _tagView.tags = tags ;
//    _tagView.heightConstraint.constant = _searchModel.appointmentTagsHeight ;
    _tagView.heightConstraint.constant = _tagView.appointmentTagsHeight ;
}
- (void)phoneClick{
    
}
-(UILabel *)contactLabel{
    if (!_contactLabel) {
        _contactLabel = [UILabel new];
        _contactLabel.text = @"请联系我";
        _contactLabel.textColor = UIColor_666666;
        _contactLabel.font = Font_14 ;
    }
    return _contactLabel ;
}
- (UIButton *)phoneBtn{
    if (!_phoneBtn) {
        _phoneBtn = [UIButton new];
        [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"phone_btn"] forState:UIControlStateNormal];
        [_phoneBtn addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneBtn ;
}
- (TagView *)tagView{
    if (!_tagView) {
        _tagView = [TagView new];
    }
    return _tagView ;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = UIColor_999999;
        _timeLabel.font = Font_12 ;
    }
    return _timeLabel ;
}
- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.textColor = UIColor_999999;
        _detailLabel.font = Font_14 ;
        _detailLabel.numberOfLines = 0 ;
    }
    return _detailLabel ;
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = UIColor_333333 ;
        _nameLabel.font = Font_16 ;
        _nameLabel.numberOfLines = 0 ;
    }
    return _nameLabel ;
}

@end


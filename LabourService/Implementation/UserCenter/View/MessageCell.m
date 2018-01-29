//
//  MessageCell.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/29.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "MessageCell.h"
@interface MessageCell()
@property (nonatomic ,strong)UIImageView * messageIcon ;
@property (nonatomic ,strong)UILabel * titleL ;
@property (nonatomic ,strong)UILabel * timeLabel ;
@property (nonatomic ,strong)UILabel * contentLabel ;
@end
@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.messageIcon];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.contentLabel];
        
        _messageIcon.maker.centerYTo(self.contentView, 0).leftTo(self.contentView, 16).widthEqualTo(30).heightEqualTo(30);
        _timeLabel.maker.topTo(self.contentView, 16).rightTo(self.contentView, 16).widthGraterThan(44).heightEqualTo(20);

        _titleL.maker.topTo(self.contentView, 16).leftTo(_messageIcon, 20).rightTo(_timeLabel, 10).heightEqualTo(20);
        _contentLabel.maker.leftBaselineTo(_titleL).topTo(_titleL, 8).heightGraterThan(20).bottomTo(self.contentView, 16).rightTo(self.contentView, 16);
        
    }
    return  self ;
}

- (void)setMessage:(MessageModel *)message {
    _titleL.text = message.messageTitle ;
    _timeLabel.text = message.sendTime ;
    _contentLabel.text = message.messageContent;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = UIColor_999999 ;
        _contentLabel.font = Font_12 ;
        _contentLabel.numberOfLines = 0 ;
    }
    return _contentLabel ;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = UIColor_999999;
        _timeLabel.font = Font_12 ;
    }
    return _timeLabel ;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [UILabel new];
        _titleL.textColor = UIColor_333333 ;
        _titleL.font = Font_15 ;
    }
    return _titleL ;
}
- (UIImageView *)messageIcon{
    if (!_messageIcon) {
        _messageIcon = [UIImageView new];
        _messageIcon.image = [UIImage imageNamed:@"message_icon"];
    }
    return _messageIcon ;
}

@end

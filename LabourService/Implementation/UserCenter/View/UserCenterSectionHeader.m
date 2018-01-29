//
//  UserCenterSectionHeader.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/18.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "UserCenterSectionHeader.h"

@implementation UserCenterSectionHeader

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor_f3f3f3 ;
    }
    return self ;
}

- (void)leftClick{
    if (self.clickOperation) {
        self.clickOperation(Click_Left);
    }
}
- (void)rightClick{
    if (self.clickOperation) {
        self.clickOperation(Click_Right);
    }
}

- (void)layoutSubviews{
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    UIImageView * profileImageView = [UIImageView new];
    profileImageView.image = [UIImage imageNamed:@"ucenter_perfect_info_icon"];
    [backView addSubview:profileImageView];
    
    UILabel * leftTitle = [UILabel new];
    leftTitle.textColor = UIColor_333333 ;
    leftTitle.text = @"完善资料";
    [backView addSubview:leftTitle];
    leftTitle.maker.centerXTo(backView, -kScreenW/4).centerYTo(backView, 0).widthGraterThan(44).heightEqualTo(20);
    profileImageView.maker.centerYTo(leftTitle, 0).rightTo(leftTitle, 5).widthEqualTo(30).heightEqualTo(20);
    
    UIButton * leftClearBtn = [UIButton new];
    leftClearBtn.backgroundColor = [UIColor clearColor];
    [leftClearBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:leftClearBtn];
    leftClearBtn.maker.leftTo(backView, 0).topTo(backView, 0).bottomTo(backView, 0).widthEqualTo(kScreenW/2);
    //
    UIView * seperator = [UIView new];
    seperator.backgroundColor = UIColor_f3f3f3 ;
    [backView addSubview:seperator];
    seperator.maker.centerXTo(backView, 0).topTo(backView, 5).widthEqualTo(1).heightEqualTo(40);
    
    UIImageView * codeImageView = [UIImageView new];
    codeImageView.image = [UIImage imageNamed:@"ucenter_invitation_download"];
    [backView addSubview:codeImageView];
    
    UILabel * rightTitle = [UILabel new];
    rightTitle.textColor = UIColor_333333 ;
    rightTitle.text = @"邀请下载";
    [backView addSubview:rightTitle];
    rightTitle.maker.centerXTo(backView, kScreenW/4).centerYTo(backView, 0).widthGraterThan(44).heightEqualTo(20);
    codeImageView.maker.centerYTo(rightTitle, 0).rightTo(rightTitle, 5).widthEqualTo(30).heightEqualTo(20);
    
    UIButton * rightClearBtn = [UIButton new];
    rightClearBtn.backgroundColor = [UIColor clearColor];
    [rightClearBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:rightClearBtn];
    rightClearBtn.maker.rightTo(backView, 0).topTo(backView, 0).bottomTo(backView, 0).widthEqualTo(kScreenW/2);
    
}

@end

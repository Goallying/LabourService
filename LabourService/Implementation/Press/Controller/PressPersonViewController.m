//
//  PressViewController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/11.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "PressPersonViewController.h"
#import "PressViewModel.h"
#import "UIPlaceholderTextView.h"
#import "TagView.h"
#import "SelectKindsViewController.h"
#import "AreaPicker.h"
@interface PressPersonViewController ()
@property (nonatomic ,strong) UIScrollView * scrollView  ;
@property (nonatomic ,strong)UIView * contentV  ;
@property (nonatomic ,strong)UIView * kindsView  ;
@property (nonatomic ,strong)UIButton * locButton  ;
@property (nonatomic ,strong)UITextView * txtView;
@property (nonatomic ,strong)UILabel * placeholder ;
@property (nonatomic ,strong)TagView * tagView ;
@property (nonatomic ,strong)NSArray * kinds  ;
@property (nonatomic ,copy)NSString * selectedAreaCode ;
@end

@implementation PressPersonViewController
- (NSString *)title{
    return @"人才发布";
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES ;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self layoutSubviews];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateUserInfo) name:NOTICE_UPDATE_USER_INFO object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidChange) name:UITextViewTextDidChangeNotification object:nil];

}
- (void)updateUserInfo{
    [_locButton setTitle:User_Info.city forState:UIControlStateNormal];

}
- (void)textViewDidChange{
    _placeholder.hidden = _txtView.text.length > 0;
}
- (void)press {
    
    [PressViewModel pressPersonToken:User_Info.token
                         intro:_txtView.text
                                addr:User_Info.formattedAddress addrID:self.selectedAreaCode
                         kinds:_kinds
                       success:^(NSString *msg) {
    
        [CToast showWithText:msg];
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];
    }];
    
}
- (void)locClick {
    [AreaPicker pickerSelectfinish:^(Area *a1, Area *a2) {
        _selectedAreaCode = a2.ID ;
        [_locButton setTitle:a2.areaname forState:UIControlStateNormal];
    }];
}
- (void)addKind {
    SelectKindsViewController * selectVC  = [SelectKindsViewController new];
    selectVC.maxSelectCount = 3 ;
    [selectVC setFinishSelect:^(NSArray *kinds) {
        
        _kinds = [kinds copy];
        NSMutableArray * tags = [NSMutableArray array];
        for (WorkKind * k in kinds) {
            [tags addObject:k.realName];
        }
        _tagView.tags = tags ;
        CGFloat pressH =  _tagView.pressTagsHeight ;
        CGFloat h = 30 + 44 * 5 + 30 + 100 + 20 + 40 + pressH ;
        
        _tagView.heightConstraint.constant = pressH ;
        _scrollView.contentSize = CGSizeMake(kScreenW,h) ;
        _contentV.heightConstraint.constant = h;
        _kindsView.heightConstraint.constant = 44 + pressH ;
        
    }];
    [self.navigationController pushViewController:selectVC animated:YES];
}
- (NSString *)selectedAreaCode{
    if (!_selectedAreaCode) {
        _selectedAreaCode = User_Info.adcode ;
    }
    return _selectedAreaCode ;
}

- (void)layoutSubviews {
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
    _scrollView.maker.sidesMarginZero();
    
    _contentV = [UIView new];
//    _contentV.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_contentV];
    _contentV.maker.leftTo(_scrollView,0).rightTo(_scrollView, 0).widthEqualTo(kScreenW).heightEqualTo(kScreenH);
    
    UILabel * locTitle = [[UILabel alloc]init];
    locTitle.text = @"当前定位";
    locTitle.font = Font_12 ;
    locTitle.textColor = UIColor_333333 ;
    [_contentV addSubview:locTitle];
    locTitle.maker.topTo(_contentV, 10).leftTo(_contentV, 16).widthGraterThan(44).heightEqualTo(20);
    
    _locButton = [UIButton new];
    [_locButton.titleLabel setFont:Font_12];
    [_locButton setTitleColor:UIColor_333333 forState:UIControlStateNormal];
    [_locButton setImage:[UIImage imageNamed:@"location_icon_green"] forState:UIControlStateNormal];
    [_locButton setTitle:User_Info.city?User_Info.city:@"" forState:UIControlStateNormal];
    [_locButton setImagePosition:ImagePositionLeft spacing:0];
    [_locButton addTarget:self action:@selector(locClick) forControlEvents:UIControlEventTouchUpInside];
    [_contentV addSubview:_locButton];
    _locButton.maker.leftTo(locTitle, 10).centerYTo(locTitle, 0).widthGraterThan(44).heightEqualTo(30);
    //
    UILabel * nameT = [[UILabel alloc]init];
    nameT.text = @"姓名";
    nameT.font = Font_15 ;
    nameT.textColor = UIColor_333333 ;
    [_contentV addSubview:nameT];
    nameT.maker.topTo(_locButton, 0).leftTo(_contentV, 16).widthGraterThan(44).heightEqualTo(44);
    
    UILabel * nameL = [[UILabel alloc]init];
    nameL.text = User_Info.realName?User_Info.realName:User_Info.userName;
    nameL.font = Font_15 ;
    nameL.textColor = UIColor_333333 ;
    nameL.textAlignment = NSTextAlignmentRight;
    [_contentV addSubview:nameL];
    nameL.maker.centerYTo(nameT, 0).rightTo(_contentV, 16).widthGraterThan(44).heightEqualTo(44);
    
    UIView * s1 = [UIView new];
    s1.backgroundColor = UIColor_d7d7d7 ;
    [_contentV addSubview:s1];
    s1.maker.leftTo(_contentV, 16).rightTo(_contentV, 0).heightEqualTo(1).topTo(nameL, 0);
    //
    UILabel * phoneT = [[UILabel alloc]init];
    phoneT.text = @"手机号";
    phoneT.font = Font_15 ;
    phoneT.textColor = UIColor_333333 ;
    [_contentV addSubview:phoneT];
    phoneT.maker.topTo(s1, 0).leftTo(_contentV, 16).widthGraterThan(44).heightEqualTo(44);
    
    UILabel * phoneL = [[UILabel alloc]init];
    phoneL.text = User_Info.userName;
    phoneL.font = Font_15 ;
    phoneL.textColor = UIColor_333333 ;
    phoneL.textAlignment = NSTextAlignmentRight;
    [_contentV addSubview:phoneL];
    phoneL.maker.centerYTo(phoneT, 0).rightTo(_contentV, 16).widthGraterThan(44).heightEqualTo(44);
    
    UIView * s2 = [UIView new];
    s2.backgroundColor = UIColor_d7d7d7 ;
    [_contentV addSubview:s2];
    s2.maker.leftTo(_contentV, 16).rightTo(_contentV, 0).heightEqualTo(1).topTo(phoneL, 0);
    //
    UILabel * ageT = [[UILabel alloc]init];
    ageT.text = @"年龄";
    ageT.font = Font_15 ;
    ageT.textColor = UIColor_333333 ;
    [_contentV addSubview:ageT];
    ageT.maker.topTo(s2, 0).leftTo(_contentV, 16).widthGraterThan(44).heightEqualTo(44);
    
    UILabel * ageL = [[UILabel alloc]init];
    ageL.text = [NSString stringWithFormat:@"%lu",User_Info.age];
    ageL.font = Font_15 ;
    ageL.textColor = UIColor_333333 ;
    ageL.textAlignment = NSTextAlignmentRight;
    [_contentV addSubview:ageL];
    ageL.maker.centerYTo(ageT, 0).rightTo(_contentV, 16).widthGraterThan(44).heightEqualTo(44);
    
    UIView * s3 = [UIView new];
    s3.backgroundColor = UIColor_d7d7d7 ;
    [_contentV addSubview:s3];
    s3.maker.leftTo(_contentV, 16).rightTo(_contentV, 0).heightEqualTo(1).topTo(ageL, 0);
    //
    _kindsView = [UIView new];
    [_contentV addSubview:_kindsView];
    _kindsView.maker.leftTo(_contentV, 16).topTo(s3, 0).rightTo(_contentV, 16).heightEqualTo(44);
    
    UILabel * kindT = [[UILabel alloc]init];
    kindT.text = @"添加工种";
    kindT.font = Font_15 ;
    kindT.textColor = UIColor_333333 ;
    [_kindsView addSubview:kindT];
    kindT.maker.topTo(_kindsView, 0).leftTo(_kindsView, 0).widthGraterThan(44).heightEqualTo(44);
    
    UIButton * add = [UIButton new];
    [add setBackgroundColor:UIColor_f3f3f3];
    [add setImage:[UIImage imageNamed:@"add_channel_icon"] forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addKind) forControlEvents:UIControlEventTouchUpInside];
    [_kindsView addSubview:add];
    add.maker.centerYTo(kindT, 0).widthEqualTo(30).heightEqualTo(30).rightTo(_kindsView, 0);
    
    _tagView = [[TagView alloc]init];
    [_kindsView addSubview:_tagView];
    _tagView.maker.topTo(kindT, 0).leftTo(_kindsView, 0).rightTo(_kindsView, 0).heightEqualTo(1);

    //
    UILabel * introduceT = [[UILabel alloc]init];
    introduceT.text = @"个人简介";
    introduceT.font = Font_15 ;
    introduceT.textColor = UIColor_333333 ;
    [_contentV addSubview:introduceT];
    introduceT.maker.topTo(_kindsView, 0).leftTo(_contentV, 16).widthGraterThan(44).heightEqualTo(44);
    
    _txtView = [[UITextView alloc]init];
    _txtView.layer.borderColor = UIColor_d7d7d7.CGColor ;
    _txtView.layer.borderWidth = 0.5 ;
    [_contentV addSubview:_txtView];
    _txtView.maker.leftTo(_contentV, 16).rightTo(_contentV, 16).topTo(introduceT, 10).heightEqualTo(100);
    
    _placeholder = [UILabel new];
    _placeholder = [[UILabel alloc]init];
    _placeholder.font = Font_15 ;
    _placeholder.textColor = UIColor_333333 ;
    _placeholder.text = @"请输入项目简介";
    [_txtView addSubview:_placeholder];
    _placeholder.maker.leftTo(_txtView, 10).topTo(_txtView, 5).widthGraterThan(44).heightEqualTo(20);
    
    UIButton * press = [[UIButton alloc]init];
    press.layer.cornerRadius = 5 ;
    [press setTitle:@"发布" forState:UIControlStateNormal];
    [press setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [press setBackgroundColor:UIColor_0x007ed3];
    [press addTarget:self action:@selector(press) forControlEvents:UIControlEventTouchUpInside];
    [_contentV addSubview:press];
    press.maker.topTo(_txtView, 20).leftTo(_contentV, 16).rightTo(_contentV, 16).heightEqualTo(40);
    
    CGFloat h = 30 + 44 * 5 + 30 + 100 + 20 + 40  ;
    _scrollView.contentSize = CGSizeMake(kScreenW,h) ;
    _contentV.heightConstraint.constant = h;
}





@end

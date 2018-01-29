//
//  SelectKindsViewController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/23.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "SelectKindsViewController.h"
#import "SideSelectView.h"
#import "PressViewModel.h"
#import "CommonPicker.h"
@interface SelectKindsViewController ()
@property (nonatomic ,strong)NSArray * kinds ;
@property (nonatomic ,strong)UIButton * locButton  ;
@property (nonatomic ,strong)NSMutableArray * nums ;
@end

@implementation SelectKindsViewController

- (NSString *)title{
    return @"工种选中";
}
- (NSArray<UIBarButtonItem *> *)rightBarButtonItems{
    
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"correct_white"] style:UIBarButtonItemStylePlain target:self action:@selector(sure)];
    barItem.tintColor = [UIColor whiteColor];
    return @[barItem];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getKindsList:^(NSArray *source) {
        [self layoutSubview:source];
    }];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateUserInfo) name:NOTICE_UPDATE_USER_INFO object:nil];
   
}
- (void)updateUserInfo{
    [_locButton setTitle:User_Info.city forState:UIControlStateNormal];
}

- (void)getKindsList:(void(^)(NSArray * source))finish{
    
    [PressViewModel getworkKindsListSuccess:^(NSString *msg, NSArray *kinds) {
        finish(kinds);
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];
    }];
}
- (void)sure {
    
    if (self.finishSelect && _kinds && _kinds.count > 0) {
        self.finishSelect(_kinds);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)layoutSubview:(NSArray *)source{
    
    UILabel * locTitle = [[UILabel alloc]init];
    locTitle.text = @"当前定位";
    locTitle.font = Font_12 ;
    locTitle.textColor = UIColor_333333 ;
    [self.view addSubview:locTitle];
    locTitle.maker.topTo(self.view, 10).leftTo(self.view, 16).widthGraterThan(44).heightEqualTo(20);
    
    _locButton = [UIButton new];
    [_locButton.titleLabel setFont:Font_12];
    [_locButton setTitleColor:UIColor_333333 forState:UIControlStateNormal];
    [_locButton setImage:[UIImage imageNamed:@"location_icon_green"] forState:UIControlStateNormal];
    [_locButton setTitle:User_Info.city?User_Info.city:@"" forState:UIControlStateNormal];
    [_locButton setImagePosition:ImagePositionLeft spacing:0];
    [self.view addSubview:_locButton];
    _locButton.maker.leftTo(locTitle, 10).centerYTo(locTitle, 0).widthGraterThan(44).heightEqualTo(30);
    //
    SideSelectView * v = [[SideSelectView alloc]initWithSource:source finish:^(NSArray *selected) {
        _kinds = selected ;
        if (self.selectKindMaxPersonNumLimited && selected.count > 0) {
            [CommonPicker pickerSource:@[self.nums] finish:^(NSString *s1, NSString *s2) {
                WorkKind * k = selected.lastObject ;
                k.kindCount = s1.integerValue == 0?1:s1.integerValue ;
            }];
        }else{
            if (self.maxSelectCount == 1 && self.finishSelect) {
                self.finishSelect(_kinds);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
     
    }];
    if (self.maxSelectCount > 0) {
        v.maxSelectCount = self.maxSelectCount ;
    }
    [self.view addSubview:v];
    v.maker.topTo(_locButton, 0).leftTo(self.view, 0).rightTo(self.view, 0).bottomTo(self.view, 0);
}
- (NSMutableArray *)nums{
    if (!_nums) {
        _nums = [NSMutableArray array];
        for (NSInteger i = 1; i < 101; i++) {
            NSString * s = [NSString stringWithFormat:@"%ld",(long)i];
            [_nums addObject:s];
        }
    }
    return _nums ;
}

@end

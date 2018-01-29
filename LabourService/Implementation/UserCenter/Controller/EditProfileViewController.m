//
//  EditProfileViewController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/19.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "EditProfileViewController.h"
#import "CommonPicker.h"
#import "UserCenterViewModel.h"
#import "TZImagePickerController.h"
#import "TagView.h"
#import "SelectKindsViewController.h"
@interface EditProfileViewController ()<
TZImagePickerControllerDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate>
@property (nonatomic ,strong)UIView * backView  ;
@property (nonatomic ,strong)UIButton * headerBtn ;
@property (nonatomic ,strong)UITextField * nameTF;
@property (nonatomic ,strong)UIButton * genderBtn ;
@property (nonatomic ,strong)UIButton * ageBtn ;
@property (nonatomic ,strong)UIButton * areaBtn;
@property (nonatomic ,strong)TagView * tagV  ;
@property (nonatomic ,strong)UITextField * phoneTF ;
@property (nonatomic ,strong)NSArray * cities ;
@property (nonatomic ,strong)UIImagePickerController * imagePickerVc ;
@property (nonatomic ,strong)UIImage * sImage ;
@property (nonatomic ,strong)NSArray * sKinds ;
@end

@implementation EditProfileViewController
- (NSString *)title{
    return @"编辑资料";
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO ;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutSubviews];
    [self dataRequest];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateUserInfo) name:NOTICE_UPDATE_USER_INFO object:nil];

}
- (void)sure {

    [UserCenterViewModel updateUserInfo:User_Info.token
                                 header:_sImage name:_nameTF.text
                                 gender:_genderBtn.currentTitle
                                    age:_ageBtn.currentTitle
                                  kinds:_sKinds
                                success:^(NSString *msg, id obj) {
        [AppManager saveLocalUserInfo:obj];
        [CToast showWithText:msg];
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];

    }];
    
}
- (void)updateUserInfo{
    [_areaBtn setTitle:User_Info.city forState:UIControlStateNormal];
    [self dataRequest];
}
- (void)dataRequest {
    
    if (!User_Info.adcode || User_Info.adcode.length < 2) {
        return;
    }
    NSString * code = [[User_Info.adcode substringToIndex:2] stringByAppendingString:@"0000"];
    [UserCenterViewModel getCityList:code success:^(NSString *msg, NSArray *cities) {
        _cities = cities ;
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];
    }];
}
- (void)headerClick {
    
    UIAlertController * alt = [[UIAlertController alloc]init];
    UIAlertAction * album = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        TZImagePickerController * imagePicker = [[TZImagePickerController alloc]initWithMaxImagesCount:1 columnNumber:1 delegate:self];
        [imagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            
            _sImage = photos.lastObject ;
            [_headerBtn setBackgroundImage:photos.lastObject forState:UIControlStateNormal];
        }];
        [self presentViewController:imagePicker animated:YES completion:nil];

    }];
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        }
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alt addAction:album];
    [alt addAction:camera];
    [alt addAction:cancel];
    [self presentViewController:alt animated:YES completion:nil];
    
}
- (void)genderClick {
    
    [CommonPicker pickerSource:@[@[@"男",@"女"]] finish:^(NSString *s1, NSString *s2) {
        if (!s1 || s1.length == 0) {
            return ;
        }
        [_genderBtn setTitle:s1 forState:UIControlStateNormal];
    }];
}
- (void)ageClick{
    
    NSMutableArray * ages = [NSMutableArray array];
    for (NSInteger i = 1; i < 101; i++) {
        NSString * s = [NSString stringWithFormat:@"%ld",(long)i];
        [ages addObject:s];
    }
    [CommonPicker pickerSource:@[ages] finish:^(NSString *s1, NSString *s2) {
        if (!s1 || s1.length == 0) {
            return ;
        }
        [_ageBtn setTitle:s1 forState:UIControlStateNormal];
    }];
}
- (void)areaClick {
    
    NSMutableArray * citiesNames = [NSMutableArray array];
    for (CityModel * city in _cities) {
        [citiesNames  addObject:city.areaname];
    }
    [CommonPicker pickerSource:@[citiesNames] finish:^(NSString *s1, NSString *s2) {
        if (!s1 || s1.length == 0) {
            return ;
        }
        [_areaBtn setTitle:[User_Info.city stringByAppendingString:s1] forState:UIControlStateNormal];
    }];
}
- (void)addKind {
    SelectKindsViewController * kind = [SelectKindsViewController new];
    [kind setFinishSelect:^(NSArray *kinds) {
        
        _sKinds = [kinds copy];
        NSMutableArray * tags = [NSMutableArray array];
        for (WorkKind * k in kinds) {
            [tags addObject:k.realName];
        }
        _tagV.tags = tags ;
        _tagV.heightConstraint.constant = _tagV.pressTagsHeight;
        _backView.heightConstraint.constant = 50 * 7 + 10 + 5 + 5 + 10 + _tagV.pressTagsHeight ;
    }];
    [self.navigationController pushViewController:kind animated:YES];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        _sImage = image ;
        [_headerBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews {
    
    _backView = [UIView new];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
       //
    UILabel * headerL = [UILabel new];
    headerL.text = @"头像";
    [_backView addSubview:headerL];
    headerL.maker.leftTo(_backView, 16).topTo(_backView,22).widthEqualTo(80).heightEqualTo(20);
    
    _headerBtn = [UIButton new];
    _headerBtn.layer.cornerRadius = 24 ;
    _headerBtn.clipsToBounds = YES ;
    [_headerBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:User_Info.headUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultHeader"]];
    [_headerBtn addTarget:self action:@selector(headerClick) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_headerBtn];
    _headerBtn.maker.leftTo(headerL, 20).centerYTo(headerL, 0).heightEqualTo(48).widthEqualTo(48);
    
    UIView * s1 = [UIView new];
    s1.backgroundColor = UIColor_d7d7d7 ;
    [_backView addSubview:s1];
    s1.maker.topTo(_headerBtn , 8).leftTo(_backView, 16).rightTo(_backView, 0).heightEqualTo(1);
    //
    UILabel * nameL = [UILabel new];
    nameL.text = @"用户名";
    [_backView addSubview:nameL];
    nameL.maker.leftTo(_backView, 16).topTo(s1,15).widthEqualTo(80).heightEqualTo(20);
    
    _nameTF = [UITextField new];
    _nameTF.textColor = UIColor_666666 ;
    _nameTF.text = User_Info.realName?User_Info.realName:User_Info.userName ;
    [_backView addSubview:_nameTF];
    _nameTF.maker.centerYTo(nameL ,0).leftTo(nameL, 20).rightTo(_backView,16).heightEqualTo(50);
    
    UIView * s2 = [UIView new];
    s2.backgroundColor = UIColor_d7d7d7 ;
    [_backView addSubview:s2];
    s2.maker.topTo(_nameTF , 0).leftTo(_backView, 16).rightTo(_backView, 0).heightEqualTo(1);
    //
    UILabel * genderL = [UILabel new];
    genderL.text = @"性别";
    [_backView addSubview:genderL];
    genderL.maker.leftTo(_backView, 16).topTo(s2,15).widthEqualTo(80).heightEqualTo(20);
    
    _genderBtn = [UIButton new];
    [_genderBtn setTitleColor:UIColor_333333 forState:UIControlStateNormal];
    _genderBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    NSString * gender = User_Info.gender == 1?@"男":@"女";
    [_genderBtn setTitle:gender forState:UIControlStateNormal];
    [_genderBtn addTarget:self action:@selector(genderClick) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_genderBtn];
    _genderBtn.maker.leftTo(genderL, 20).centerYTo(genderL, 0).rightTo(_backView, 16).heightEqualTo(50);
    
    UIImageView * indicator1 = [UIImageView new];
    indicator1.image = [UIImage imageNamed:@"more"];
    [_backView addSubview:indicator1];
    indicator1.maker.rightTo(_backView, 16).centerYTo(genderL, 0).widthEqualTo(20).heightEqualTo(20);
    
    UIView * s3 = [UIView new];
    s3.backgroundColor = UIColor_d7d7d7 ;
    [_backView addSubview:s3];
    s3.maker.topTo(_genderBtn , 0).leftTo(_backView, 16).rightTo(_backView, 0).heightEqualTo(1);
    //
    UILabel * ageL = [UILabel new];
    ageL.text = @"年龄";
    [_backView addSubview:ageL];
    ageL.maker.leftTo(_backView, 16).topTo(s3,15).widthEqualTo(80).heightEqualTo(20);
    
    _ageBtn = [UIButton new];
    [_ageBtn setTitleColor:UIColor_333333 forState:UIControlStateNormal];
    _ageBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    NSString * age = User_Info.age?[NSString stringWithFormat:@"%ld",(long)User_Info.age]:@"";
    [_ageBtn setTitle:age forState:UIControlStateNormal];
    [_ageBtn addTarget:self action:@selector(ageClick) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_ageBtn];
    _ageBtn.maker.leftTo(ageL, 20).centerYTo(ageL, 0).rightTo(_backView, 16).heightEqualTo(50);
    
    UIImageView * indicator_age = [UIImageView new];
    indicator_age.image = [UIImage imageNamed:@"more"];
    [_backView addSubview:indicator_age];
    indicator_age.maker.rightTo(_backView, 16).centerYTo(ageL, 0).widthEqualTo(20).heightEqualTo(20);
    
    UIView * s_age = [UIView new];
    s_age.backgroundColor = UIColor_d7d7d7 ;
    [_backView addSubview:s_age];
    s_age.maker.topTo(_ageBtn , 0).leftTo(_backView, 16).rightTo(_backView, 0).heightEqualTo(1);
    //
    UILabel * areaL = [UILabel new];
    areaL.text = @"地区";
    [_backView addSubview:areaL];
    areaL.maker.leftTo(_backView, 16).topTo(s_age,15).widthEqualTo(80).heightEqualTo(20);
    
    _areaBtn = [UIButton new];
    [_areaBtn setTitleColor:UIColor_333333 forState:UIControlStateNormal];
    _areaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    [_areaBtn setTitle:User_Info.city?User_Info.city:@"" forState:UIControlStateNormal];
    [_areaBtn addTarget:self action:@selector(areaClick) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:_areaBtn];
    _areaBtn.maker.leftTo(areaL, 20).centerYTo(areaL, 0).rightTo(_backView, 16).heightEqualTo(50);
    
    UIImageView * indicator2 = [UIImageView new];
    indicator2.image = [UIImage imageNamed:@"more"];
    [_backView addSubview:indicator2];
    indicator2.maker.rightTo(_backView, 16).centerYTo(areaL, 0).widthEqualTo(20).heightEqualTo(20);
    
    UIView * s4 = [UIView new];
    s4.backgroundColor = UIColor_d7d7d7 ;
    [_backView addSubview:s4];
    s4.maker.topTo(_areaBtn , 0).leftTo(_backView, 16).rightTo(_backView, 0).heightEqualTo(1);
    //
    UILabel * kindL = [UILabel new];
    kindL.text = @"工种";
    [_backView addSubview:kindL];
    kindL.maker.leftTo(_backView, 16).topTo(s4,15).widthEqualTo(80).heightEqualTo(20);
    
    UIImageView * indicator3 = [UIImageView new];
    indicator3.image = [UIImage imageNamed:@"add_channel_icon"];
    [_backView addSubview:indicator3];
    indicator3.maker.rightTo(_backView, 16).centerYTo(kindL, 0).widthEqualTo(20).heightEqualTo(20);
    
    UIButton * clearBtn = [UIButton new];
    [_backView addSubview:clearBtn];
    [clearBtn addTarget:self action:@selector(addKind) forControlEvents:UIControlEventTouchUpInside];
    clearBtn.maker.centerYTo(kindL, 0).leftTo(kindL, 0).rightTo(_backView, 16).heightEqualTo(50);
    
    _tagV = [[TagView alloc]init];
    [_backView addSubview:_tagV];
    _tagV.maker.topTo(kindL, 15).leftTo(_backView, 16).rightTo(_backView, 16).heightEqualTo(1);
    
    UIView * s5 = [UIView new];
    s5.backgroundColor = UIColor_d7d7d7 ;
    [_backView addSubview:s5];
    s5.maker.topTo(_tagV , 10).leftTo(_backView, 16).rightTo(_backView, 0).heightEqualTo(1);
    //
    UILabel * phoneL = [UILabel new];
    phoneL.text = @"手机号码";
    [_backView addSubview:phoneL];
    phoneL.maker.leftTo(_backView, 16).topTo(s5,15).widthEqualTo(80).heightEqualTo(20);
    
    _phoneTF = [UITextField new];
    _phoneTF.textColor = UIColor_666666 ;
    _phoneTF.text = User_Info.userName ;
    [_backView addSubview:_phoneTF];
    _phoneTF.maker.centerYTo(phoneL ,0).leftTo(phoneL, 20).rightTo(_backView,16).heightEqualTo(50);
    
    UIView * s6 = [UIView new];
    s6.backgroundColor = UIColor_d7d7d7 ;
    [_backView addSubview:s6];
    s6.maker.topTo(_phoneTF , 0).leftTo(_backView, 0).rightTo(_backView, 0).heightEqualTo(1);
    
    _backView.maker.leftTo(self.view, 0).topTo(self.view, 0).rightTo(self.view, 0).heightEqualTo(50 * 7 + 10 + 4 + 5 + 10);
    
    UIButton * sureBtn = [UIButton new];
    sureBtn.layer.cornerRadius = 5;
    [sureBtn setBackgroundColor:UIColor_0x007ed3];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    sureBtn.maker.topTo(_backView, 60).leftTo(self.view, 16).rightTo(self.view, 16).heightEqualTo(44);
}
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
    }
    return _imagePickerVc;
}
@end

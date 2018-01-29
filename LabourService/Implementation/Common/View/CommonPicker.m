//
//  CommonPicker.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/19.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "CommonPicker.h"
#define PickerH  260

@interface CommonPicker()<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSArray * _source ;
    void(^_finish)(NSString * s1 , NSString * s2);
    UIWindow * _realWindow ;
    UIWindow * _instanceWindow ;
    NSString * _s1;
    NSString * _s2;
}
@property (nonatomic ,strong)UIView * contentView ;
@property (nonatomic ,strong)UIPickerView  * pickerView ;
@end
@implementation CommonPicker

+ (instancetype)pickerSource:(NSArray *)source finish:(void (^)(NSString *, NSString *))finish{
    
    return [[self alloc]initWithSource:source finish:finish];
}

- (instancetype)initWithSource:(NSArray *)array finish:(void (^)(NSString *, NSString *))finish {
    if (self = [super init]) {
        _finish = finish ;
        _source = [array mutableCopy];
        
        self.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        [self addSubview:self.contentView];
        [kWindow addSubview:self];
        
    }
    return self ;
}
- (void)cancelClick{
    [self.contentView removeFromSuperview];
    [self removeFromSuperview];
}
- (void)sureClick{
    [self.contentView removeFromSuperview];
    [self removeFromSuperview];
    if (_finish) {
        _finish(_s1,_s2);
    }

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return _source.count ;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray * array = _source[component];
    return  array.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray * array = _source[component];
    return array[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSArray * array = _source[component];
    if (component == 0) {
        _s1 = array[row];
    }else if (component == 2){
        _s2 = array[row];
    }
}
- (UIView *)contentView{
    
    if (!_contentView) {
        
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH  - PickerH, kScreenW, PickerH)];
        _contentView.backgroundColor = [UIColor whiteColor];

        UIButton * cancel = [[UIButton alloc]initWithFrame:CGRectMake(16, 8, 80, 44)];
        [cancel setTitleColor:UIColor_333333 forState:UIControlStateNormal];
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        cancel.layer.borderColor = UIColor_d7d7d7.CGColor;
        cancel.layer.borderWidth = 1 ;
        cancel.layer.cornerRadius = 5 ;
        [cancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:cancel];
        
        UIButton * sure = [[UIButton alloc]initWithFrame:CGRectMake(kScreenW - 16 - 80, 8, 80, 44)];
        [sure setBackgroundColor:UIColor_0x007ed3];
        [sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sure setTitle:@"确定" forState:UIControlStateNormal];
        sure.layer.borderColor = UIColor_f3f3f3.CGColor;
        sure.layer.borderWidth = 0.5 ;
        sure.layer.cornerRadius = 5 ;
        [sure addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:sure];
        //
        UIView * s = [[UIView alloc]initWithFrame:CGRectMake(0, sure.bottom + 8, kScreenW, 1)];
        s.backgroundColor = UIColor_d7d7d7 ;
        [_contentView addSubview:s];
        //
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, s.bottom + 44, kScreenW, PickerH - s.bottom)];
        _pickerView.delegate = self ;
        _pickerView.dataSource = self ;
        [_contentView addSubview:_pickerView];
    }
    return _contentView ;
}

@end

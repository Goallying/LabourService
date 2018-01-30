//
//  CommonPicker.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/19.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "AreaPicker.h"
#define PickerH  260

@interface AreaPicker()<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSArray * _source ;
    void(^_finish)(Area * a1 , Area * a2);
    UIWindow * _realWindow ;
    UIWindow * _instanceWindow ;
    Area * _currentA1 ;
    Area * _currentA2 ;
}
@property (nonatomic ,strong)UIView * contentView ;
@property (nonatomic ,strong)UIPickerView  * pickerView ;
@end
@implementation AreaPicker

+ (instancetype)pickerSelectfinish:(void(^)(Area * a1 , Area * a2))finish{
    
    return [[self alloc]initWithSelectFinish:finish];
}

- (instancetype)initWithSelectFinish:(void (^)(Area * a1 , Area * a2))finish {
    if (self = [super init]) {
        _finish = finish ;
        
        NSString * file =  [[NSBundle mainBundle]pathForResource:@"area" ofType:@"json"];
        NSData * data = [NSData dataWithContentsOfFile:file];
        _source = [NSArray yy_modelArrayWithClass:[Area class] json:data];
        
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
        
        if (!_currentA1) {
            _currentA1 = _source.firstObject ;
        }
        if (!_currentA2) {
            _currentA2 = _currentA1.childrenList.firstObject ;
        }
        _finish(_currentA1,_currentA2);
    }

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2 ;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _source.count ;
    }
    Area * areaS = _currentA1 ;
    if (!areaS) {
        areaS = _source.firstObject;
    }
    return  areaS.childrenList.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        Area * areaF = _source[row];
        return areaF.areaname;
    }
    Area * areaS = _currentA1.childrenList[row];
    if (!areaS) {
       Area * areaF = _source.firstObject;
        areaS = areaF.childrenList[row];
    }
    return areaS.areaname;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        
        _currentA1 = _source[row] ;
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
    }else if (component == 1){
        
        if (!_currentA1) {
            _currentA1 = _source.firstObject ;
        }
        _currentA2 = _currentA1.childrenList[row];
    }
}
- (UIView *)contentView{
    
    if (!_contentView) {
        
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH  - PickerH, kScreenW, PickerH)];
        _contentView.backgroundColor = [UIColor whiteColor];

        UIButton * cancel = [[UIButton alloc]initWithFrame:CGRectMake(16, 8, 60, 35)];
        [cancel setTitleColor:UIColor_333333 forState:UIControlStateNormal];
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        cancel.layer.borderColor = UIColor_d7d7d7.CGColor;
        cancel.layer.borderWidth = 1 ;
        cancel.layer.cornerRadius = 5 ;
        [cancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:cancel];
        
        UIButton * sure = [[UIButton alloc]initWithFrame:CGRectMake(kScreenW - 16 - 60, 8, 60, 35)];
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

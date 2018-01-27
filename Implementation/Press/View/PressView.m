//
//  PressView.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/21.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "PressView.h"

@implementation PressView{
    void (^_finish)(NSInteger);
}

+ (instancetype)pressView:(NSArray *)source didFinishPicker:(void (^)(NSInteger))finish{
    
    return [[self alloc]initWithSource:source finish:finish];
}
- (instancetype)initWithSource:(NSArray *)source finish:(void (^)(NSInteger))finish{
    
    if (self = [super init]) {
        
        _finish = finish ;
        
        self.backgroundColor = [UIColor colorWithWhite:0.98 alpha:0.98];
        self.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        
        CGFloat imageW = 64 ;
        CGFloat gap  = 0.0 ;
        if (source.count >= 3) {
            gap = (kScreenW - 3 * imageW)/ 4 ;
        }else{
            gap = (kScreenW - source.count * imageW)/(source.count + 1) ;
        }
        for (NSInteger i = 0; i< source.count; i++) {
            NSDictionary * dic = source[i];
            UIButton * b = [UIButton new];
            b.tag = i + 1 ;
            [b setBackgroundImage:[UIImage imageNamed:dic[@"image"]] forState:UIControlStateNormal];
            [b addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:b];
            
            UILabel * l = [UILabel new];
            l.text = dic[@"title"];
            l.font = Font_15 ;
            [self addSubview:l];
            l.maker.topTo(b, 8).centerXTo(b, 0).widthGraterThan(44).heightEqualTo(20);
            if (source.count <= 3) {
                b.frame = CGRectMake(gap + (gap + imageW)* i, kScreenH - 250, imageW, 64);
            }
        }
        
        UIButton * closeBtn = [UIButton new];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"close_black"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        closeBtn.maker.centerXTo(self, 0).bottomTo(self,64/2 - 20).widthEqualTo(40).heightEqualTo(40);
        [kWindow addSubview:self];
        
        UILabel * tagL = [UILabel new];
        tagL.textColor = UIColor_666666 ;
        tagL.text = @"发布的信息必须真实有效";
        tagL.font = Font_12 ;
        [self addSubview:tagL];
        tagL.maker.centerXTo(self, 0).bottomTo(closeBtn, 30).widthGraterThan(44).heightEqualTo(15) ;
        
        UIImageView * imgView = [UIImageView new];
        imgView.image = [UIImage imageNamed:@"press_question"];
        [self addSubview:imgView];
        imgView.maker.leftTo(tagL, 0).centerYTo(tagL, 0).widthEqualTo(15).heightEqualTo(15);
        
        
    }
    return self ;
}
-(void)closeClick {
    [self removeFromSuperview];
}

- (void)click:(UIButton *)b {
    if (_finish) {
        _finish(b.tag);
    }
    [self removeFromSuperview];
   
}

@end

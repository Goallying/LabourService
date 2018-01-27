//
//  UIView+VFL.m
//  tttt
//
//  Created by DLB on 16/12/15.
//  Copyright © 2016年 zhu. All rights reserved.
//

#import "UIView+Layout.h"
#import <objc/runtime.h>

static void * makerKey = "makerKey" ;
static void * topConstraintKey    = "topConstraintKey";
static void * leftConstraintKey   = "leftConstraintKey";
static void * bottomConstraintKey = "bottomConstraintKey";
static void * rightConstraintKey  = "rightConstraintKey";
static void * widthConstraintKey  = "widthConstraintKey";
static void * heightConstraintKey = "heightConstraintKey";

@interface LayoutMaker ()

@property  (nonatomic,strong)UIView * targetView  ;

@end

@implementation LayoutMaker

#pragma mark -
#pragma mark --  Top Margin
@dynamic topTo ;
-(LayoutMaker *(^)(UIView *, CGFloat))topTo{
    
    return ^(UIView * topView , CGFloat value){
        
        NSDictionary * viewsDic = @{@"topView":topView,
                                    @"targetView":self.targetView};
        NSDictionary * mertric  = @{@"value":@(value)};
        NSString * visualConstraint ;
        if (self.targetView .superview == topView) {
            visualConstraint = @"V:|-value-[targetView]" ;
        }else{
            visualConstraint = @"V:[topView]-value-[targetView]";
        }
        NSLayoutConstraint * topConstraint = [NSLayoutConstraint constraintsWithVisualFormat:visualConstraint options:0 metrics:mertric views:viewsDic][0] ;
        
        objc_setAssociatedObject(self.targetView, topConstraintKey, topConstraint, OBJC_ASSOCIATION_RETAIN) ;
        [self.targetView.superview addConstraint:topConstraint];
        
        return  self;
    };
}

#pragma mark -
#pragma mark --  Left Margin
@dynamic leftTo;
-(LayoutMaker *(^)(UIView *, CGFloat))leftTo{
    
    return ^(UIView * leftView , CGFloat value){
        
        NSDictionary * viewsDic = @{@"leftView":leftView,
                                    @"targetView":self.targetView};
        NSDictionary * mertric  = @{@"value":@(value)};
        NSString * visualConstraint ;
        if (self.targetView.superview == leftView) {
            visualConstraint = @"H:|-value-[targetView]" ;
        }else{
            visualConstraint = @"H:[leftView]-value-[targetView]";
        }
        NSLayoutConstraint * leftConstraint  = [NSLayoutConstraint constraintsWithVisualFormat:visualConstraint options:0 metrics:mertric views:viewsDic][0] ;
        objc_setAssociatedObject(self.targetView, leftConstraintKey, leftConstraint, OBJC_ASSOCIATION_RETAIN) ;
        [self.targetView.superview addConstraint:leftConstraint];
        
        return  self;
    };
}

#pragma mark -
#pragma mark --  Bottom Margin
@dynamic bottomTo;
-(LayoutMaker *(^)(UIView *, CGFloat))bottomTo{
    
    return ^(UIView * bottomView , CGFloat value){
        
        NSDictionary * viewsDic = @{@"bottomView":bottomView,
                                    @"targetView":self.targetView};
        NSDictionary * mertric  = @{@"value":@(value)};
        NSString * visualConstraint ;
        if (self.targetView.superview == bottomView) {
            visualConstraint = @"V:[targetView]-value-|" ;
        }else{
            visualConstraint = @"V:[targetView]-value-[bottomView]" ;
        }
        NSLayoutConstraint * bottomConstraint = [NSLayoutConstraint constraintsWithVisualFormat:visualConstraint options:0 metrics:mertric views:viewsDic][0] ;
        
        objc_setAssociatedObject(self.targetView, bottomConstraintKey, bottomConstraint, OBJC_ASSOCIATION_RETAIN) ;
        [self.targetView.superview addConstraint:bottomConstraint];
        
        return  self;
    };
}

#pragma mark -
#pragma mark --  Right Margin
@dynamic rightTo;
-(LayoutMaker *(^)(UIView *, CGFloat))rightTo{
    
    return ^(UIView * rightView , CGFloat value){
        
        NSDictionary * viewsDic = @{@"rightView":rightView,
                                    @"targetView":self.targetView};
        NSDictionary * mertric  = @{@"value":@(value)};
        NSString * visualConstraint ;
        if (self.targetView.superview == rightView) {
            visualConstraint = @"H:[targetView]-value-|" ;
        }else{
            visualConstraint = @"H:[targetView]-value-[rightView]";
        }
        NSLayoutConstraint * rightConstraint = [NSLayoutConstraint constraintsWithVisualFormat:visualConstraint options:0 metrics:mertric views:viewsDic][0] ;
        
        objc_setAssociatedObject(self.targetView, rightConstraintKey, rightConstraint, OBJC_ASSOCIATION_RETAIN) ;
        [self.targetView.superview addConstraint:rightConstraint];
        
        return  self;
    };
}

#pragma mark -
#pragma mark --  Sides Margin
@dynamic sidesMarginZero ;
- (LayoutMaker *(^)(void))sidesMarginZero{
    
    return ^(){
        
        NSDictionary * viewsDic = @{@"targetView":self.targetView};
        [self.targetView.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[targetView]-0-|" options:0 metrics:nil views:viewsDic]];
        [self.targetView.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[targetView]-0-|" options:0 metrics:nil views:viewsDic]];
        
        return self;
    };
}

#pragma mark -
#pragma mark --  Width Margin
@dynamic widthEqualTo ;
-(LayoutMaker *(^)(CGFloat))widthEqualTo{
    
    return ^(CGFloat value){
        
        NSDictionary * viewsDic = @{@"targetView":self.targetView};
        NSDictionary * mertric  = @{@"value":@(value)};
        NSLayoutConstraint * widthConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[targetView(value)]" options:0 metrics:mertric views:viewsDic][0];
        objc_setAssociatedObject(self.targetView, widthConstraintKey, widthConstraint, OBJC_ASSOCIATION_RETAIN) ;
        [self.targetView addConstraint:widthConstraint] ;
        return self;
    } ;
}
@dynamic widthGraterThan;
-(LayoutMaker *(^)(CGFloat))widthGraterThan{
    
    return ^(CGFloat value){
        
        NSDictionary * viewsDic = @{@"targetView":self.targetView};
        NSDictionary * mertric  = @{@"value":@(value)};
        NSLayoutConstraint * widthGraterConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[targetView(>=value)]" options:0 metrics:mertric views:viewsDic][0];
        [self.targetView addConstraint:widthGraterConstraint] ;
        
        return self;
    };
}
@dynamic widthLessThan;
-(LayoutMaker *(^)(CGFloat))widthLessThan{
    
    return ^(CGFloat value){
        
        NSDictionary * viewsDic = @{@"targetView":self.targetView};
        NSDictionary * mertric  = @{@"value":@(value)};
        NSLayoutConstraint * widthLessConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[targetView(<=value)]" options:0 metrics:mertric views:viewsDic][0];
        [self.targetView addConstraint:widthLessConstraint] ;
        
        return self;
    } ;
}
@dynamic widthRange;
-(LayoutMaker *(^)(CGFloat, CGFloat))widthRange{
    return ^(CGFloat min , CGFloat max){
        
        NSDictionary * viewsDic = @{@"targetView":self.targetView};
        NSDictionary * mertric  = @{@"valueMin":@(min),
                                    @"valueMax":@(max)};
        [self.targetView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[targetView(>=valueMin)]" options:0 metrics:mertric views:viewsDic]];
        [self.targetView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[targetView(<=valueMax)]" options:0 metrics:mertric views:viewsDic]];
        return self;
    };
}

@dynamic widthEqualToView ;
- (LayoutMaker *(^)(UIView *))widthEqualToView{
    
    return ^(UIView * v){
        
        [self.targetView.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.targetView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        return self ;
    };
    
}
#pragma mark -
#pragma mark --  Height Margin
@dynamic heightEqualTo;
-(LayoutMaker *(^)(CGFloat))heightEqualTo{
    
    return ^(CGFloat value){
        
        NSDictionary * viewsDic = @{@"targetView":self.targetView};
        NSDictionary * mertric  = @{@"value":@(value)};
        NSLayoutConstraint * heightConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[targetView(value)]" options:0 metrics:mertric views:viewsDic][0];
        objc_setAssociatedObject(self.targetView, heightConstraintKey, heightConstraint, OBJC_ASSOCIATION_RETAIN) ;
        [self.targetView addConstraint:heightConstraint] ;
        
        return self;
    };
}
@dynamic heightGraterThan ;
-(LayoutMaker *(^)(CGFloat))heightGraterThan{
    return ^(CGFloat value){
        
        NSDictionary * viewsDic = @{@"targetView":self.targetView};
        NSDictionary * mertric  = @{@"value":@(value)};
        NSLayoutConstraint * heightGraterConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[targetView(>=value)]" options:0 metrics:mertric views:viewsDic][0];
        [self.targetView addConstraint:heightGraterConstraint] ;
        
        return self;
    } ;
}
@dynamic heightLessThan ;
-(LayoutMaker *(^)(CGFloat))heightLessThan{
    
    return ^(CGFloat value){
        
        NSDictionary * viewsDic = @{@"targetView":self.targetView};
        NSDictionary * mertric  = @{@"value":@(value)};
        NSLayoutConstraint * heightLessConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[targetView(<=value)]" options:0 metrics:mertric views:viewsDic][0];
        [self.targetView addConstraint:heightLessConstraint] ;
        
        return self;
    };
}
@dynamic heightRange;
-(LayoutMaker *(^)(CGFloat, CGFloat))heightRange{
    return ^(CGFloat min , CGFloat max){
        
        NSDictionary * viewsDic = @{@"targetView":self.targetView};
        NSDictionary * mertric  = @{@"valueMin":@(min),
                                    @"valueMax":@(max)};
        [self.targetView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[targetView(>=valueMin)]" options:0 metrics:mertric views:viewsDic]];
        [self.targetView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[targetView(<=valueMax)]" options:0 metrics:mertric views:viewsDic]];
        
        return self;
    };
}

#pragma mark -
#pragma mark --  Center Margin
@dynamic centerXTo;
-(LayoutMaker *(^)(UIView *, CGFloat))centerXTo{
    return ^(UIView * centerXView , CGFloat offset){
        
        [self.targetView.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.targetView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:centerXView attribute:NSLayoutAttributeCenterX multiplier:1 constant:offset]];
        
        return self;
    };
}
@dynamic centerYTo ;
-(LayoutMaker *(^)(UIView *, CGFloat))centerYTo{
    
    return ^(UIView * centerYView , CGFloat offset){
        
        [self.targetView.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.targetView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:centerYView attribute:NSLayoutAttributeCenterY multiplier:1 constant:offset]];
        
        return self;
    };
}
#pragma mark -
#pragma mark --  BaseLine Margin
@dynamic leftBaselineTo ;
-(LayoutMaker *(^)(UIView *))leftBaselineTo{
    
    return ^(UIView * baseLineview){
        
        [self.targetView.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.targetView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:baseLineview attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        
        return self;
    };
}
@dynamic rightBaselineTo;
-(LayoutMaker *(^)(UIView *))rightBaselineTo{
    
    return ^(UIView * baseLineview){
        
        [self.targetView.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.targetView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:baseLineview attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        
        return self;
    };
}

@end

#pragma mark -------------------Categroy---------------------
@implementation UIView (Layout)

#pragma mark -
#pragma mark --  LayoutMaker
- (LayoutMaker *)maker {
    
    LayoutMaker * maker = objc_getAssociatedObject(self, makerKey) ;
    if (!maker) {
        self.translatesAutoresizingMaskIntoConstraints = NO ;
        maker = [LayoutMaker new];
        maker.targetView = self ;
        objc_setAssociatedObject(self, makerKey, maker, OBJC_ASSOCIATION_RETAIN) ;

    }
    return maker ;
}

-(NSLayoutConstraint *)topConstraint{
    
    NSLayoutConstraint * topConstraint = objc_getAssociatedObject(self, topConstraintKey) ;
    if (topConstraint) {
        return topConstraint;
    }
    return nil;
}
-(NSLayoutConstraint *)heightConstraint{
    
    NSLayoutConstraint * heightConstraint = objc_getAssociatedObject(self, heightConstraintKey) ;
    if (heightConstraint) {
        return heightConstraint ;
    }
    return  nil;
}
-(NSLayoutConstraint *)leftConstraint{
    NSLayoutConstraint * leftConstraint = objc_getAssociatedObject(self, leftConstraintKey) ;
    if (leftConstraint) {
        return leftConstraint ;
    }
    return  nil;
}
-(NSLayoutConstraint *)bottomConstraint{
    NSLayoutConstraint * bottomConstraint = objc_getAssociatedObject(self, bottomConstraintKey) ;
    if (bottomConstraint) {
        return bottomConstraint ;
    }
    return  nil;
}
-(NSLayoutConstraint *)widthConstraint{
    NSLayoutConstraint * widthConstraint = objc_getAssociatedObject(self, widthConstraintKey) ;
    if (widthConstraint) {
        return widthConstraint ;
    }
    return  nil;
}
-(NSLayoutConstraint *)rightConstraint{
    NSLayoutConstraint * rightConstraint = objc_getAssociatedObject(self, rightConstraintKey) ;
    if (rightConstraint) {
        return rightConstraint ;
    }
    return  nil;
}

#pragma mark -
#pragma mark --  Additional

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
@end

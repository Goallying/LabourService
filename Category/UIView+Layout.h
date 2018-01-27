//
//  UIView+VFL.h
//
//
//  Created by DLB on 16/12/15.
//  Copyright © 2016年 zhu lai fei. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * 此类针对VFL的简单封装,代码通俗易懂,仅仅实用与日常开发.缺点:{
 *    1, 不能设置约束优先级(项目涉及不到);
 *    2, 不能断开一个约束 ;
 *    3,不能自动识别缺少的约束和多余的约束,开发者自行提高开发意识;
 *    4 你可以加自己喜欢的接口
 }
 * @demo:
 *    view.maker.topTo(self.view,10)
 *    .leftTo.(self.view,10)
 *    .bottomTo(self.view,20)
 *    .rightTo(rightView,50);
 *
 * @notification(important):
 *    在调用本代码之前需要先加载到父视图(addSubview)!
 * 
 * @abstract:
 *   1,关于widthConstraint&heightConstraint仅仅适用于调用widthEqualTo & heightTo,因为:widthLessThan等目前没必要给出constraint接口.
 *   2,关于centerX 和 centerY 目前不会开放constraint 接口 ,项目用不到.
 *
 */
@interface LayoutMaker :NSObject


/**
 * 顶部
 */
@property (nonatomic ,copy ,readonly)LayoutMaker * (^topTo)(UIView * ,CGFloat) ;

/**
 * 左边
 */
@property (nonatomic ,copy ,readonly)LayoutMaker * (^leftTo)(UIView * ,CGFloat) ;

/**
 * 底部
 */
@property (nonatomic ,copy ,readonly)LayoutMaker * (^bottomTo)(UIView * ,CGFloat) ;

/**
 * 右边
 */
@property (nonatomic ,copy ,readonly)LayoutMaker * (^rightTo)(UIView * ,CGFloat) ;
/**
 * 距离父视图四边为0
 */
@property  (nonatomic,copy ,readonly)LayoutMaker * (^sidesMarginZero)(void)  ;


/**
 * 宽度
 */
@property (nonatomic ,copy ,readonly)LayoutMaker * (^widthEqualTo)(CGFloat) ;
@property (nonatomic ,copy ,readonly)LayoutMaker * (^widthGraterThan)(CGFloat);
@property (nonatomic ,copy ,readonly)LayoutMaker * (^widthLessThan)(CGFloat) ;
@property (nonatomic ,copy ,readonly)LayoutMaker * (^widthRange)(CGFloat min,CGFloat max) ;
@property  (nonatomic,copy ,readonly)LayoutMaker * (^widthEqualToView)(UIView * v)  ;


/**
 * 高度
 */
@property (nonatomic ,copy ,readonly)LayoutMaker * (^heightEqualTo)(CGFloat) ;
@property (nonatomic ,copy ,readonly)LayoutMaker * (^heightGraterThan)(CGFloat)  ;
@property (nonatomic ,copy ,readonly)LayoutMaker * (^heightLessThan)(CGFloat) ;
@property (nonatomic ,copy ,readonly)LayoutMaker * (^heightRange)(CGFloat min , CGFloat max) ;

/**
 *中心 , offset 可正可负
 */
@property (nonatomic ,copy ,readonly)LayoutMaker * (^centerXTo)(UIView * ,CGFloat offset) ;
@property (nonatomic ,copy ,readonly)LayoutMaker * (^centerYTo)(UIView * ,CGFloat offset) ;

/**
 *左基准线
 */
@property (nonatomic ,copy ,readonly)LayoutMaker * (^leftBaselineTo)(UIView *) ;
@property (nonatomic ,copy ,readonly)LayoutMaker * (^rightBaselineTo)(UIView *) ;

@end


@interface UIView (Layout)

//layout Maker
@property  (nonatomic,strong,readonly)LayoutMaker * maker  ;


//specific constraint, you should implement what you need.
@property (nonatomic ,strong, readonly) NSLayoutConstraint * topConstraint ;
@property (nonatomic ,strong ,readonly) NSLayoutConstraint * leftConstraint  ;
@property (nonatomic ,strong ,readonly) NSLayoutConstraint * bottomConstraint  ;
@property (nonatomic ,strong ,readonly) NSLayoutConstraint * rightConstraint  ;
@property (nonatomic ,strong ,readonly) NSLayoutConstraint * widthConstraint  ;
@property (nonatomic ,strong ,readonly) NSLayoutConstraint * heightConstraint  ;

//additional
@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size;        ///< Shortcut for frame.size.
@end

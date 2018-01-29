//
//  TagView.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/16.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagView : UIView

@property (nonatomic ,strong)NSArray * tags ;


//用到高度的地方自行计算
@property (nonatomic ,assign)CGFloat pressTagsHeight ;
@property (nonatomic ,assign)CGFloat appointmentTagsHeight ;
@property (nonatomic ,assign)CGFloat searchTagsHeight ;

@end

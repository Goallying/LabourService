//
//  SearchH5ViewController.h
//  LabourService
//
//  Created by 朱来飞 on 2018/1/17.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "BaseH5ViewController.h"
#import "SearchListModel.h"

//messageType  （数值类型, 1.人才联系 2.项目联系）
typedef NS_ENUM(NSInteger ,ShowType) {
    ShowType_Person = 1 ,
    ShowType_Project = 2 ,
    ShowType_Message = 3
};
@interface SearchH5ViewController : BaseH5ViewController
@property (nonatomic ,strong)SearchListModel *searchModel ;
@property (nonatomic ,assign)ShowType showType ;
@property (nonatomic ,assign)BOOL hiddenBottomView ; //default NO
@end

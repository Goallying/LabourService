//
//  NewsCustomViewController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/22.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "NewsCustomViewController.h"
#import "NewsViewModel.h"
#import "NewsTypeCollectionVIewCell.h"
#import "NewsTypeCollectionViewHeader.h"
@interface NewsCustomViewController ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@property (nonatomic ,strong)UICollectionView * collectionView ;
@property (nonatomic ,strong)NSArray * dataSource ;
@property (nonatomic ,strong)NSArray * types ;

@property (nonatomic ,strong)NSMutableArray * exps ;

@end

@implementation NewsCustomViewController

- (NSString *)titleText{
    return @"点击添加，拖动排序";
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (NSArray<UIButton *> *)rightBarButtonItems{
    
    UIButton * rightItem = [UIButton new];
    [rightItem setBackgroundImage:[UIImage imageNamed:@"correct_white"] forState:UIControlStateNormal];
    [rightItem addTarget:self action:@selector(finishAdd) forControlEvents:UIControlEventTouchUpInside];
    return @[rightItem];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getAllNewsTypes:^{
        
        [self.view addSubview:self.collectionView];
        _collectionView.maker.topTo(self.navigationBar, 10).leftTo(self.view, 16).rightTo(self.view, 16).bottomTo(self.view, 0);
    }];
   
}
- (void)getAllNewsTypes:(void(^)(void))finish{
    
    [NewsViewModel getNewsTypesSuccess:^(NSString *msg, NSArray *types) {
        _types = [types copy];
        [_collectionView reloadData];
        finish();
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];
    }];
}
- (void)finishAdd {
    
    if (self.finishSelect) {
        self.finishSelect(self.menus);
    }
    AppManager.userNewsTypes = _menus ;
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    NSArray * array = self.dataSource[section];
    if (array.count == 0) {
        return CGSizeMake(kScreenW, CGFLOAT_MIN);
    }
    return CGSizeMake(kScreenW,44);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        NewsTypeCollectionViewHeader * v = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        v.title = indexPath.section == 0?@"点击删除栏目":@"点击添加栏目";
        return v ;
    }
    return  nil;
   
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray * array = self.dataSource[section];
    return array.count ;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.dataSource.count ;
 
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NewsTypeCollectionVIewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.typeModel = self.dataSource[indexPath.section][indexPath.item];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(64, 30);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * array = self.dataSource[indexPath.section];
    NewsTypeModel * model = array[indexPath.item];

    if (model.value == 19 ||model.value == 20) {
        //这两个必选
        return ;
    }
    if (indexPath.section == 0) {
        [_exps addObject:model];
        [_menus removeObjectAtIndex:indexPath.item];
    }else{
        [_menus addObject:model];
        [_exps removeObjectAtIndex:indexPath.item];
    }
    [collectionView reloadData];
}

- (NSArray *)dataSource{
    if (!_dataSource) {
        
        _exps = [_types mutableCopy];
        for (NewsTypeModel  * m  in self.menus) {
            for (NewsTypeModel * sm in self.types) {
                if (m.value == sm.value) {
                    [_exps removeObject:sm];
                }
            }
        }
        _dataSource = @[self.menus , _exps];
    }
    return _dataSource ;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor_f3f3f3;
        _collectionView.delegate = self ;
        _collectionView.dataSource = self ;
        [_collectionView registerClass:[NewsTypeCollectionVIewCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[NewsTypeCollectionViewHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return _collectionView ;
}


@end

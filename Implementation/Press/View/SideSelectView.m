//
//  SideSelectView.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/23.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "SideSelectView.h"
#import "KindCell.h"
#import "WorkKind.h"
#import "CToast.h"
#define MAX_COUNT   5
#define TableWidth  100
@interface SideSelectView ()<UITableViewDelegate,UITableViewDataSource ,UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong)UITableView * tableView ;
@property (nonatomic ,strong)UICollectionView * collectionView ;
@property (nonatomic ,strong)UILabel * collectionViewTitle ;
@property (nonatomic ,strong)NSArray * source ;
@property (nonatomic ,strong)NSArray * subArray ;

@property (nonatomic ,strong)NSMutableArray * selectedArray ;
@property (nonatomic ,copy)void(^finish)(NSArray *kinds) ;
@end
@implementation SideSelectView


- (instancetype)initWithSource:(NSArray *)source finish:(void (^)(NSArray *))finish{
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        _source = source ;
        _finish = finish ;
        
        if (self.maxSelectCount <= 0) {
            self.maxSelectCount = MAX_COUNT ;
        }
        WorkKind * k = source.firstObject ;
        _subArray = k.subKinds ;
        
        [self addSubview:self.tableView];
        [self addSubview:self.collectionViewTitle];
        [self addSubview:self.collectionView];
        
        _collectionViewTitle.text = k.realName ;
        _tableView.maker.leftTo(self, 0).topTo(self, 0).widthEqualTo(TableWidth).bottomTo(self, 0);
        _collectionViewTitle.maker.leftTo(_tableView, 10).topTo(self, 0).rightTo(self, 10).heightEqualTo(44);
        _collectionView.maker.leftTo(_tableView, 10).topTo(_collectionViewTitle, 10).rightTo(self, 10).bottomTo(self, 0);
    }
    return  self ;
}

//tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _source.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static BOOL firstEnter = YES ;
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:@"cell"];
        cell.textLabel.font = Font_14 ;
        cell.textLabel.textColor = UIColor_666666 ;
        cell.textLabel.numberOfLines = 0 ;
        cell.textLabel.textAlignment = NSTextAlignmentCenter ;
    }
    WorkKind  * k = _source[indexPath.row];
    cell.textLabel.text  = k.realName ;
    if (firstEnter) {
        firstEnter = NO ;
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    return cell ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkKind  * k = _source[indexPath.row];
    _subArray = [k.subKinds copy];
    _collectionViewTitle.text = k.realName ;
    [_collectionView reloadData];
}
//

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _subArray.count ;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    KindCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    WorkKind  * k = _subArray[indexPath.item];
    cell.kind  = k;
    return cell ;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    WorkKind  * k = _subArray[indexPath.item];
    CGFloat w = stringSize(k.realName, 15, CGSizeMake(CGFLOAT_MAX, 30)).width;
    return CGSizeMake(w + 10, 30);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return  5 ;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WorkKind  * k = _subArray[indexPath.item];
    if (k.selected == NO) {
        
        if (self.selectedArray.count >= self.maxSelectCount) {
            [CToast showWithText:[NSString stringWithFormat:@"最多选择%ld种",self.maxSelectCount]];
            return;
        }
        [self.selectedArray addObject:k];
    }else{
        [self.selectedArray removeObject:k];
    }
    
    if (_finish) {
        _finish(self.selectedArray);
    }
    k.selected = !k.selected ;
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}




//
- (NSMutableArray *)selectedArray{
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray ;
}
- (UILabel *)collectionViewTitle{
    if (!_collectionViewTitle) {
        _collectionViewTitle = [UILabel new];
        _collectionViewTitle.textColor = UIColor_333333 ;
        _collectionViewTitle.font = Font_15 ;
    }
    return _collectionViewTitle ;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self ;
        _collectionView.delegate = self ;
        [_collectionView registerClass:[KindCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return  _collectionView ;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.estimatedRowHeight = 44 ;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView ;
}


@end

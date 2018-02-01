//
//  SearchViewController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/11.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "SearchViewController.h"
#import "SDCycleScrollView.h"
#import "SearchH5ViewController.h"
#import "SelectKindsViewController.h"
#import "SearchViewModel.h"
#import "SearchCell.h"
#import "AreaPicker.h"
@interface SearchViewController ()<
SDCycleScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong)UIView * navigationView ;
@property (nonatomic,strong) UIButton * delete ;
@property (nonatomic,strong)UIButton * addressBtn;

@property (nonatomic ,strong)UITableView * tableView ;
@property (nonatomic ,strong)SDCycleScrollView *sdCycleView ;
@property (nonatomic ,strong)NSArray * banners ;

@property (nonatomic ,strong)NSMutableArray * people ;
@property (nonatomic ,assign)NSInteger page ;

@property (nonatomic ,strong)UITextField * searchTF ;
@property (nonatomic ,strong)WorkKind * searchKind ;

@property (nonatomic ,copy)NSString * selectedAreaCode ;
@property (nonatomic ,copy)NSString * selectedProvince ;
@end

@implementation SearchViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationBar.hidden = YES ;
    self.tabBarController.tabBar.hidden = NO ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navigationView];
    
    _page = 1 ;
    [self banner_data_request];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(banner_data_request) name:NOTICE_UPDATE_USER_INFO object:nil];
}

- (void)banner_data_request {
    
    [_addressBtn setTitle:User_Info.city forState:UIControlStateNormal];
    [self bannerRequest];
    [self dataRequest:Pull_Refresh];
}
- (void)bannerRequest {
    

    [SearchViewModel getSearchBanner:self.selectedProvince success:^(NSString *msg, NSArray *banners, NSArray *imageURLs) {
        _banners = [banners mutableCopy];
        _sdCycleView.imageURLStringsGroup = imageURLs;
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];
    }];
}
- (void)dataRequest:(PullType)pullType{
    
    NSString * kind = @"";
    if (_searchKind) {
        kind = [NSString stringWithFormat:@"%ld",_searchKind.ID] ;
    }
    [SearchViewModel getSearchList:_page parentid:self.selectedAreaCode parameter:kind success:^(NSString *msg, NSArray *peoples) {
        if (pullType == Pull_Refresh) {
            _people = [peoples mutableCopy];
        }else{
            [_people addObjectsFromArray:peoples];
        }
        self.showEmptyView = _people.count == 0 ;
        [_tableView reloadData];
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];
    }];
}
- (void)refresh {
    
    _page = 1 ;
  
    [self dataRequest:Pull_Refresh];
}
- (void)more {
    _page ++ ;
    NSString * kind = @"";
    if (_searchKind) {
        kind = [NSString stringWithFormat:@"%ld",_searchKind.ID] ;
    }
    [self dataRequest:Pull_More];
}
- (void)locClick {
    
    [AreaPicker pickerSelectfinish:^(Area *a1, Area *a2) {
//        NSLog(@"=== %@,====%@",a1.areaname,a2.areaname);
        _selectedProvince = a1.areaname ;
        _selectedAreaCode = a2.ID ;
        [_addressBtn setTitle:a2.areaname forState:UIControlStateNormal];
        [self refresh];
    }];
}
- (void)TFClick {
    SelectKindsViewController * kindVC = [SelectKindsViewController new];
    kindVC.maxSelectCount = 1 ;
    [kindVC setFinishSelect:^(NSArray *kinds) {
        
        _searchKind = kinds.lastObject ;
        _searchTF.text = _searchKind.realName;
        _delete.hidden = NO ;
        [self refresh];
        [self bannerRequest];
    }];
    [self.navigationController pushViewController:kindVC animated:YES];
}
- (void)deleteText {
    
    _delete.hidden = YES ;
    _searchTF.text = nil ;
    _searchKind = nil ;
    [self refresh];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _people.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    
    SearchListModel * searchModel = _people[indexPath.row];
    cell.searchModel = searchModel ;
    return cell ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchListModel * searchModel = _people[indexPath.row];
    if (searchModel.ID) {
        SearchH5ViewController * h5 = [SearchH5ViewController new];
        h5.showType = ShowType_Person ;
        h5.url = [BaseURL stringByAppendingFormat:@"PersonInfo/toDetail?id=%@",searchModel.ID];
        h5.searchModel = searchModel;
        [self.navigationController pushViewController:h5 animated:YES];
    }
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    BannerModel * banner = _banners[index];
    if ([banner.imageType integerValue] == 0 && banner.jumpUrl) {
        BaseH5ViewController * vc = [BaseH5ViewController new];
        vc.url = banner.jumpUrl;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (NSString *)selectedProvince{
    if (!_selectedProvince) {
        _selectedProvince = User_Info.province ;
    }
    return _selectedProvince ;
}
- (NSString *)selectedAreaCode{
    if (!_selectedAreaCode) {
        _selectedAreaCode = User_Info.adcode ;
    }
    return _selectedAreaCode ;
}
- (SDCycleScrollView *)sdCycleView{
    if (!_sdCycleView) {
        _sdCycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenW, 180) delegate:self placeholderImage:[UIImage imageNamed:@"defaule_banner"]];
        _sdCycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _sdCycleView.currentPageDotColor = [UIColor whiteColor];
    }
    return _sdCycleView ;
}
- (UITableView *)tableView {
    if (!_tableView ) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kScrTopMarginH, kScreenW, kScreenH - kTabBarH -kScrTopMarginH)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.tableHeaderView = self.sdCycleView;
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 88 ;
        [_tableView registerClass:[SearchCell class] forCellReuseIdentifier:@"cell"];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        __weak typeof(self) wSelf = self ;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [wSelf refresh];
            [wSelf.tableView.mj_header endRefreshing];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [wSelf more];
            [wSelf.tableView.mj_footer endRefreshing];
        }];
    }
    return _tableView ;
}
- (UIView *)navigationView {
    
    if (!_navigationView) {
        _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScrTopMarginH)];
        _navigationView.backgroundColor = UIColor_0x007ed3;
        
        UIButton * locBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, 26, 13, 16)];
        [locBtn setBackgroundImage:[UIImage imageNamed:@"nav_location_icon"] forState:UIControlStateNormal];
        [locBtn addTarget:self action:@selector(locClick) forControlEvents:UIControlEventTouchUpInside];
        [_navigationView addSubview:locBtn];
        
        _addressBtn = [UIButton new];
        [_addressBtn.titleLabel setFont:Font_12];
        [_addressBtn setTitle:User_Info.city forState:UIControlStateNormal];
        [_addressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addressBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_addressBtn addTarget:self action:@selector(locClick) forControlEvents:UIControlEventTouchUpInside];
        [_navigationView addSubview:_addressBtn];
        _addressBtn.maker.centerXTo(locBtn, 0).widthRange(30, 44).heightEqualTo(20).topTo(locBtn, 0);
        
        _searchTF = [UITextField new];
        _searchTF.layer.cornerRadius = 15 ;
        _searchTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 22, 0)];
        _searchTF.leftViewMode = UITextFieldViewModeAlways;
        _searchTF.textColor = UIColor_333333 ;
        _searchTF.backgroundColor = [UIColor whiteColor] ;
        _searchTF.placeholder = @"选择您想要的人才";
        _searchTF.placeholderFont = Font_12 ;
        [_navigationView addSubview:_searchTF];
        _searchTF.maker.centerYTo(locBtn, 8).centerXTo(_navigationView, 0). heightEqualTo(30).widthEqualTo(kScreenW - 88 - 10);

        UIButton * clearBtn = [UIButton new];
        [clearBtn addTarget:self action:@selector(TFClick) forControlEvents:UIControlEventTouchUpInside];
        [_searchTF addSubview:clearBtn];
        clearBtn.maker.sidesMarginZero() ;
        
        _delete = [UIButton new];
        [_delete setBackgroundImage:[UIImage imageNamed:@"round_close_gray"] forState:UIControlStateNormal];
        [_delete addTarget:self action:@selector(deleteText) forControlEvents:UIControlEventTouchUpInside];
        _delete.hidden = YES ;
        [clearBtn addSubview:_delete];
        _delete.maker.centerYTo(clearBtn, 0).widthEqualTo(20).heightEqualTo(20).rightTo(clearBtn, 8);
        
        UIImageView * searchImageV = [[UIImageView alloc]init];
        searchImageV.image = [UIImage imageNamed:@"nav_search_btn_black"];
        [_searchTF addSubview:searchImageV];
        searchImageV.maker.centerYTo(_searchTF, 0).leftTo(_searchTF,10).widthEqualTo(12).heightEqualTo(12);
        
        
    }
    return _navigationView;
}

@end

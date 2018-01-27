//
//  SearchViewController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/11.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "AppointmentViewController.h"
#import "SearchH5ViewController.h"
#import "SDCycleScrollView.h"
#import "AppointmentViewModel.h"
#import "AppointmentListCell.h"
#import "IQUIView+IQKeyboardToolbar.h"
#import "SelectKindsViewController.h"
@interface AppointmentViewController ()<
SDCycleScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate
>
@property (nonatomic ,strong)UILabel *mesCountLabel ;
@property (nonatomic,strong)UIView * navigationView ;
@property (nonatomic,strong)UIButton * addressBtn;

@property (nonatomic ,strong)UITableView * tableView ;
@property (nonatomic ,strong)SDCycleScrollView *sdCycleView ;
@property (nonatomic ,strong)NSArray * banners ;

@property (nonatomic ,strong)NSMutableArray * projects ;
@property (nonatomic ,assign)NSInteger page ;

@property (nonatomic ,strong)UITextField * searchTF ;
@property (nonatomic ,assign)BOOL allowEditing ;
@property (nonatomic ,strong)WorkKind * searchKind ;
@end

@implementation AppointmentViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES ;
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
    [self dataRequest:Pull_Refresh page:_page kind:@""];
}
- (void)bannerRequest {
    
    if (!User_Info.province) {
        return;
    }
    [AppointmentViewModel getAppointmentBanner:User_Info.province success:^(NSString *msg, NSArray *banners, NSArray *imageURLs) {
        _banners = [banners copy];
        _sdCycleView.imageURLStringsGroup = imageURLs;
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];
    }];

}
- (void)dataRequest:(PullType)pullType page:(NSInteger)page kind:(NSString *)kind{
    
    if (!User_Info.adcode) {
        return;
    }
    [AppointmentViewModel getAppointmentList:_page parentid:User_Info.adcode parameter:kind success:^(NSString *msg, NSArray *projects) {
        if (pullType == Pull_Refresh) {
            _projects = [projects mutableCopy];
        }else if (pullType == Pull_More){
            [_projects addObjectsFromArray:projects];
        }
        [_tableView reloadData];
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];

    }];
}
- (void)refresh {
    _page = 1 ;
    
    NSString * kind = @"";
    if (_searchKind) {
        kind = [NSString stringWithFormat:@"%ld",_searchKind.ID] ;
    }
    [self dataRequest:Pull_Refresh page:_page kind:kind];
}
- (void)more {
    _page ++ ;
    NSString * kind = @"";
    if (_searchKind) {
        kind = [NSString stringWithFormat:@"%ld",_searchKind.ID] ;
    }
    [self dataRequest:Pull_More page:_page kind:kind];
}
- (void)doneClick{
    if (_searchTF.text.length > 0) {
        return;
    }
    _searchKind = nil ;
    [self dataRequest:Pull_Refresh page:1 kind:@""];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField.text.length == 0) {
        _allowEditing = NO ;
    }else{
        _allowEditing = YES ;
    }
    return YES ;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (_allowEditing == YES) {
        return ;
    }
    SelectKindsViewController * kindVC = [SelectKindsViewController new];
    kindVC.maxSelectCount = 1 ;
    [kindVC setFinishSelect:^(NSArray *kinds) {
        
        _searchKind = kinds.lastObject ;
        
        _allowEditing = YES ;
        textField.text = _searchKind.realName;
        [self dataRequest:Pull_Refresh page:1 kind:[NSString stringWithFormat:@"%ld",_searchKind.ID]];
        
    }];
    [self.navigationController pushViewController:kindVC animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _projects.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppointmentListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    cell.searchModel = _projects[indexPath.row];
    return cell ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchListModel * searchModel = _projects[indexPath.row];
    if (searchModel.ID) {
        SearchH5ViewController * h5 = [SearchH5ViewController new];
        h5.showType = ShowType_Project ;
        h5.url = [BaseURL stringByAppendingFormat:@"BusProject/toDetail?id=%@",searchModel.ID];
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kScrTopMarginH, kScreenW, kScreenH - kTabBarH - kScrTopMarginH)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.tableHeaderView = self.sdCycleView;
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 88 ;
        [_tableView registerClass:[AppointmentListCell class] forCellReuseIdentifier:@"cell"];
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
        [_navigationView addSubview:locBtn];
        
        _addressBtn = [UIButton new];
        [_addressBtn.titleLabel setFont:Font_12];
        [_addressBtn setTitle:User_Info.city forState:UIControlStateNormal];
        [_addressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addressBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_navigationView addSubview:_addressBtn];
        _addressBtn.maker.centerXTo(locBtn, 0).widthRange(30, 44).heightEqualTo(20).topTo(locBtn, 0);
        
        _searchTF = [UITextField new];
        _searchTF.backgroundColor = [UIColor whiteColor] ;
        _searchTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 22, 0)];
        _searchTF.leftViewMode = UITextFieldViewModeAlways;
        _searchTF.placeholder = @"选择您想要的人才";
        _searchTF.placeholderFont = Font_12 ;
        _searchTF.layer.cornerRadius = 15 ;
        [_searchTF.keyboardToolbar.doneBarButton setTarget:self action:@selector(doneClick)];
        _searchTF.delegate = self ;
        [_navigationView addSubview:_searchTF];
        _searchTF.maker.centerYTo(locBtn, 8).centerXTo(_navigationView, 0). heightEqualTo(30).widthEqualTo(kScreenW - 88 - 10);
        
        UIImageView * searchImageV = [[UIImageView alloc]init];
        searchImageV.image = [UIImage imageNamed:@"nav_search_btn_black"];
        [_searchTF addSubview:searchImageV];
        searchImageV.maker.centerYTo(_searchTF, 0).leftTo(_searchTF,10).widthEqualTo(12).heightEqualTo(12);
        
        UIButton * b = [UIButton new];
        [b setBackgroundImage:[UIImage imageNamed:@"nav_msg_icon"] forState:UIControlStateNormal];
        [_navigationView addSubview:b];
        b.maker.rightTo(_navigationView, 16).centerYTo(_searchTF,0).widthEqualTo(24).heightEqualTo(24);
        
        _mesCountLabel = [UILabel new];
        _mesCountLabel.layer.cornerRadius = 8 ;
        _mesCountLabel.clipsToBounds = YES;
        _mesCountLabel.textAlignment = NSTextAlignmentCenter;
        _mesCountLabel.font = Font_12 ;
        _mesCountLabel.textColor = [UIColor whiteColor];
        _mesCountLabel.backgroundColor = UIColorHex(0xff3333);
        _mesCountLabel.text = @" 999 ";
        [b addSubview:_mesCountLabel];
        _mesCountLabel.maker.leftTo(b, 12).topTo(b, -8).widthGraterThan(16).heightEqualTo(16);
        
    }
    return _navigationView;
}

@end


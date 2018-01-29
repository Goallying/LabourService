//
//  MessageViewController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/27.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "MyPressViewController.h"
#import "SwitchView.h"
#import "UserCenterViewModel.h"
#import "SearchCell.h"
#import "AppointmentListCell.h"
#import "SearchH5ViewController.h"
@interface MyPressViewController ()<UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic ,strong)SwitchView * swithView ;
@property (nonatomic ,assign)NSInteger page ;
@property (nonatomic ,strong)UITableView * tableView ;
@property (nonatomic ,assign)NSInteger option ;
@property (nonatomic ,strong)NSMutableArray * records ;
@end

@implementation MyPressViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO ;
    self.tabBarController.tabBar.hidden = YES ;
    
}
- (NSString *)title{
    return @"我的发布";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.swithView];
    [self.view addSubview:self.tableView];
    _swithView.maker.topTo(self.view, 0).leftTo(self.view, 0).rightTo(self.view, 0).heightEqualTo(50);
    _tableView.maker.topTo(_swithView, 0).leftTo(self.view, 0).rightTo(self.view, 0).bottomTo(self.view, 0);
    
    
    _page = 1 ;
    _option = 1 ;
    [self getMyPress:_option page:_page pullType:Pull_Refresh];
}
- (void)refresh {
    _page = 1 ;
    [self getMyPress:_option page:_page pullType:Pull_Refresh];
}
- (void)more {
    _page ++ ;
    [self getMyPress:_option page:_page pullType:Pull_More];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _records.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_option == 1) {
        SearchCell * cell = [tableView dequeueReusableCellWithIdentifier:@"person"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.searchModel = _records[indexPath.row];
        return cell ;
    }else if (_option == 2){
        AppointmentListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"appointment"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.searchModel = _records[indexPath.row];
        return cell ;
    }
    return nil ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchListModel * record = _records[indexPath.row];
    if (record.ID) {
        SearchH5ViewController * h5 = [SearchH5ViewController new];
        h5.showType = _option ;
        if (_option == 1) {
            h5.url = [BaseURL stringByAppendingFormat:@"PersonInfo/toDetail?id=%@",record.ID];
        }else if (_option == 2){
            h5.url = [BaseURL stringByAppendingFormat:@"BusProject/toDetail?id=%@",record.ID];
        }
        h5.searchModel = record;
        [self.navigationController pushViewController:h5 animated:YES];
    }
}
- (void)getMyPress:(NSInteger)pressType page:(NSInteger)page pullType:(PullType)type{
    
    [UserCenterViewModel getUserPressPage:_page pressType:pressType success:^(NSString *msg, NSArray *pressRecords) {
        if (type == Pull_Refresh) {
            _records = [pressRecords mutableCopy];
        }else{
            [_records addObjectsFromArray:pressRecords];
        }
        self.showEmptyView = _records.count == 0 ;
        [_tableView reloadData];
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];
    }] ;
    
}
- (SwitchView *)swithView{
    if (!_swithView) {
        _swithView = [[SwitchView alloc]init];
        _swithView.source = @[@"人才发布",@"项目发布"];
        __weak typeof(self) wSelf = self ;
        [_swithView setClicked:^(NSInteger option) {
            wSelf.option = option ;
            wSelf.page = 1 ;
            [wSelf getMyPress:wSelf.option page:wSelf.page pullType:Pull_Refresh];
        }];
    }
    return _swithView ;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.estimatedRowHeight = 88 ;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[SearchCell class] forCellReuseIdentifier:@"person"];
        [_tableView registerClass:[AppointmentListCell class] forCellReuseIdentifier:@"appointment"];

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
    return _tableView;
}
- (void)dealloc{
    
}
@end


//
//  DetailOptionsViewController.m
//  GovData
//
//  Created by 朱来飞 on 2018/1/3.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "NewsPageViewController.h"
#import "BaseH5ViewController.h"
#import "NewsViewModel.h"
#import "Ad_VdCell.h"
#import "NewsSingleImageCell.h"
#import "NewsSeveralImageCell.h"
#import "SDCycleScrollView.h"
@interface NewsPageViewController ()
<UITableViewDelegate,
UITableViewDataSource,
SDCycleScrollViewDelegate>

@property (nonatomic ,strong)UITableView * tableView ;
@property (nonatomic ,strong)NSMutableArray * news ;

@property (nonatomic ,strong)SDCycleScrollView * sdCycleView ;
@property (nonatomic ,strong)NSArray * banners ;
@property (nonatomic ,assign)NSInteger page  ;
@end

@implementation NewsPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    _tableView.maker.sidesMarginZero();

    _page = 1 ;
    [self refresh];
    [self bannerRequest];
}

- (void)refresh {
    _page = 1 ;
    [self newsRequest:Pull_Refresh page:_page];
}
- (void)more {
    _page ++ ;
    [self newsRequest:Pull_More page:_page];

}
- (void)bannerRequest {
    
    [NewsViewModel getNewsBannerSuccess:^(NSString *msg, NSArray *banners, NSArray *imageURLs) {
        _banners = [banners copy];
        _sdCycleView.imageURLStringsGroup = imageURLs;
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];
    }];

}
- (void)newsRequest:(PullType)type page:(NSInteger)page{

    [NewsViewModel getNewsList:page type:_type success:^(NSString *msg, NSArray *news) {
        if (type == Pull_Refresh) {
            _news = [news mutableCopy];
        }else if (type == Pull_More){
            [_news addObjectsFromArray:news];
        }
        self.showEmptyView = _news.count == 0;
        [_tableView reloadData];
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];
    }];
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NewsModel * newsModel = _news[indexPath.row];
//    NSString * idr = nil ;
//      if (newsModel.lb == NewsType_Picture_Article && newsModel.fileSize < 3) {
//          idr = @"Single";
//      }else if (newsModel.lb == NewsType_Picture_Article && newsModel.fileSize >= 3){
//          idr = @"Several";
//      }else{
//          idr = @"Ad_Vd";
//      }
//    return [tableView fd_heightForCellWithIdentifier:idr configuration:^(id cell) {
//        [cell performSelector:@selector(setNewsModel:) withObject:newsModel];
//    }];
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _news.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel * newsModel = _news[indexPath.row];
    //小于三张图片只展示一张。
    if (newsModel.lb == NewsType_Picture_Article && newsModel.fileSize < 3) {
        NewsSingleImageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Single"];
        cell.newsModel = newsModel ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        return cell ;
    }else if (newsModel.lb == NewsType_Picture_Article && newsModel.fileSize >= 3){
        NewsSeveralImageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Several"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.newsModel = newsModel ;
        return cell;
    }
    Ad_VdCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Ad_Vd"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    cell.newsModel = newsModel ;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    广告类别新闻(lb=3)且有h5地址(advertType=2),调用详情接口时候直接跳转advertUrl里的地址
    NewsModel * newsModel = _news[indexPath.row];
    if (newsModel.advertUrl &&newsModel.advertType == 2 && newsModel.lb == NewsType_Advertisement) {
        BaseH5ViewController * vc = [BaseH5ViewController new];
        vc.url = newsModel.advertUrl;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        BaseH5ViewController * vc = [BaseH5ViewController new];
        vc.url = [BaseURL stringByAppendingFormat:@"NewsInfo/toDetail?id=%lu&lb=%lu",newsModel.ID,newsModel.lb];
        [self.navigationController pushViewController:vc animated:YES];
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
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.tableHeaderView = self.sdCycleView;
        _tableView.tableFooterView = [UIView new];
//        if (@available(iOS 11 ,*)) {
//            _tableView.estimatedRowHeight = 0;
//            _tableView.estimatedSectionHeaderHeight = 0;
//            _tableView.estimatedSectionFooterHeight = 0;
//            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        }
        [_tableView registerClass:[Ad_VdCell class] forCellReuseIdentifier:@"Ad_Vd"];
        [_tableView registerClass:[NewsSingleImageCell class] forCellReuseIdentifier:@"Single"];
        [_tableView registerClass:[NewsSeveralImageCell class] forCellReuseIdentifier:@"Several"];
        
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

@end

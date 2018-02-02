//
//  MessageViewController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/27.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "MessageViewController.h"
#import "SwitchView.h"
#import "UserCenterViewModel.h"
#import "MessageCell.h"
#import "SearchH5ViewController.h"
@interface MessageViewController ()<UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic ,strong)SwitchView * swithView ;
@property (nonatomic ,assign)NSInteger page ;
@property (nonatomic ,strong)UITableView * tableView ;
@property (nonatomic ,assign)NSInteger option ;
@property (nonatomic ,strong)NSMutableArray * messages ;
@end

@implementation MessageViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES ;
    
}
- (NSString *)titleText{
    return @"我的消息";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.swithView];
    [self.view addSubview:self.tableView];
    _swithView.maker.topTo(self.navigationBar, 0).leftTo(self.view, 0).rightTo(self.view, 0).heightEqualTo(50);
    _tableView.maker.topTo(_swithView, 0).leftTo(self.view, 0).rightTo(self.view, 0).bottomTo(self.view, 0);
    
    
    _page = 1 ;
    [self getMessage:0 page:_page pullType:Pull_Refresh];
}
-(void)backforward{
    
    if (self.backUpdate) {
        self.backUpdate();
    }
    [super backforward];
}
- (void)refresh {
    _page = 1 ;
    [self getMessage:_option page:_page pullType:Pull_Refresh];
}
- (void)more {
    _page ++ ;
    [self getMessage:_option page:_page pullType:Pull_More];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _messages.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    cell.message = _messages[indexPath.row];
    return cell ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel * message = _messages[indexPath.row];
    SearchH5ViewController * h5 = [[SearchH5ViewController alloc]init];
    h5.url = [NSString stringWithFormat:@"%@SysMessage/toMessageDetail?id=%@",BaseURL ,message.ID];
    h5.showType = ShowType_Message ;
    h5.hiddenBottomView = message.messageType != 3 ;
    [self.navigationController pushViewController:h5 animated:YES];
}
- (void)getMessage:(NSInteger)status page:(NSInteger)page pullType:(PullType)type{
    
    [UserCenterViewModel getUserMessage:User_Info.token
                                   page:page
                                 status:status
                                success:^(NSString *msg, NSArray *message) {
        if (type == Pull_Refresh) {
            _messages = [message mutableCopy];
        }else{
            [_messages addObjectsFromArray:message];
        }
        self.showEmptyView = _messages.count == 0 ;
        [_tableView reloadData];
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];
    }];
}
- (SwitchView *)swithView{
    if (!_swithView) {
        _swithView = [[SwitchView alloc]init];
        _swithView.source = @[@"未读消息",@"已读消息"];
        __weak typeof(self) wSelf = self ;
        [_swithView setClicked:^(NSInteger option) {
            wSelf.option = option - 1 ;
            wSelf.page = 1 ;
            [wSelf getMessage:wSelf.option page:wSelf.page pullType:Pull_Refresh];
        }];
    }
    return _swithView ;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.estimatedRowHeight = 44 ;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[MessageCell class] forCellReuseIdentifier:@"cell"];
        
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

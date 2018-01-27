//
//  UserCenterViewController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/11.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "UserCenterViewController.h"
#import "EditProfileViewController.h"
#import "UserCenterViewModel.h"
#import "UserCenterSectionHeader.h"
@interface UserCenterViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UIButton * headerBtn ;
@property (nonatomic ,strong)UILabel * nameLabel;
@property (nonatomic ,strong)UITableView * tableView ;
@property (nonatomic ,strong)UIView * tableViewHeaderView ;
@property (nonatomic ,strong)UIView * sectionHeader ;
@property (nonatomic ,strong)NSArray * titles ;
@property (nonatomic ,strong)NSArray * images ;
@property (nonatomic ,assign)NSInteger  balace ;
@property (nonatomic ,assign)NSInteger  thumbs ;
@end
@implementation UserCenterViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES ;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self userDataReq];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadUserInfo) name:NOTICE_LOGIN_SUCCESS object:nil];
}
- (void)reloadUserInfo{
    
    [_headerBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:User_Info.headUrl] forState:UIControlStateNormal];
        _nameLabel.text = User_Info.userName ;
    [self userDataReq];
}
- (void)userDataReq {
    
    NSLog(@"====%@", User_Info.token);
    [UserCenterViewModel getUserInfo:User_Info.token success:^(NSString *msg, NSString *balance, BOOL ifPerfect, NSInteger thumbs) {
        _balace = [balance integerValue] ;
        _thumbs = thumbs ;
        [_tableView reloadData];
        
    } failure:^(NSString *msg, NSInteger code) {
        [CToast showWithText:msg];
    }];
}
- (void)headerClick {
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 65 ;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UserCenterSectionHeader * header = [[UserCenterSectionHeader alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 65)];
    [header setClickOperation:^(ClickOperation operation) {
        
        if (operation == Click_Left) {
            
            EditProfileViewController * vc = [[EditProfileViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (operation == Click_Right){
            
        }
    }];
    return header ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titles.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    }
    if (indexPath.row == 2) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",_balace];
    }else if (indexPath.row == 3){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",_thumbs];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.images[indexPath.row]];
    return cell ;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero] ;
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero] ;
    }
}

- (NSArray *)images{
    if (!_images) {
        _images = @[@"ucenter_list_transaction_project_icon",@"ucenter_list_my_release_icon",@"ucenter_list_my_labor_money_icon",@"ucenter_list_support_icon"];
    }
    return _images ;
}
- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"成交项目",@"我的发布",@"我的劳务币",@"点赞数"];
    }
    return _titles ;
}
- (UIView *)tableViewHeaderView{
    if (!_tableViewHeaderView) {
        _tableViewHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 200)];
        _tableViewHeaderView.backgroundColor = UIColor_0x007ed3 ;
        
        _headerBtn = [UIButton new];
        _headerBtn.layer.cornerRadius = 40 ;
        _headerBtn.clipsToBounds = YES ;
        //        NSString * s = User_Info.headUrl ;
        [_headerBtn sd_setImageWithURL:[NSURL URLWithString:User_Info.headUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultHeader"]];
        [_headerBtn addTarget:self action:@selector(headerClick) forControlEvents:UIControlEventTouchUpInside];
        [_tableViewHeaderView addSubview:_headerBtn];
        _headerBtn.maker.centerXTo(_tableViewHeaderView, 0).topTo(_tableViewHeaderView, 64).widthEqualTo(80).heightEqualTo(80);
        
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = Font_17 ;
        _nameLabel.text = User_Info.userName ;
        [_tableViewHeaderView addSubview:_nameLabel];
        _nameLabel.maker.centerXTo(_headerBtn, 0).topTo(_headerBtn, 10).widthGraterThan(44).heightEqualTo(20);
        
    }
    return _tableViewHeaderView;
}
- (UITableView *)tableView {
    if (!_tableView ) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kTabBarH)];
        _tableView.backgroundColor = UIColor_f3f3f3;
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.tableHeaderView = self.tableViewHeaderView;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 50 ;
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        //        else {
        //            self.automaticallyAdjustsScrollViewInsets = NO;
        //        }
    }
    return _tableView ;
}
@end

//
//  PayViewController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/2/1.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView * tableView ;
@property (nonatomic ,strong)NSArray * dataSource ;
@property (nonatomic ,strong)UIView * tableViewHeader ;
@property (nonatomic ,strong)UILabel * orderTitleL ;
@property (nonatomic ,strong)UILabel * payL ;
@property (nonatomic ,assign)NSInteger payIdx ;
@end

@implementation PayViewController

- (NSString *)titleText{
    return @"支付订单";

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _payIdx = NSNotFound ;
    [self.view addSubview:self.tableView];
    _tableView.maker.topTo(self.navigationBar, 0).rightTo(self.view, 0).leftTo(self.view, 0).bottomTo(self.view, 0);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.row == _payIdx) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark ;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone ;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    NSDictionary * dic = self.dataSource[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:dic[@"image"]];
    cell.textLabel.text = dic[@"title"];
    return cell ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _payIdx = indexPath.row ;
    [_tableView reloadData];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 16, 0, 0)] ;
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero] ;
    }
}
- (UIView *)tableViewHeader{
    if (!_tableViewHeader) {
        
        _tableViewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 88)];
        UILabel * titleT = [UILabel new];
        titleT.text = @"支付订单:";
        titleT.textColor = UIColor_333333 ;
        titleT.font = Font_14 ;
        [_tableViewHeader addSubview:titleT];
        titleT.maker.leftTo(_tableViewHeader, 16).topTo(_tableViewHeader, 16).widthEqualTo(64).heightEqualTo(20);
        
        _orderTitleL= [UILabel new];
        _orderTitleL.textColor = UIColor_333333 ;
        _orderTitleL.font = Font_14 ;
        [_tableViewHeader addSubview:_orderTitleL];
        _orderTitleL.maker.leftTo(titleT, 10).topTo(_tableViewHeader, 16).rightTo(_tableViewHeader, 16).heightEqualTo(20);
        
        UILabel * payT = [UILabel new];
        payT.text = @"订单金额:";
        payT.textColor = UIColor_333333 ;
        payT.font = Font_14 ;
        [_tableViewHeader addSubview:payT];
        payT.maker.leftTo(_tableViewHeader, 16).topTo(titleT, 16).widthEqualTo(64).heightEqualTo(20);
        
        _payL = [UILabel new];
        _payL.textColor = [UIColor redColor] ;
        _payL.font = Font_14 ;
        [_tableViewHeader addSubview:_payL];
        _payL.maker.leftTo(payT, 10).topTo(_orderTitleL, 16).rightTo(_tableViewHeader, 16).heightEqualTo(20);
    }
    return _tableViewHeader ;
}
- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[@{@"title":@"微信支付",@"image":@"pay_weixin_icon"},@{@"title":@"支付宝支付",@"image":@"pay_zhifubao_icon"},@{@"title":@"劳务币支付",@"image":@"money_icon"}];
    }
    return _dataSource ;
}
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.rowHeight = 64 ;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.tableViewHeader;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}


@end
//-------- cell --------
//@interface PayCell()
////@property (nonatomic ,strong)UIImageView <#      #> ;
//@end
//@implementation PayCell :UITableViewCell
////- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
////    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
////
////    }
////    return  self ;
////}
//@end


//
//  DownloadViewController.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/30.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "DownloadViewController.h"

@interface DownloadViewController ()
@property (nonatomic ,strong)UIImageView * QRCodeImageView ;
@property (nonatomic ,strong)UIButton * saveBtn ;
@property (nonatomic ,strong)UIButton * shareBtn ;
@end

@implementation DownloadViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (NSString *)titleText{
    return @"同城劳务下载";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.QRCodeImageView];
    [self.view addSubview:self.saveBtn];
    [self.view addSubview:self.shareBtn];
    _QRCodeImageView.maker.topTo(self.navigationBar, 50).centerXTo(self.view, 0).widthEqualTo(200).heightEqualTo(200);
    _saveBtn.maker.centerXTo(self.view, 0).topTo(_QRCodeImageView, 20).widthEqualTo(200).heightEqualTo(40);
    _shareBtn.maker.centerXTo(self.view, 0).topTo(_saveBtn, 20).widthEqualTo(200).heightEqualTo(40);

    
}
- (void)saveImage {
    
    UIImage * image = [UIImage QRCodeImageWithString:[BaseURL stringByAppendingString:@"SysVersion/download"] size:200];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image: didFinishSavingWithError: contextInfo:), nil);
}
- (void)shareClick {
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [CToast showWithText:@"保存失败"];
    }else{
        [CToast showWithText:@"保存成功"];
    }
}
- (UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton new];
        _shareBtn.layer.cornerRadius = 5 ;
        [_shareBtn.titleLabel setFont:Font_15];
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setBackgroundColor:UIColor_0x007ed3];
        [_shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn ;
}
- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [UIButton new];
        _saveBtn.layer.cornerRadius = 5 ;
        [_saveBtn.titleLabel setFont:Font_15];
        [_saveBtn setTitle:@"保存到相册" forState:UIControlStateNormal];
        [_saveBtn setBackgroundColor:UIColor_0x007ed3];
        [_saveBtn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn ;
}
- (UIImageView *)QRCodeImageView{
    if (!_QRCodeImageView) {
        _QRCodeImageView = [UIImageView new];
        _QRCodeImageView.image = [UIImage QRCodeImageWithString:[BaseURL stringByAppendingString:@"SysVersion/download"] size:200];
    }
    return _QRCodeImageView ;
}
@end

//
//  UIImage+Add.m
//  LabourService
//
//  Created by 朱来飞 on 2018/1/30.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "UIImage+Add.h"

@implementation UIImage (Add)

+ (UIImage *)QRCodeImageWithString:(NSString *)string size:(CGFloat)size {
    
    CIFilter* filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData* scannerData = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:scannerData forKey:@"inputMessage"];
    CIImage* outputImage = [filter outputImage];
    //生成清晰的二维码图片
    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:size];}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
@end

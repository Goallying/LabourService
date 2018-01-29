//
//  RequestManager.m
//  App_iOS
//
//  Created by 朱来飞 on 2017/9/27.
//  Copyright © 2017年 上海递拎宝网络科技有限公司. All rights reserved.
//

#import "RequestManager.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
@implementation RequestManager {
    
    AFHTTPSessionManager * _sessionManager ;
}

+ (instancetype)manager {
    static RequestManager * _manager ;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _manager = [[RequestManager alloc]init];
    });
    return _manager ;
}

-(instancetype)init{
    
    if (self = [super init]) {
        
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer.timeoutInterval = 30 ;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    }
    
    return self ;
}
- (void)POST_URLString:(NSString *)s
        headerParamter:(NSString *)head
            parameters:(NSDictionary *)dic
        showIndicatior:(BOOL)showIndicatior
               success:(void(^)(id obj))success
               failure:(void(^)(NSError * error))failure{
  
    [_sessionManager.requestSerializer setValue:head forHTTPHeaderField:@"token"];
    [self POST_URLString:s parameters:dic showIndicatior:showIndicatior success:success failure:failure];
}

-(void)POST_URLString:(NSString *)s
           parameters:(NSDictionary *)dic
       showIndicatior:(BOOL)showIndicatior
              success:(void (^)(id))success
              failure:(void (^)(NSError *))failure{
    [self POST_URLString:s
              parameters:dic
                 timeOut:0
          showIndicatior:showIndicatior
                 success:success
                 failure:failure];
    
}
- (void)POST_URLString:(NSString *)s
            parameters:(NSDictionary *)dic
               timeOut:(NSInteger)timeOut
        showIndicatior:(BOOL)showIndicatior
               success:(void(^)(id obj))success
               failure:(void(^)(NSError * error))failure{
    
    if (timeOut > 0) {
        _sessionManager.requestSerializer.timeoutInterval = timeOut ;
    }
    MBProgressHUD * _hud ;
    if (showIndicatior) {
        _hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
    }
    
    [_sessionManager POST:[BaseURL stringByAppendingString:s] parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        if (showIndicatior) {
            [_hud hideAnimated:YES];
        }
         NSString * s = nonullString(responseObject[@"status"]) ;
        if (![s isEqualToString:@"200"]) {
            NSError * error = [NSError errorWithDomain:responseObject[@"message"] code:[s integerValue] userInfo:nil];
            if ([s isEqualToString:@"304"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_TO_LOGIN object:nil];
            }
            !failure?:failure(error);
        }else{
            !success?:success(responseObject) ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (showIndicatior) {
            [_hud hideAnimated:YES];
        }
        !failure?:failure(error);
    }] ;
    
}
- (void)GET_URLString:(NSString *)s
       headerParamter:(NSString *)head
           parameters:(NSDictionary *)dic
       showIndicatior:(BOOL)showIndicatior
              success:(void(^)(id obj))success
              failure:(void(^)(NSError * error))failure{
    [_sessionManager.requestSerializer setValue:head forHTTPHeaderField:@"token"];
    [self GET_URLString:s parameters:dic showIndicatior:showIndicatior success:success failure:failure];
}
-(void)GET_URLString:(NSString *)s
          parameters:(NSDictionary *)dic
      showIndicatior:(BOOL)showIndicatior
             success:(void (^)(id))success
             failure:(void (^)(NSError *))failure{
    
    MBProgressHUD * _hud ;
    if (showIndicatior) {
        _hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
        _hud.label.text = @"加载中...";
    }
    [_sessionManager GET:[BaseURL stringByAppendingString:s] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (showIndicatior) {
            [_hud hideAnimated:YES];
        }
        NSString * s = nonullString(responseObject[@"status"]) ;
        if (![s isEqualToString:@"200"]) {
            NSError * error = [NSError errorWithDomain:responseObject[@"message"] code:[s integerValue] userInfo:nil];
            if ([s isEqualToString:@"304"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_TO_LOGIN object:nil];
            }
            !failure?:failure(error);
        }else{
            !success?:success(responseObject) ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (showIndicatior) {
            [_hud hideAnimated:YES];
        }
        !failure?:failure(error) ;
    }];
}
#pragma mark -
#pragma mark --  UploadImages

- (void)uploadImagesURL:(NSString *)s
                  token:(NSString *)token
                 images:(NSArray *)images
                 params:(NSDictionary *)dic
         showIndicatior:(BOOL)showIndicatior
                success:(void(^)(id obj))success
                failure:(void(^)(NSError * error))failure {
    
    MBProgressHUD * _hud ;
    if (showIndicatior) {
        _hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
    }
    [_sessionManager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    [_sessionManager POST:[BaseURL stringByAppendingString:s] parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i< images.count; i++) {
            UIImage *image = images[i];
            NSData *data = UIImagePNGRepresentation(image);
            [formData appendPartWithFileData:data name:@"picture" fileName:[NSString stringWithFormat:@"image%d.png",i] mimeType:@"image/*"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"progress == %@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (showIndicatior) {
            [_hud hideAnimated:YES];
        }
        NSString * s = nonullString(responseObject[@"status"]) ;
        if (![s isEqualToString:@"200"]) {
            NSError * error = [NSError errorWithDomain:responseObject[@"message"] code:[s integerValue] userInfo:nil];
            if ([s isEqualToString:@"304"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_TO_LOGIN object:nil];
            }
            !failure?:failure(error);
        }else{
            !success?:success(responseObject) ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (showIndicatior) {
            [_hud hideAnimated:YES];
        }
        !failure?:failure(error) ;

    }];
}

- (void)cancelRequest{
    
    [_sessionManager.operationQueue cancelAllOperations];
}



@end

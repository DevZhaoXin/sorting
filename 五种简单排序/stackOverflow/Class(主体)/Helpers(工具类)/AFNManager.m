//
//  AFNManager.m
//  NoverReader
//
//  Created by 杨兆欣 on 2017/5/5.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

#import "AFNManager.h"

static AFHTTPSessionManager *manager = nil;

static BOOL _reachable;     //网络是否连通

@implementation AFNManager

+ (void)openNetworkMonitor {
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 1 || [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 2) {
            _reachable = YES;
        }else {
            _reachable = NO;
        }
        DLog(@"网络状态:%ld", (long)status);
        DLog(@"网络连通:%d", _reachable);
    }];
}

+ (NSInteger)networkStatus {
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

+ (BOOL)networkReachability {
    return _reachable;
}

+ (AFHTTPSessionManager *)sharedAFManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"charset=UTF-8", @"text/plain", @"text/javascript",@"application/text",@"application/html", nil];
//        manager.requestSerializer.timeoutInterval = 20;
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //        manager.securityPolicy = securityPolicy;
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        //        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    });
    return manager;
}

+ (id)GET:(NSString *)path parameters:(NSDictionary *)params completionHandle:(void(^)(id responseObj, NSError *error))completionHandle{
//    [manager.requestSerializer setValue:@"62838eb932ed1b440d0ff7040aa455e0" forHTTPHeaderField:@"apikey"];
    WS(weakself);
    //打印网络请求
    DLog(@"Request Path: %@, params %@", path, params)
    return [[self sharedAFManager] GET:path parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *data = responseObject;
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        DLog(@"路径:%@====请求成功:%@",  path, responseString);
        if (completionHandle) {
            completionHandle(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"错误信息  %@", error)
        completionHandle(nil, error);
    }];
}

+ (id)POST:(NSString *)path parameters:(NSMutableDictionary *)params completionHandle:(void(^)(id responseObj, NSError *error))completionHandle{
    
    WS(weakself);
    return [[self sharedAFManager] POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandle(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"错误信息  %@", error)
        completionHandle(nil, error);
    }];
}

+ (NSString *)percentPathWithPath:(NSString *)path params:(NSDictionary *)params{
    NSMutableString *percentPath =[NSMutableString stringWithString:path];
    NSArray *keys = params.allKeys;
    NSInteger count = keys.count;
    for (int i = 0; i < count; i++) {
        if (i == 0) {
            [percentPath appendFormat:@"?%@=%@", keys[i], params[keys[i]]];
        }else{
            [percentPath appendFormat:@"&%@=%@", keys[i], params[keys[i]]];
        }
    }
    return [percentPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (void)downloadWithUrl:(NSString *)urlStr savePath:(NSString *)path progress:(void (^)(CGFloat progress))progress success:(void (^)(NSString *filePath, NSString *fileName))success failure:(void (^)(NSError *errer))failure {
    
    NSLog(@"URL:%@",urlStr);
    __block NSString *file_path;
    __block NSString *fileName;
    
    NSString *urlString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        CGFloat gress = downloadProgress.fractionCompleted;
        //        NSLog(@"下载进度:%f", gress);
        
        if (progress) {
            progress(gress);
        }
        
    }  destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        // 指定下载文件保存的路径
        //        NSLog(@"%@ %@", targetPath, response.suggestedFilename);
        // 将下载文件保存在缓存路径中
        fileName = response.suggestedFilename;
        file_path = [path stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"保存路径:%@", file_path);
        
        // URLWithString返回的是网络的URL,如果使用本地URL,需要注意
        //        NSURL *fileURL1 = [NSURL URLWithString:path];
        NSURL *fileURL = [NSURL fileURLWithPath:file_path];
        
        
        return fileURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        if (!error) {
            NSLog(@"下载成功:%@", file_path);
            if (success) {
                success(file_path, fileName);
            }
            
        }
        else {
            NSLog(@"下载失败:%@", error);
            if (failure) {
                failure(error);
            }
        }
        
    }];
    [task resume];
    
}




@end

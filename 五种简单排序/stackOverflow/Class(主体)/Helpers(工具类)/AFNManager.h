//
//  AFNManager.h
//  NoverReader
//
//  Created by 杨兆欣 on 2017/5/5.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

/**
 要使用常规的AFN网络访问
 
 1. AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
 
 所有的网络请求,均有manager发起
 
 2. 需要注意的是,默认提交请求的数据是二进制的,返回格式是JSON
 
 1> 如果提交数据是JSON的,需要将请求格式设置为AFJSONRequestSerializer
 2> 如果返回格式不是JSON的,
 
 3. 请求格式
 
 AFHTTPRequestSerializer            二进制格式
 AFJSONRequestSerializer            JSON
 AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
 
 4. 返回格式
 
 AFHTTPResponseSerializer           二进制格式
 AFJSONResponseSerializer           JSON
 AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
 AFXMLDocumentResponseSerializer (Mac OS X)
 AFPropertyListResponseSerializer   PList
 AFImageResponseSerializer          Image
 AFCompoundResponseSerializer       组合
 */

#define kAlertNoNetwork        @"无网络"
#define kAlertServerError      @"服务器出错"

#define kCompletionHandle completionHandle:(void(^)(id responseObj, NSError *error))completionHandle

#import <Foundation/Foundation.h>

@interface AFNManager : NSObject

/**检测网路状态**/
+ (NSInteger)networkStatus;

+ (BOOL)networkReachability;

/** 对AFHTTPSessionManager的GET请求方法进行了封装 */
+ (id)GET:(NSString *)path parameters:(NSMutableDictionary *)params completionHandle:(void(^)(id responseObj, NSError *error))completionHandle;

/** 对AFHTTPSessionManager的POST请求方法进行了封装 */
+ (id)POST:(NSString *)path parameters:(NSMutableDictionary *)params completionHandle:(void(^)(id responseObj, NSError *error))completionHandle;

// 下载
+ (void)downloadWithUrl:(NSString *)urlStr savePath:(NSString *)path progress:(void (^)(CGFloat progress))progress success:(void (^)(NSString *filePath, NSString *fileName))success failure:(void (^)(NSError *errer))failure;


/**
 *  为了应付某些服务器对于中文字符串不支持的情况，需要转化字符串为带有%号形势
 *
 *  @param path   请求的路径，即 ? 前面部分
 *  @param params 请求的参数，即 ? 号后面部分
 *
 *  @return 转化 路径+参数 拼接出的字符串中的中文为 % 号形势
 */
+ (NSString *)percentPathWithPath:(NSString *)path params:(NSDictionary *)params;

@end

//
//  OCViewModel.h
//  NoverReader
//
//  Created by 杨兆欣 on 2017/5/4.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^CompletionHandle)(NSError *error);

typedef enum : NSUInteger {
    LSHeaderRefresh_HasMoreData = 1,
    LSHeaderRefresh_HasNoMoreData,
    LSFooterRefresh_HasMoreData,
    LSFooterRefresh_HasNoMoreData,
    LSRefreshError,
    LSRefreshUI,
} LSRefreshDataStatus;

@class AFNManager;

@protocol OCViewModelProtocol <NSObject>

@optional

- (instancetype)initWithModel:(id)model;


/**
 *  初始化
 */
- (void)oc_initialize;

@end


@interface OCViewModel : NSObject <OCViewModelProtocol>

@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,strong) NSURLSessionDataTask *dataTask;
- (void)cancelTask;  //取消任务
- (void)suspendTask; //暂停任务
- (void)resumeTask;  //继续任务

@end

//
//  OCViewModel.m
//  NoverReader
//
//  Created by 杨兆欣 on 2017/5/4.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

#import "OCViewModel.h"

@implementation OCViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    OCViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        // 暂时不用RAC   先不这样写
//        [viewModel oc_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
    }
    return self;
}


- (void)yd_initialize {

}




- (void)cancelTask{
    [self.dataTask cancel];
}

- (void)suspendTask{
    [self.dataTask suspend];
}

- (void)resumeTask{
    [self.dataTask resume];
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}


@end

//
//  OCStartApp.m
//  NoverReader
//
//  Created by 杨兆欣 on 2017/5/2.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

#import "OCStartApp.h"

@implementation OCStartApp


// 当引入此类头文件时，自动调用load方法，故放在AppDelegate中引用，初始化一些东西
+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        [[self class] oc_initPersonData];
        
        [[self class] oc_initFFDB];
        
        [[self class] oc_setKeyBord];
        
        [[self class] oc_testReachableStaus];
        
    });
}

#pragma mark - 初始化个人数据
+ (void)oc_initPersonData {
    
    
}

#pragma mark - 初始化数据库
+ (void)oc_initFFDB {
    
}

#pragma mark - 键盘回收相关
+ (void)oc_setKeyBord {
    
}

#pragma mark － 检测网络相关
+ (void)oc_testReachableStaus {
    
}


@end

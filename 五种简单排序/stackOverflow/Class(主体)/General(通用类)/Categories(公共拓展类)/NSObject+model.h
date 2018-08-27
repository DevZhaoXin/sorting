//
//  NSObject+model.h
//  NoverReader
//
//  Created by 杨兆欣 on 2017/6/5.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (model)

// 利用runtime实现字典转模型

+ (instancetype)modelWithDic:(NSDictionary*)dict;

@end

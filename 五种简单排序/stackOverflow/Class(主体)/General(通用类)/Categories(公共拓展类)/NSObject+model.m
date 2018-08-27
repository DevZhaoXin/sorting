//
//  NSObject+model.m
//  NoverReader
//
//  Created by 杨兆欣 on 2017/6/5.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

#import "NSObject+model.h"

@implementation NSObject (model)

+ (instancetype)modelWithDic:(NSDictionary *)dict {
    id objc =  [[self alloc] init];
    unsigned int count = 0;
    Ivar  *ivarPlist = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar1 = ivarPlist[i];
        NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(ivar1)];
        NSString *propertyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar1)];
        NSString *key = [propertyName substringFromIndex:1];
        
        id Value= dict[key];
        if (Value) {
            object_setIvar(objc, ivar1, Value); //使用runtime赋值给属性
//            [objc setValue:Value forKey:key];//用kvc复制value不能为空
        }
    }
    return objc;
}



@end

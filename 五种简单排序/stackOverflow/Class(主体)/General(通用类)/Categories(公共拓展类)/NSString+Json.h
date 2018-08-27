//
//  NSString+Json.h
//  JieShu
//
//  Created by Song on 16/1/7.
//  Copyright © 2016年 宋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Json)

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary;

+ (NSString *)jsonStringWithArray:(NSArray *)array;

+ (NSString *)jsonStringWithString:(NSString *) string;

+ (NSString *)jsonStringWithObject:(id) object;

@end

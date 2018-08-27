//
//  NSMutableArray+ZXSort.h
//  stackOverflow
//
//  Created by yangzhaoxin on 2018/2/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSComparisonResult(^ZXSortComparator) (id obj1, id obj2); //返回值为两个对象比较的结果
typedef void (^ZXSortExchangeCallback)(id obj1, id obj2);

@interface NSMutableArray (ZXSort)

// 选择排序
- (void)zx_selectionSortUsingComparator:(ZXSortComparator)compartorBlock didExchange:(ZXSortExchangeCallback)exchangeBlock;

// 冒泡排序
- (void)zx_bubbleSortUsingComparator:(ZXSortComparator)compartorBlock didExchange:(ZXSortExchangeCallback)exchangeBlock;

// 插入排序
- (void)zx_insertionSortUsingComparator:(ZXSortComparator)compartorBlock didExchange:(ZXSortExchangeCallback)exchangeBlock;

// 快速排序
- (void)zx_quickSortUsingComparator:(ZXSortComparator)comparatorBlock didExchange:(ZXSortExchangeCallback)exchangeBlock;

// 堆排序
- (void)zx_heapSortUsingComparator:(ZXSortComparator)comparatorBlock didExchange:(ZXSortExchangeCallback)exchangeBlock;


@end

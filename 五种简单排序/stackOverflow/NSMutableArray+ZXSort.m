//
//  NSMutableArray+ZXSort.m
//  stackOverflow
//
//  Created by yangzhaoxin on 2018/2/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NSMutableArray+ZXSort.h"

@implementation NSMutableArray (ZXSort)

// 交换两个元素的位置方法
- (void)zx_exchangeWithIndexA:(NSInteger)indexA indexB:(NSInteger)indexB didExchange:(ZXSortExchangeCallback)exchangeBlock {
    id temp = self[indexA];
    self[indexA] = self[indexB];
    self[indexB] = temp;
    
    if (exchangeBlock) {
        // 此方法返回被交换的两个元素
        exchangeBlock(temp, self[indexA]);
    }
}

#pragma mark - 选择排序
// 选择排序
- (void)zx_selectionSortUsingComparator:(ZXSortComparator)compartorBlock didExchange:(ZXSortExchangeCallback)exchangeBlock {
    if (self.count == 0) {
        return;
    }
    for (NSInteger i = 0; i < self.count - 1; i++) {
        for (NSInteger j = i + 1; j < self.count; j++) {
            if (compartorBlock(self[i], self[j]) == NSOrderedDescending) { // 满足判断条件。，下行
                [self zx_exchangeWithIndexA:i indexB:j didExchange:exchangeBlock];
            }
        }
    }
}

#pragma mark - 冒泡排序
- (void)zx_bubbleSortUsingComparator:(ZXSortComparator)compartorBlock didExchange:(ZXSortExchangeCallback)exchangeBlock {
    if (self.count == 0) {
        return;
    }
    for (NSInteger i = self.count - 1; i > 0; i--) {
        for (NSInteger j = 0; j < i; j++) {
            if (compartorBlock(self[j], self[j + 1]) == NSOrderedDescending) {
                [self zx_exchangeWithIndexA:j indexB:(j + 1) didExchange:exchangeBlock];
            }
        }
    }
}

#pragma mark - 插入排序
- (void)zx_insertionSortUsingComparator:(ZXSortComparator)compartorBlock didExchange:(ZXSortExchangeCallback)exchangeBlock {
    for (NSInteger i = 1; i < self.count; i ++) {
        for (NSInteger j = i; j > 0 && compartorBlock(self[j], self[j - 1]) == NSOrderedAscending; j --) {
            [self zx_exchangeWithIndexA:j indexB:j - 1 didExchange:exchangeBlock];
        }
    }
}

#pragma mark - 快速排序
- (void)zx_quickSortUsingComparator:(ZXSortComparator)compartorBlock didExchange:(ZXSortExchangeCallback)exchangeBlock {
    if (self.count == 0) {
        return;
    }
    [self zx_quickSortWithLowIndex:0 highIndex:self.count - 1 usingComparator:compartorBlock didExchange:exchangeBlock];
}

- (void)zx_quickSortWithLowIndex:(NSInteger)low highIndex:(NSInteger)high usingComparator:(ZXSortComparator)compartorBlock didExchange:(ZXSortExchangeCallback)exchangeBlock {
    if (low >= high) {
        return;
    }
    NSInteger pivotIndex = [self zx_quickPartitionWithLowIndex:low highIndex:high usingComparator:compartorBlock didExchange:exchangeBlock];
    [self zx_quickSortWithLowIndex:low highIndex:pivotIndex - 1 usingComparator:compartorBlock didExchange:exchangeBlock];
    [self zx_quickSortWithLowIndex:pivotIndex + 1 highIndex:high usingComparator:compartorBlock didExchange:exchangeBlock];
}

- (NSInteger)zx_quickPartitionWithLowIndex:(NSInteger)low highIndex:(NSInteger)high usingComparator:(ZXSortComparator)comparatorBlock didExchange:(ZXSortExchangeCallback)exchangeBlock {
    id pivot = self[low];
    NSInteger i = low;
    NSInteger j = high;
    
    while (i < j) {
        // 略过大于等于pivot的元素
        while (i < j && comparatorBlock(self[j], pivot) != NSOrderedAscending) {
            j --;
        }
        if (i < j) {
            // i、j未相遇，说明找到了小于pivot的元素。交换。
            [self zx_exchangeWithIndexA:i indexB:j didExchange:exchangeBlock];
            i ++;
        }
        
        /// 略过小于等于pivot的元素
        while (i < j && comparatorBlock(self[i], pivot) != NSOrderedDescending) {
            i ++;
        }
        if (i < j) {
            // i、j未相遇，说明找到了大于pivot的元素。交换。
            [self zx_exchangeWithIndexA:i indexB:j didExchange:exchangeBlock];
            j --;
        }
    }
    return i;
}

#pragma mark - 堆排序
- (void)zx_heapSortUsingComparator:(ZXSortComparator)comparatorBlock didExchange:(ZXSortExchangeCallback)exchangeBlock {
    // copy一个副本，防止影响原数组
    NSMutableArray *array = [self mutableCopy];
    
    // 排序过程中不使用0位
    [array insertObject:[NSNull null] atIndex:0];
    
    // 构造最大堆
    // 遍历所有非终结点，把以他们为根节点的子树调整成最大堆
    // 最后一个非终结点位置在本队列长度的一半处
    for (NSInteger index = array.count / 2; index > 0; index --) {
        // 根结点下沉到合适位置
        [array sinkIndex:index bottomIndex:array.count - 1 usingComparator:comparatorBlock didExchange:exchangeBlock];
    }
    
    // 完全排序
    // 从整棵二叉树开始，逐渐剪枝
    for (NSInteger index = array.count - 1; index > 1; index --) {
        // 每次把根结点放在列尾，下一次循环时将会剪掉
        [array zx_exchangeWithIndexA:1 indexB:index didExchange:exchangeBlock];
        // 下沉根结点，重新调整为大顶堆
        [array sinkIndex:1 bottomIndex:index - 1 usingComparator:comparatorBlock didExchange:exchangeBlock];
    }
    
    // 排序完成后删除站位元素
    [array removeObjectAtIndex:0];
    
    // 用排好序的副本代替自己
    [self removeAllObjects];
    [self addObjectsFromArray:array];
}

/// 下沉，传入需要下沉的元素位置，以及允许下沉的最底位置
- (void)sinkIndex:(NSInteger)index bottomIndex:(NSInteger)bottomIndex usingComparator:(ZXSortComparator)comparator didExchange:(ZXSortExchangeCallback)exchangeCallback {
    for (NSInteger maxChildIndex = index * 2; maxChildIndex <= bottomIndex; maxChildIndex *= 2) {
        // 如果存在右子结点，并且左子结点比右子结点小
        if (maxChildIndex < bottomIndex && (comparator(self[maxChildIndex], self[maxChildIndex + 1]) == NSOrderedAscending)) {
            // 指向右子结点
            ++ maxChildIndex;
        }
        // 如果最大的子结点元素小于本元素，则本元素不必下沉了
        if (comparator(self[maxChildIndex], self[index]) == NSOrderedAscending) {
            break;
        }
        // 否则
        // 把最大子结点元素上游到本元素位置
        [self zx_exchangeWithIndexA:index indexB:maxChildIndex didExchange:exchangeCallback];
        // 标记本元素需要下沉的目标位置，为最大子结点原位置
        index = maxChildIndex;
    }
}



@end

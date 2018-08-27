//
//  ViewController.m
//  stackOverflow
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableArray+ZXSort.h"

static const NSInteger kBarCount = 100;

@interface ViewController ()

@property (nonatomic, strong) UISegmentedControl *segmentControl;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) NSMutableArray<UIView *> *barArray;

@property (nonatomic, assign) NSTimeInterval nowTime;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) dispatch_semaphore_t sema;

@end

@implementation ViewController

- (NSMutableArray<UIView *> *)barArray {
    if (!_barArray) {
        _barArray = [NSMutableArray arrayWithCapacity:kBarCount]; // 数组中有几个元素
        for (NSInteger index = 0; index < kBarCount; index++) {
            UIView *bar = [[UIView alloc] init];
            bar.backgroundColor = [UIColor redColor];
            
            [self.view addSubview:bar];
            [_barArray addObject:bar];
        }
    }
    return _barArray;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.textColor = [UIColor blackColor];
        [self.view addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (void)invalidateTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.sema = nil;
}

- (UISegmentedControl *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"选择", @"冒泡", @"插入", @"快速", @"堆排序"]];
        _segmentControl.selectedSegmentIndex = 0;
        [_segmentControl addTarget:self action:@selector(onSegmentControlChanged:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_segmentControl];
    }
    return _segmentControl;
}

- (void)onSegmentControlChanged:(UISegmentedControl *)segmentControl {
    [self onReset];
}


// 重置方法
- (void)onReset {
    [self invalidateTimer];
    self.timeLabel.text = nil;
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat barMargin = 1;
    CGFloat barWidth = floorf((width - barMargin * (kBarCount + 1)) / kBarCount); //图形的宽
    CGFloat barOrginX = roundf((width - (barMargin + barWidth) * kBarCount + barMargin) / 2.0); // 中心点
    CGFloat barAreaY = 64 + 10 + 30 + 10;
    CGFloat barBottom = CGRectGetHeight(self.view.bounds) * 0.8;
    CGFloat barAreaHeight = barBottom - barAreaY; // 区域的高度
    
    
    // 遍历数组
    [self.barArray enumerateObjectsUsingBlock:^(UIView * _Nonnull bar, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat barHeight = 20 + arc4random_uniform(barAreaHeight - 20); // 随机高度
        bar.frame = CGRectMake(barOrginX + idx * (barMargin + barWidth), barBottom - barHeight, barWidth, barHeight);
    }];
    NSLog(@"重置成功");
    [self printBarArray];
}

// 打印一下数组中元素的高度
- (void)printBarArray {
#if 1
    NSMutableString *str = [NSMutableString string];
    [self.barArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [str appendFormat:@"%@", @(CGRectGetHeight(obj.frame))];
    }];
#endif
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"重置" style:UIBarButtonItemStylePlain target:self action:@selector(onReset)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"排序" style:UIBarButtonItemStylePlain target:self action:@selector(onSort)];
    
    self.segmentControl.frame = CGRectMake(15, 64 + 10, CGRectGetWidth(self.view.bounds) - 30, 30);
    self.timeLabel.frame = CGRectMake(CGRectGetWidth(self.view.bounds) * 0.5 - 60, CGRectGetHeight(self.view.bounds) * 0.8, 120, 40);
    
    // 重置
    [self onReset];
    // Do any additional setup after loading the view, typically from a nib.
}

// 排序方法
- (void)onSort {
    if (self.timer) {
        return;
    }
    self.sema = dispatch_semaphore_create(0); // 创建信号量
    self.nowTime = [[NSDate date] timeIntervalSince1970]; // 获取初始时间
    
    // 定时器信号
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.002 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        switch (self.segmentControl.selectedSegmentIndex) {
            case 0:
                //选择排序
                [self selectionSort];
                break;
            case 1:
                // 冒泡排序
                [self bubbleSort];
                break;
            case 2:
                // 插入排序
                [self insertionSort];
                break;
            case 3:
                // 快速排序
                [self quickSort];
                break;
            case 4: {
                // 堆排序
                [self heapSort];
                break;
            }
            default:
                break;
        }
        [self invalidateTimer];
        [self printBarArray];
    });
    
}

// 定时器方法
- (void)timerAction {
    // 发出信号，唤醒排序线程
    dispatch_semaphore_signal(self.sema);
    // 更新计时
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] - self.nowTime;
    self.timeLabel.text = [NSString stringWithFormat:@"耗时(秒:%2.3f)", interval];
}

// 选择排序 从待排序的数据元素中找出最大或者最小元素，顺序放入有序数组中
- (void)selectionSort {
    [self.barArray zx_selectionSortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [self compareWithBarOne:obj1 andBarTwo:obj2];
    } didExchange:^(UIView *obj1, UIView *obj2) {
        [self exchangePositionWithBarOne:obj1 andBarTwo:obj2];
    }];
}

// 冒泡排序 两两比较
- (void)bubbleSort {
    [self.barArray zx_bubbleSortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [self compareWithBarOne:obj1 andBarTwo:obj2];
    } didExchange:^(UIView *obj1, UIView *obj2) {
        [self exchangePositionWithBarOne:obj1 andBarTwo:obj2];
    }];
}

// 插入排序 依次标记元素，插入到有序数组中
- (void)insertionSort {
    [self.barArray zx_insertionSortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [self compareWithBarOne:obj1 andBarTwo:obj2];
    } didExchange:^(UIView *obj1, UIView *obj2) {
        [self exchangePositionWithBarOne:obj1 andBarTwo:obj2];
    }];
}

// 快速排序 选择一个元素为基准，分别比较所有元素，比基准小的放在左边，比基准大的放在右边，分好之后对左右两个区进行同样操作，直到剩下一个元素为止
- (void)quickSort {
    [self.barArray zx_quickSortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [self compareWithBarOne:obj1 andBarTwo:obj2];
    } didExchange:^(id obj1, id obj2) {
        [self exchangePositionWithBarOne:obj1 andBarTwo:obj2];
    }];
}


// 比较两个元素，判断是否交换以及交换方向
- (NSComparisonResult)compareWithBarOne:(UIView *)barOne andBarTwo:(UIView *)barTwo {
    // 模拟耗时
    dispatch_semaphore_wait(self.sema, DISPATCH_TIME_FOREVER);
    
    CGFloat height1 = CGRectGetHeight(barOne.frame);
    CGFloat height2 = CGRectGetHeight(barTwo.frame);
    if (height1 == height2) {
        return NSOrderedSame; // 此返回值表示相同
    }
    return (height1 < height2 ? NSOrderedAscending : NSOrderedDescending);
}

- (void)exchangePositionWithBarOne:(UIView *)barOne andBarTwo:(UIView *)barTwo {
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect frameOne = barOne.frame;
        CGRect frameTwo = barTwo.frame;
        frameOne.origin.x = barTwo.frame.origin.x;
        frameTwo.origin.x = barOne.frame.origin.x;
        barOne.frame = frameOne;
        barTwo.frame = frameTwo;
    });
}

// 堆排序
- (void)heapSort {
    [self.barArray zx_heapSortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [self compareWithBarOne:obj1 andBarTwo:obj2];
    } didExchange:^(id obj1, id obj2) {
        [self exchangePositionWithBarOne:obj1 andBarTwo:obj2];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  UIButton+runtime.h
//  addsou
//
//  Created by 杨兆欣 on 2017/4/18.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickBlock)(UIButton *sender);

@interface UIButton (runtime)
// 运行时，按钮点击事件，通过block
- (void)tapWithEvent:(UIControlEvents)controlEvent withBlock:(clickBlock)click;

@end

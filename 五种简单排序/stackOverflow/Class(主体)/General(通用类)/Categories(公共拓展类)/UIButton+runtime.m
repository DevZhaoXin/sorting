//
//  UIButton+runtime.m
//  addsou
//
//  Created by 杨兆欣 on 2017/4/18.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

#import "UIButton+runtime.h"
#import <objc/runtime.h>

static const void *associatedKey = &associatedKey;

@implementation UIButton (runtime)

- (void)tapWithEvent:(UIControlEvents)controlEvent withBlock:(clickBlock)click{
    objc_setAssociatedObject(self, associatedKey, click, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(btnClick:) forControlEvents:controlEvent];
}

- (void)btnClick:(UIButton *)sender{
    clickBlock clickBlock = objc_getAssociatedObject(sender, associatedKey);
    if (clickBlock) {
        clickBlock(sender);
    }
}

@end

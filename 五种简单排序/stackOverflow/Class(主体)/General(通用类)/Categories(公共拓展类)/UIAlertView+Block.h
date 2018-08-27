//
//  UIAlertView+Block.h
//  eeeeeeeeeeeeeeeeeeee
//
//  Created by Mac on 15-1-27.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CompleteBlock) (NSInteger buttonIndex);
@interface UIAlertView (Block)
// 用Block的方式回调，这时候会默认用self作为Delegate
- (void)showAlertViewWithCompleteBlock:(CompleteBlock) block;

@end

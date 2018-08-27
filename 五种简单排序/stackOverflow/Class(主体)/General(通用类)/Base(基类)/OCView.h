//
//  OCView.h
//  NoverReader
//
//  Created by 杨兆欣 on 2017/5/4.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OCViewModelProtocol;

@protocol OCViewProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <OCViewModelProtocol>)viewModel;

- (void)oc_bindViewModel;
- (void)oc_setupViews;
- (void)oc_addReturnKeyBoard;

@end

@interface OCView : UIView <OCViewProtocol>

@end

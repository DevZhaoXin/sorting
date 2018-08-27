//
//  OCView.m
//  NoverReader
//
//  Created by 杨兆欣 on 2017/5/4.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

#import "OCView.h"


@implementation OCView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self oc_setupViews];
        [self oc_bindViewModel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self oc_setupViews];
        [self oc_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<OCViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
        
        [self oc_setupViews];
        [self oc_bindViewModel];
    }
    return self;
}

- (void)oc_bindViewModel {
    
}

- (void)oc_setupViews {
    
}

- (void)oc_addReturnKeyBoard {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        [kAppDelegate.window endEditing:YES];
    }];
    [self addGestureRecognizer:tap];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

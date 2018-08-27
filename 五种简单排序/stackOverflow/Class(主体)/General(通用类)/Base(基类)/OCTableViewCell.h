//
//  OCTableViewCell.h
//  NoverReader
//
//  Created by 杨兆欣 on 2017/5/4.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OCTableViewCellProtocol <NSObject>
@optional

- (void)oc_setupViews;
- (void)oc_bindViewModel;

@end

@interface OCTableViewCell : UITableViewCell <OCTableViewCellProtocol>

@end

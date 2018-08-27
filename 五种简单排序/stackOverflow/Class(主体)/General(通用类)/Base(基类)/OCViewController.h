//
//  OCViewController.h
//  NoverReader
//
//  Created by 杨兆欣 on 2017/5/4.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OCViewModelProtocol;

@protocol OCViewControllerProtocol <NSObject>

@optional //表示以下方法不是必须实现的  相反，必须实现用@required标识
- (instancetype)initWithViewModel:(id <OCViewModelProtocol>)viewModel;

/**
 ** 绑定VM
 **/
- (void)oc_bindViewModel;

/**
 ** 添加子视图
 **/
- (void)oc_addSubviews;

/**
 ** 设置导航栏
 **/
- (void)oc_layoutNavigation;

/**
 ** 初次获取数据
 **/
- (void)oc_getNewData;
- (void)oc_recoverKeyboard;

@end

@interface OCViewController : UIViewController <OCViewControllerProtocol>

/**
 ** view是否渗透导航栏
 ** yes是渗透，反之不渗透
 **/
@property (nonatomic, assign) BOOL isExtendLayout;

/**
 ** 功能：设置修改statusBar
 ** 参数：1、样式
 2、是否隐藏
 3、是否动画过渡
 **/
- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
                    isHidden:(BOOL)isHidden
                    animated:(BOOL)animated;

/**
 ** 功能：隐藏显示导航栏
 参数：1、是否隐藏导航栏
 2、是否有动画过渡
 **/
- (void)navigationBarIsHide:(BOOL)isHide
                   animated:(BOOL)animated;

/**
 ** 功能：布局导航栏
 参数：1、背景
 2、标题颜色
 3、标题字体
 4、左侧按钮
 5、右侧按钮
 **/
- (void)layoutNavigationBar:(UIImage *)backGroundImage
                 titleColor:(UIColor *)titleColor
                  titleFont:(UIFont *)titleFont
          leftBarButtonItem:(UIBarButtonItem*)leftItem
         rightBarButtonItem:(UIBarButtonItem*)rightItem;


@end

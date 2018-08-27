//
//  AppMacro.h
//  NoverReader
//
//  Created by 杨兆欣 on 2017/5/4.
//  Copyright © 2017年 杨兆欣. All rights reserved.
//


/**
 ** APP相关宏定义
 **/

#ifndef AppMacro_h
#define AppMacro_h



#define JH_NavigationColor [UIColor colorWithHex:0x12B14F alpha:1]





#define GB_APP_VERSION                    \
[[[NSBundle mainBundle] infoDictionary] \
objectForKey:@"CFBundleShortVersionString"]

#define IS_FIRST_START [NSString stringWithFormat:@"isfirststart_%@",GB_APP_VERSION]

#define NILOGLEVEL_INFO     5
#define NILOGLEVEL_WARNING  3
#define NILOGLEVEL_ERROR    1


#define COLOR_NONGLI_BLACK  [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0]
#define COLOR_NONGLI_RED  [UIColor colorWithRed:233/255.0 green:0/255.0 blue:20/255.0 alpha:1.0]
#define COLOR_NONGLI_GRAY  [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]

#define NONGLI_festival_COLOR  [UIColor colorWithRed:231/255.0 green:237/255.0 blue:164/255.0 alpha:1.0]
#define NONGLI_COLOR  [UIColor colorWithRed:201/255.0 green:223/255.0 blue:238/255.0 alpha:1.0]


#define GlobalManage_Instance ((GlobalManage *)[ZZApplication sharedInstance].application)


//wxz:正式接口
#define rili_PORTION_URL @"api.24kidea.com"


#define rili_Key_HaveNetwork @"haveNetwork"//有无网络
#define rili_Key_NetworkType @"networkType"//网络类型（“移动网｜WIFI”）
#define rili_APP_VERSION @"1.0"
#define rili_MID [[UIDevice currentDevice] uniqueOpenUDID]


//懒人日历
#define riliAPPID  @"77778"


#define VC_INDEX_KEY        @"viewController_index_key"        //记录viewController, 直接 pop 至这个viewController

//验证字符串为空
#define NSStringIsEmpty(str)        ((str==nil)||[str isEqualToString:@""]||[str isEqualToString:@"(null)"])

#define YZX_ISFIRSTOPEN                 @"isFirstOpen"  // 是否为第一次打开 若是则为空  若不是则为1

#define ISFIRSTOPEN                     @"isfirstopen"      // 是否为第一次打开 （评论机制）

#define COLOR_NaviBar kRGBColor(40, 165, 100)

#define VIEW_WIDTH self.frame.size.width
#define VIEW_HEIGH self.frame.size.height

#define CELL_WIDTH VIEW_WIDTH
#define CELL_HEIGH VIEW_HEIGH
#define COLOR_G             COLOR(129, 188, 120, 1)             //深绿色
#define COLOR_BG            COLOR(241, 241, 246, 1)             //背景颜色，浅紫色

#define COLOR_TEXT          COLOR(62, 58, 57, 1)                //文本 颜色
#define COLOR_LINE          COLOR(200, 200, 200, 1)             //分割线 颜色
#define COLOR_TabBarSelect  COLOR(232, 179, 18, 1)              //tabBar选中颜色

#define COLOR_Button        COLOR(235,169,97,1)                 //按钮颜色
#define COLOR_ButtonSelect  COLOR(235,169,97,0.5)               //按钮颜色(选中的颜色)

#define LOADIMAGE(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]  //加载图片
#define statusBarHeight (isIOS7? 20.0 : 0.0)    //视图y坐标
#define NavigationBarHeight (statusBarHeight + 44.0)     //navigationBar高度
#define TabBarHeight 50.0      


#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//void invokeSelector(id object, SEL selector, NSArray *arguments)
//{
//    NSMethodSignature *signature = [object methodSignatureForSelector:selector];
//    
//    if (signature.numberOfArguments == 0) {
//        return; //@selector未找到
//    }
//    
//    if (signature.numberOfArguments > [arguments count]+2) {
//        return; //传入arguments参数不足。signature至少有两个参数，self和_cmd
//    }
//    
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//    [invocation setTarget:object];
//    [invocation setSelector:selector];
//    
//    for(int i=0; i<[arguments count]; i++)
//    {
//        id arg = [arguments objectAtIndex:i];
//        [invocation setArgument:&arg atIndex:i+2]; // The first two arguments are the hidden arguments self and _cmd
//    }
//    
//    [invocation invoke]; // Invoke the selector
//}//tabBar 高度

#endif /* AppMacro_h */

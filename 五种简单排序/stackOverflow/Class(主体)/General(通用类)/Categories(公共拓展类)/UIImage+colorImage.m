//
//  UIImage+colorImage.m
//  NewBattery
//
//  Created by apple on 2017/7/12.
//  Copyright © 2017年 lile. All rights reserved.
//

#import "UIImage+colorImage.h"

@implementation UIImage (colorImage)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end

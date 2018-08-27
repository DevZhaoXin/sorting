//
//  UIColor+Hex.m
//  CTDestingy
//
//  Created by CT.Master on 13-10-31.
//  Copyright (c) 2013年 YLW. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+(UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0f
                           green:((float)((hexValue & 0x00FF00) >> 8))/255.0f
                            blue:(float)(hexValue & 0x0000FF)/255.0f alpha:alphaValue];
}

+(UIColor*)colorWithHex:(NSInteger)hexValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0f
                           green:((float)((hexValue & 0x00FF00) >> 8))/255.0f
                            blue:(float)(hexValue & 0x0000FF)/255.0f alpha:1.0];
}


+(UIColor*)whiteColorWithAlpha:(CGFloat)alphaValue
{
    return [UIColor colorWithHex:0xffffff alpha:alphaValue];
}

+(UIColor*)blackColorWithAlpha:(CGFloat)alphaValue
{
    return [UIColor colorWithHex:0x000000 alpha:alphaValue];
}


@end
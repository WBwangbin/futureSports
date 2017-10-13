//
//  UIColor+Hex.h
//  FutureSports
//
//  Created by wangbin on 2017/9/25.
//  Copyright © 2017年 wangbin. All rights reserved.
//

/**
***  Hex值颜色转换(UIColor转16进制)
**/

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

// 从十六进制字符串获取颜色，color:支持@“#AB123456”、 @“0XCC123456”、
// @“B2123456”三种格式，前面两位是指透明度
+ (UIColor *)colorWithHexString:(NSString *)color;

// color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


@end

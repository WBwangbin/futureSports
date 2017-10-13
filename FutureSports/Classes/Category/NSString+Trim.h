//
//  NSString+Trim.h
//  FutureSports
//
//  Created by wangbin on 2017/9/28.
//  Copyright © 2017年 wangbin. All rights reserved.
//

/**
 *** 字符串处理
 **/

#import <Foundation/Foundation.h>

@interface NSString (Trim)
//我的
//判断字符串是否为空,为空返回YES
+ (BOOL)fnt_isEmpty:(NSString *)string;











/**
 *  过滤字符串中的特殊字符
 *
 *  @param val          原始字符串
 *  @param characterSet 处理操作
 *
 *  @return 处理后的字符串
 */
+ (NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet;
/**
 *  去除字符串前后的空格
 *
 *  @param val 原始字符串
 *
 *  @return 处理后的字符串
 */
+ (NSString *)trimWhitespace:(NSString *)val;
/**
 *  去掉前后回车符
 *
 *  @param val 原始字符串
 *
 *  @return 处理后的字符串
 */
+ (NSString *)trimNewline:(NSString *)val;

/**
 *  去掉前后空格和回车符
 *
 *  @param val 原始字符串
 *
 *  @return 处理后的字符串
 */
+ (NSString *)trimWhitespaceAndNewline:(NSString *)val;

/**
 *  保证字符串在插入数据库的时候的安全，比如单引号变成双引号
 */
- (id)safeString;

/**
 *  取数据库的时候，反编码,比如双引号变成单引号
 */
- (id)decodesafeString;

/**
 *  通过一个字符串截取另一个字符串
 *
 *  @param totalString    总字符串
 *  @param intervalString 间隔字符串
 *
 *  @return 截取后保存的数组
 */
+ (NSArray *)extractTotalString:(NSString *)totalString
             withIntervalString:(NSString *)intervalString;

@end

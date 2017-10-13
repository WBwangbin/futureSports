//
//  NSString+Trim.m
//  FutureSports
//
//  Created by wangbin on 2017/9/28.
//  Copyright © 2017年 wangbin. All rights reserved.
//


#import "NSString+Trim.h"

@implementation NSString (Trim)

+ (BOOL)fnt_isEmpty:(NSString *)string
{

    if (string == nil || string == NULL || string == [NSNull class])
    {
        return YES;
    }
    else if ([NSString trimWhitespaceAndNewline:string].length == 0)
    {
        return YES;
    }
    return NO;
}









/**
 *  过滤字符串中的特殊字符
 *
 *  @param val          原始字符串
 *  @param characterSet 处理操作
 *
 *  @return 处理后的字符串
 */
+ (NSString *)trim:(NSString *)val trimCharacterSet:(NSCharacterSet *)characterSet
{
    NSString *returnVal = @"";
    if (val)
    {
        returnVal = [val stringByTrimmingCharactersInSet:characterSet];
    }
    return returnVal;
}

/**
 *  去除字符串前后的空格
 *
 *  @param val 原始字符串
 *
 *  @return 处理后的字符串
 */
+ (NSString *)trimWhitespace:(NSString *)val
{
    return [self trim:val trimCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
}
/**
 *  去掉前后回车符
 *
 *  @param val 原始字符串
 *
 *  @return 处理后的字符串
 */
+ (NSString *)trimNewline:(NSString *)val
{
    return [self trim:val trimCharacterSet:[NSCharacterSet newlineCharacterSet]];
}

/**
 *  去掉前后空格和回车符
 *
 *  @param val 原始字符串
 *
 *  @return 处理后的字符串
 */
+ (NSString *)trimWhitespaceAndNewline:(NSString *)val
{
    return [self trim:val trimCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 *  保证字符串在插入数据库的时候的安全，比如单引号变成双引号
 */
- (id)safeString
{
    NSMutableString *safeString = [self mutableCopy];
    if (safeString && safeString.length > 0)
    {
        safeString = [[safeString stringByReplacingOccurrencesOfString:@"'" withString:@"''"] mutableCopy];
        safeString = [[safeString stringByReplacingOccurrencesOfString:@"/" withString:@"//"] mutableCopy];
        safeString = [[safeString stringByReplacingOccurrencesOfString:@"%" withString:@"/%"] mutableCopy];
        safeString = [[safeString stringByReplacingOccurrencesOfString:@"&" withString:@"/&"] mutableCopy];
        safeString = [[safeString stringByReplacingOccurrencesOfString:@"_" withString:@"/_"] mutableCopy];
        safeString = [[safeString stringByReplacingOccurrencesOfString:@"(" withString:@"/("] mutableCopy];
        safeString = [[safeString stringByReplacingOccurrencesOfString:@")" withString:@"/)"] mutableCopy];
    }

    return safeString;
}

/**
 *  取数据库的时候，反编码,比如双引号变成单引号
 */
- (id)decodesafeString
{
    NSMutableString *decodesafeString = [self mutableCopy];
    if (decodesafeString && decodesafeString.length > 0)
    {
        decodesafeString =
        [[decodesafeString stringByReplacingOccurrencesOfString:@"//" withString:@"/"] mutableCopy];
        decodesafeString =
        [[decodesafeString stringByReplacingOccurrencesOfString:@"/%" withString:@"%"] mutableCopy];
        decodesafeString =
        [[decodesafeString stringByReplacingOccurrencesOfString:@"/&" withString:@"&"] mutableCopy];
        decodesafeString =
        [[decodesafeString stringByReplacingOccurrencesOfString:@"/_" withString:@"_"] mutableCopy];
        decodesafeString =
        [[decodesafeString stringByReplacingOccurrencesOfString:@"/(" withString:@"("] mutableCopy];
        decodesafeString =
        [[decodesafeString stringByReplacingOccurrencesOfString:@"/)" withString:@")"] mutableCopy];
        decodesafeString =
        [[decodesafeString stringByReplacingOccurrencesOfString:@"/'" withString:@"'"] mutableCopy];
    }

    return decodesafeString;
}

/**
 *  通过一个字符串截取另一个字符串
 *
 *  @param totalString    总字符串
 *  @param intervalString 间隔字符串
 *
 *  @return 截取后保存的数组
 */
+ (NSArray *)extractTotalString:(NSString *)totalString
             withIntervalString:(NSString *)intervalString
{
    NSMutableArray *stringArray = [[NSMutableArray alloc] init];
    NSArray *array = [totalString componentsSeparatedByString:intervalString];
    for (NSString *string in array)
    {
        // 过滤掉为空的url
        if (!string || [string isEqualToString:@""])
        {
            continue;
        }

        // 去除空格和回车符
        NSString *realString = [NSString trimWhitespaceAndNewline:string];
        [stringArray addObject:realString];
    }

    if (stringArray.count == 0)
    {
        NSLog (@"extract string is fail");
        return nil;
    }

    return stringArray.copy;
}


@end

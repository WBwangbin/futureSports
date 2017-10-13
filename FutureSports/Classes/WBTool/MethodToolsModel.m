//
//  MethodToolsModel.m
//  FutureSports
//
//  Created by wangbin on 2017/9/28.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "MethodToolsModel.h"

@implementation MethodToolsModel

#pragma mark - 手机号判断
+ (BOOL)isValidateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^1[3|4|5|7|8][0-9]{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

#pragma mark - 邮箱判断
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *regex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [emailTest evaluateWithObject:email];
    
}

#pragma mark - 驴号判断
+ (BOOL)isValidateAcconut:(NSString *)account
{
    NSString *accountRegex = @"^[0-9]*$";
    NSPredicate *accountTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",accountRegex];
    return [accountTest evaluateWithObject:account];
}

#pragma mark - 表情判断
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
            const unichar hs = [substring characterAtIndex:0];
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue = YES;
                    }
                }
            } else if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    returnValue = YES;
                }
            } else {
                if (0x2100 <= hs && hs <= 0x27ff) {
                    returnValue = YES;
                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                        returnValue = YES;
                    } else if (0x2934 <= hs && hs <= 0x2935) {
                        returnValue = YES;
                    } else if (0x3297 <= hs && hs <= 0x3299) {
                        returnValue = YES;
                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                        returnValue = YES;
                    }else if (hs == 0x200d){
                        returnValue = YES;
                    }
                }
            }];
    return returnValue;
}

#pragma mark - 过滤非汉字、字母、数字字符
+ (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-zA-Z0-9\u4e00-\u9fa5]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0                                range:NSMakeRange(0, [text length]) withTemplate:@""];
    return modifiedString;
}

+ (NSString *)textViewDisable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0
        range:NSMakeRange(0, [text length]) withTemplate:@""];
    return modifiedString;
}

#pragma mark - 过滤非字母、数字字符
+ (NSString *)disable_letterNumber:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-zA-Z0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0                                range:NSMakeRange(0, [text length]) withTemplate:@""];
    return modifiedString;
}


@end

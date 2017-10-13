//
//  MethodToolsModel.h
//  FutureSports
//
//  Created by wangbin on 2017/9/28.
//  Copyright © 2017年 wangbin. All rights reserved.
//

/**
 判断输入框(登录密码)
 */

#import <Foundation/Foundation.h>

@interface MethodToolsModel : NSObject
//手机号判断
+ (BOOL)isValidateMobile:(NSString *)mobile;
//邮箱判断
+ (BOOL)isValidateEmail:(NSString *)email;
//驴号判断
+ (BOOL)isValidateAcconut:(NSString *)account;
//表情判断
+ (BOOL)stringContainsEmoji:(NSString *)string;
//过滤非汉字、字母、数字字符
+ (NSString *)disable_emoji:(NSString *)text;
+ (NSString *)textViewDisable_emoji:(NSString *)text;
//过滤非字母、数字字符
+ (NSString *)disable_letterNumber:(NSString *)text;

@end

//
//  WBViewTool.h
//  FutureSports
//
//  Created by wangbin on 2017/9/26.
//  Copyright © 2017年 wangbin. All rights reserved.
//

//自定义按钮/时间戳


#import <Foundation/Foundation.h>

@interface WBViewTool : NSObject

//登录按钮样式(蓝底)
+ (UIButton *)initWithLoginButton:(NSString *)title;
//注册按钮样式(白底)
+ (UIButton *)initWithRegisterButton:(NSString *)title;

#pragma mark - 时间戳转换
//yyyy-MM-dd HH:mm
+ (NSString *)getTimeString:(long)time;
//yyyy-MM-dd
+ (NSString *)getShortTimeString:(long)time;
//yyyy/MM/dd HH:mm:ss
+ (NSString *)getLongTimeString:(long)time;

@end

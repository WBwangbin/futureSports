//
//  WBViewTool.m
//  FutureSports
//
//  Created by wangbin on 2017/9/26.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "WBViewTool.h"

@implementation WBViewTool

//登录按钮样式(蓝底)
+ (UIButton *)initWithLoginButton:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    button.backgroundColor = LoginButtonColor;
    button.layer.cornerRadius = 23;
    button.layer.borderWidth = 1;
    button.layer.borderColor = ButtonBorderNormalStateColor.CGColor;
    return button;
}

//注册按钮样式(白底)
+ (UIButton *)initWithRegisterButton:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:0.1 alpha:0.8] forState:UIControlStateHighlighted];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 23;
    button.layer.borderWidth = 1;
    button.layer.borderColor = ButtonBorderNormalStateColor.CGColor;
    return button;
}



#pragma mark - 时间戳转换
+ (NSString *)getTimeString:(long)time
{
    NSTimeInterval _interval = time;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [objDateformat stringFromDate: date];
}

+ (NSString *)getShortTimeString:(long)time
{
    NSTimeInterval _interval = time;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd"];
    return [objDateformat stringFromDate:date];
}

+ (NSString *)getLongTimeString:(long)time
{
    NSTimeInterval _interval = time;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    return [objDateformat stringFromDate: date];
}


@end

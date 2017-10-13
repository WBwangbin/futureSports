//
//  WBPerferences.m
//  FutureSports
//
//  Created by wangbin on 2017/10/2.
//  Copyright © 2017年 wangbin. All rights reserved.
//


static NSString *const IS_FIRST_START_KEY = @"isFirstStart";
static NSString *const CURRENT_LOCATION_INFO_KEY = @"CurrentLocationInfo";

#import "WBPerferences.h"

@implementation WBPerferences

//单例
+ (id)sharedInstance
{
    static WBPerferences *settingUtils;
    @synchronized (self)
    {
        if (settingUtils == nil)
        {
            settingUtils = [[super allocWithZone:NULL] init];
            // 初始化基本信息
            settingUtils.networkType = 1;//默认设置为WIFI网络类型
            settingUtils.networkConnectionStatus = SVRealStatusNotReachable;//默认设置为网络不可达
        }
    }

    return settingUtils;
}

//覆写allocWithZone方法
+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [WBPerferences sharedInstance];
}
//覆写copyWithZone方法
+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [WBPerferences sharedInstance];
}

//是否是第一次启动
- (void)setFirstStart:(BOOL)firstStart
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:firstStart forKey:IS_FIRST_START_KEY];
    [defaults synchronize];
}
- (BOOL)isFirstStart
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:IS_FIRST_START_KEY];
}

//当前位置信息
- (void)setLocationInfo:(NSMutableDictionary *)locationInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:locationInfo forKey:CURRENT_LOCATION_INFO_KEY];
    [defaults synchronize];
}

- (NSMutableDictionary *)getLocationInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *locationInfo = [defaults valueForKey:CURRENT_LOCATION_INFO_KEY];
    return locationInfo;
}

@end

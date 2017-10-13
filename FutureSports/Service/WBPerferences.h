//
//  WBPerferences.h
//  FutureSports
//
//  Created by wangbin on 2017/10/2.
//  Copyright © 2017年 wangbin. All rights reserved.
//


/**
 *** 偏好设置
 **/

#import <Foundation/Foundation.h>
#import "NetworkChangeMonitor.h"

typedef NS_ENUM (NSUInteger, NetworkType) {//网络类型
    MobileNetworkType,
    WifiNetworkType,
};

@interface WBPerferences : NSObject
@property (nonatomic, assign) NetworkChangeMonitorStatus networkConnectionStatus;//网络连接状态
@property (nonatomic, copy) NSString *wifiName;
@property (nonatomic, assign) NetworkType networkType;//网络类型
//单例
+ (id)sharedInstance;

//设置是否是第一次启动
- (void)setFirstStart:(BOOL)firstStart;
- (BOOL)isFirstStart;

//当前位置信息
- (void)setLocationInfo:(NSMutableDictionary *)locationInfo;
- (NSMutableDictionary *)getLocationInfo;
@end

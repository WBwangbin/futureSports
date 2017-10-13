//
//  NetworkChangeMonitor.h
//  FutureSports
//
//  Created by wangbin on 2017/9/28.
//  Copyright © 2017年 wangbin. All rights reserved.
//


/**
 *** 实时监控网络状态
 **/

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, NetworkChangeMonitorStatus) {
    SVRealStatusNotReachable = 0,//网络不可达/网络不通
    SVRealStatusViaWWAN = 1,
    SVRealStatusViaWiFi = 2,
    SVWWANType2G = 3,
    SVWWANType3G = 4,
    SVWWANType4G = 5
};


@protocol NetworkChangeMonitorDelegate <NSObject>

@required

- (void)networkStatusChange:(NetworkChangeMonitorStatus)status;

@end

@interface NetworkChangeMonitor : NSObject



/**
 *  单例
 *
 *  @return 单例对象
 */
+ (id)sharedInstance;

/**
 *  覆写allocWithZone方法
 *
 *  @param zone _NSZone
 *
 *  @return 单例对象
 */
+ (id)allocWithZone:(struct _NSZone *)zone;

/**
 *  覆写copyWithZone方法
 *
 *  @param zone _NSZone
 *
 *  @return 单例对象
 */
+ (id)copyWithZone:(struct _NSZone *)zone;

/**
 *  新增加代理，用于网络状态变更时实时通知
 *
 *  @param delegate 代理
 */
- (void)addDelegate:(id<NetworkChangeMonitorDelegate>)delegate;

/**
 *  移除代理
 *
 *  @param delegate 代理
 */
- (void)removeDelegate:(id<NetworkChangeMonitorDelegate>)delegate;
/**
 *  获取网络实时状态
 *
 *  @return 网络实时状态
 */
- (NetworkChangeMonitorStatus)getNetworkStatus;

//网络状态是否可达
- (BOOL)isReachable;

//检测网络
-(void)networkChangeMonitorNotification;

//观察者实时检测方法
- (void)networkChanged:(NSNotification *)notification;
@end

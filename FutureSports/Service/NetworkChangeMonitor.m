//
//  NetworkChangeMonitor.m
//  FutureSports
//
//  Created by wangbin on 2017/9/28.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "NetworkChangeMonitor.h"
#import "RealReachability.h"

@implementation NetworkChangeMonitor
{
    BOOL _isStartMonitor;
    NetworkChangeMonitorStatus _realStatus;
}
static NSMutableArray *delegates;
/**
 *  单例
 *
 *  @return 单例对象
 */
+ (id)sharedInstance
{
    static NetworkChangeMonitor *reachability;
    @synchronized (self)
    {
        if (reachability == nil)
        {
            reachability = [[super allocWithZone:NULL] init];
            reachability->_realStatus = SVRealStatusNotReachable;
            delegates = [[NSMutableArray alloc] init];
            [reachability networkChangeMonitorNotification];
        }
    }
    return reachability;
}

/**
 *  覆写allocWithZone方法
 *
 *  @param zone _NSZone
 *
 *  @return 单例对象
 */
+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [NetworkChangeMonitor sharedInstance];
}

/**
 *  覆写copyWithZone方法
 *
 *  @param zone _NSZone
 *
 *  @return 单例对象
 */
+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [NetworkChangeMonitor sharedInstance];
}

/**
 *  新增加代理，用于网络状态变更时实时通知
 *
 *  @param delegate 代理
 */
- (void)addDelegate:(id<NetworkChangeMonitorDelegate>)delegate
{
    @synchronized (delegates)
    {
        [delegates addObject:delegate];
    }
}

/**
 *  移除代理
 *  NetworkChangeMonitor
 *  @param delegate 代理
 */
- (void)removeDelegate:(id<NetworkChangeMonitorDelegate>)delegate
{
    @synchronized (delegates)
    {
        [delegates removeObject:delegate];
    }
}

- (NetworkChangeMonitorStatus)getNetworkStatus
{
    RealReachability *rr = [RealReachability sharedInstance];
    ReachabilityStatus reachable = [rr currentReachabilityStatus];
    switch (reachable)
    {
        case RealStatusViaWWAN:
            return SVRealStatusViaWWAN;
        case RealStatusViaWiFi:
            return SVRealStatusViaWiFi;
        default:
            return SVRealStatusNotReachable;
            break;
    }
}

- (BOOL)isReachable
{
    RealReachability *rr = [RealReachability sharedInstance];
    ReachabilityStatus reachable = [rr currentReachabilityStatus];
    switch (reachable)
    {
        case RealStatusViaWWAN:
            return YES;
        case RealStatusViaWiFi:
            return YES;
        default:
            return NO;
            break;
    }
}
//开始监控网络
- (void)networkChangeMonitorNotification
{
    //打开检测
    [GLobalRealReachability startNotifier];
    //网络改变时调用通知:
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (networkChanged:)
                                                 name:@"kRealReachabilityChangedNotification"
                                               object:nil];
}

//网络改变通知
- (void)networkChanged:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];

    if (status == RealStatusViaWiFi)
    {
        _realStatus = SVRealStatusViaWiFi;
        NSLog(@"WiFi网络,Network wifi! Free!");
    }
    else if (status == RealStatusViaWWAN)
    {
        WWANAccessType accessType = [GLobalRealReachability currentWWANtype];
        if (accessType == WWANType4G)
        {
            _realStatus = SVWWANType4G;
            NSLog(@"2/3/4G网络,RealReachabilityStatus4G");
        }
        else if (accessType == WWANType3G)
        {
            _realStatus = SVWWANType3G;
            NSLog(@"2/3/4G网络,RealReachabilityStatus3G");
        }
        else if (accessType == WWANType2G)
        {
            _realStatus = SVWWANType2G;
            NSLog(@"2/3/4G网络,RealReachabilityStatus2G");
        }else{
            _realStatus = SVRealStatusNotReachable;
            NSLog(@"Unknown RealReachability WWAN Status, might be iOS6");
        }
    }
    else
    {
        _realStatus = SVRealStatusNotReachable;
        NSLog(@"没有网络,Network unreachable!");
    }

    for (id<NetworkChangeMonitorDelegate> delegate in delegates)
    {
        [delegate networkStatusChange:_realStatus];
    }
}

@end

//
//  SVCurrentDevice.h
//  FutureSports
//
//  Created by wangbin on 2017/9/28.
//  Copyright © 2017年 wangbin. All rights reserved.
//


/**
 *** 获取设备信息-手机型号/获取ip/WiFi网络名称
 **/


#import <Foundation/Foundation.h>

@interface SVCurrentDevice : NSObject

#define UNKNOWN_WIFI_NAME @""
#define MOBILE_WIFI_NAME @"-1"
/**
 *  获取当前手机型号
 *
 *  @return 手机型号。 i386 和 x86_64 对应的是模拟器
 */
+ (NSString *)deviceType;

/**
 *  获取ip
 *
 *  @return ip
 */
+ (NSString *)getIPAddress;

/**
 *  获取WiFi网络名称。
 *  注意：该方法只在真机可用，真机可用正常获取WiFi名称
 *
 *  @return WiFi网络名称
 */
+ (NSString *)getWifiName;

@end

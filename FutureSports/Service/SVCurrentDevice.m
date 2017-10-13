//
//  SVCurrentDevice.m
//  FutureSports
//
//  Created by wangbin on 2017/9/28.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "SVCurrentDevice.h"
#import "sys/utsname.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#include <arpa/inet.h>
#include <ifaddrs.h>

@implementation SVCurrentDevice


/**
 *  获取当前手机型号
 *
 *  @return 手机型号。 i386 和 x86_64 对应的是模拟器
 */
+ (NSString *)deviceType
{
    struct utsname systemInfo;
    uname (&systemInfo);
    NSString *deviceString =
    [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    NSArray *modelArray = @[

        // iPhone Simulator
        @"i386",
        @"x86_64",

        // iPhone
        @"iPhone1,1",
        @"iPhone1,2",
        @"iPhone2,1",
        @"iPhone3,1",
        @"iPhone3,2",
        @"iPhone3,3",
        @"iPhone4,1",
        @"iPhone5,1",
        @"iPhone5,2",
        @"iPhone5,3",
        @"iPhone5,4",
        @"iPhone6,1",
        @"iPhone6,2",
        @"iPhone7,1",
        @"iPhone7,2",
        @"iPhone8,1",
        @"iPhone8,2",
        @"iPhone9,1",
        @"iPhone9,2",
        @"iPhone10,1",
        @"iPhone10,2",
        @"iPhone11,1",

        // iPod Touch
        @"iPod1,1",
        @"iPod2,1",
        @"iPod3,1",
        @"iPod4,1",
        @"iPod5,1",
        @"iPod7,1",

        // iPad
        @"iPad1,1",
        @"iPad2,1",
        @"iPad2,2",
        @"iPad2,3",
        @"iPad2,4",
        @"iPad3,1",
        @"iPad3,2",
        @"iPad3,3",
        @"iPad3,4",
        @"iPad3,5",
        @"iPad3,6",
        @"iPad4,1",
        @"iPad4,2",
        @"iPad4,3",
        @"iPad4,4",
        @"iPad4,5",
        @"iPad4,6",

        // iPad mini
        @"iPad2,5",
        @"iPad2,6",
        @"iPad2,7",
    ];


    NSArray *modelNameArray = @[

        // iPhone Simulator
        @"iPhone Simulator i386",
        @"iPhone Simulator x86_64",

        // iPhone
        @"iPhone 2G",
        @"iPhone 3G",
        @"iPhone 3GS",
        @"iPhone 4(GSM)",
        @"iPhone 4(GSM Rev A)",
        @"iPhone 4(CDMA)",
        @"iPhone 4S",
        @"iPhone 5(GSM)",
        @"iPhone 5(GSM+CDMA)",
        @"iPhone 5c(GSM)",
        @"iPhone 5c(Global)",
        @"iphone 5s(GSM)",
        @"iphone 5s(Global)",
        @"iPhone 6 Plus (A1522/A1524)",
        @"iPhone 6 (A1549/A1586)",
        @"iPhone 6s (A1633/A1688/A1691/A1700)",
        @"iPhone 6s Plus (A1634/A1687/A1690/A1699)",
        @"iPhone 7(A1660)",
        @"iPhone 7 Plus ",
        @"iPhone 8",
        @"iPhone 8 Plus ",
        @"iPhone X",

        // iPod Touch
        @"iPod Touch 1G",
        @"iPod Touch 2G",
        @"iPod Touch 3G",
        @"iPod Touch 4G",
        @"iPod Touch 5G",
        @"iPod Touch 6G (A1574)",

        // iPad
        @"iPad",
        @"iPad 2(WiFi)",
        @"iPad 2(GSM)",
        @"iPad 2(CDMA)",
        @"iPad 2(WiFi + New Chip)",
        @"iPad 3(WiFi)",
        @"iPad 3(GSM+CDMA)",
        @"iPad 3(GSM)",
        @"iPad 4(WiFi)",
        @"iPad 4(GSM)",
        @"iPad 4(GSM+CDMA)",
        @"iPad Air",
        @"iPad Air",
        @"iPad Air",
        @"iPad Mini 2G",
        @"iPad Mini 2G",
        @"iPad Mini 2G",

        // iPad mini
        @"iPad mini (WiFi)",
        @"iPad mini (GSM)",
        @"ipad mini (GSM+CDMA)"
    ];

    NSInteger modelIndex = -1;
    NSString *modelNameString = nil;
    modelIndex = [modelArray indexOfObject:deviceString];
    if (modelIndex >= 0 && modelIndex < [modelNameArray count])
    {
        modelNameString = [modelNameArray objectAtIndex:modelIndex];
    }
    else
    {
        modelNameString = deviceString;
    }

    return modelNameString;
}


+ (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;

    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs (&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL)
        {
            if (temp_addr->ifa_addr->sa_family == AF_INET || temp_addr->ifa_addr->sa_family == AF_INET6)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString
                    stringWithUTF8String:inet_ntoa (((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }

            temp_addr = temp_addr->ifa_next;
        }
    }

    // Free memory
    freeifaddrs (interfaces);

    return address;
}

/**
 *  获取WiFi网络名称
 *  注意：该方法只在真机可用，真机可用正常获取WiFi名称
 *
 *  @return WiFi网络名称
 */
+ (NSString *)getWifiName
{
    NSString *wifiName = UNKNOWN_WIFI_NAME;

    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces ();

    if (!wifiInterfaces)
    {
        NSLog (@"wifiInterfaces is nil ,return");
        return nil;
    }

    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;

    for (NSString *interfaceName in interfaces)
    {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo ((__bridge CFStringRef) (interfaceName));

        if (dictRef)
        {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            NSLog (@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];

            CFRelease (dictRef);
        }
    }

    CFRelease (wifiInterfaces);
    return wifiName;
}

@end

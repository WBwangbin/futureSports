//
//  SVNotificationEvent.m
//  FutureSports
//
//  Created by wangbin on 2017/9/25.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "SVNotificationEvent.h"

/**
 *  当网络状态进行切换，或者网络类型切换时，发送通知，进行状态更新处理
 */
NSString *const SVNetworkStatusDidChangeNotification = @"SVNetworkStatusDidChangeNotification";

/**
 *  当网络断开的时候，发送单独的通知
 */
NSString *const SVNetworkStatusErrorNotification = @"SVNetworkStatusErrorNotification";

/**
 *  上传日志成功后回掉通知
 */

NSString *const SVUploadLogFinishNotification = @"SVUploadSuccessNotification";

@implementation SVNotificationEvent

@end

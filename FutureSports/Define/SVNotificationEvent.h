//
//  SVNotificationEvent.h
//  FutureSports
//
//  Created by wangbin on 2017/9/25.
//  Copyright © 2017年 wangbin. All rights reserved.
//

/**
 *** 通知头
 **/

#import <Foundation/Foundation.h>
//我的
UIKIT_EXTERN NSString *const SVNetworkStatusDidChangeNotification;
UIKIT_EXTERN NSString *const SVNetworkStatusErrorNotification;
UIKIT_EXTERN NSString *const SVUploadLogFinishNotification;
@interface SVNotificationEvent : NSObject

@end

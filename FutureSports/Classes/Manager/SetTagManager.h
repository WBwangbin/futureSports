//
//  SetTagManager.h
//  FutureSports
//
//  Created by wangbin on 2017/9/28.
//  Copyright © 2017年 wangbin. All rights reserved.
//

/**
 *** 设置推送标签/别名
 **/

#import <Foundation/Foundation.h>

@interface SetTagManager : NSObject

+ (instancetype)shareTagManager;

- (void)setTagWithTagString:(NSString *)str Alias:(NSString *)alias;

@end

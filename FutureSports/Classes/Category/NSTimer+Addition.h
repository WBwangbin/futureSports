//
//  NSTimer+Addition.h
//  FutureSports
//
//  Created by wangbin on 2017/9/28.
//  Copyright © 2017年 wangbin. All rights reserved.
//

//定时器

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

- (void)pauseTimer;

- (void)resumeTimer;

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end

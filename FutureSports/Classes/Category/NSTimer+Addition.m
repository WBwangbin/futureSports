//
//  NSTimer+Addition.m
//  FutureSports
//
//  Created by wangbin on 2017/9/28.
//  Copyright © 2017年 wangbin. All rights reserved.
//

/*
 – isValid  //是否在运行
 – fireDate //Returns the date at which the receiver will fire.
 – setFireDate: //重新设置定时器开始运行的时间
 – timeInterval  //定时器延时时间
 – userInfo //其他信息
*/

#import "NSTimer+Addition.h"

@implementation NSTimer (Addition)


- (void)pauseTimer
{
    if (![self isValid]) {//如果定时器不在运行
        return;
    }
    [self setFireDate:[NSDate distantFuture]];//关闭定时器
    //随机返回一个比较遥远的未来时间
}

- (void)resumeTimer
{
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate distantPast]];//开启
    //随机返回一个比较遥远的过去时间
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end

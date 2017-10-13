//
//  SetTagManager.m
//  FutureSports
//
//  Created by wangbin on 2017/9/28.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "SetTagManager.h"
#import "JPUSHService.h"

static SetTagManager *manager;
@implementation SetTagManager

+ (instancetype)shareTagManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SetTagManager alloc] init];
    });
    
    return manager;
}

- (void)setTagWithTagString:(NSString *)str Alias:(NSString *)alias
{
    NSSet *set = [NSSet setWithObjects:str, nil];
    
    [JPUSHService setTags:set alias:alias callbackSelector:nil object:nil];
}

@end

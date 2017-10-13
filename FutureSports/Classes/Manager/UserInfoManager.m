//
//  UserInfoManager.m
//  FutureSports
//
//  Created by wangbin on 2017/10/9.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "UserInfoManager.h"

static UserInfoManager *manager;

@implementation UserInfoManager

+ (instancetype)shareUserInfoManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

@end

//
//  LoginModeViewController.h
//  FutureSports
//
//  Created by wangbin on 2017/9/26.
//  Copyright © 2017年 wangbin. All rights reserved.
//


/**
 *** 登录方式页
 **/

#import <UIKit/UIKit.h>
#import "SVJumpViewController.h"

@interface LoginModeViewController : UIViewController
@property (nonatomic, copy) NSString *device;

- (void)ButtonClickWechat;
- (void)ButtonClickWeibo;
- (void)ButtonClickqq;
@end

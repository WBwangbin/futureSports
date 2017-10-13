//
//  RegisterPhoneViewController.h
//  FutureSports
//
//  Created by wangbin on 2017/9/29.
//  Copyright © 2017年 wangbin. All rights reserved.
//

/**
 *** 注册-手机号注册
 **/

#import "SVJumpViewController.h"

@interface RegisterPhoneViewController : SVJumpViewController
@property (nonatomic, copy) void(^successPwd)(void);
@end

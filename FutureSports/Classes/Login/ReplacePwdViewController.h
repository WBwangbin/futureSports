//
//  ReplacePwdViewController.h
//  FutureSports
//
//  Created by wangbin on 2017/9/28.
//  Copyright © 2017年 wangbin. All rights reserved.
//

/**
 *** 忘记密码页
 **/

#import "SVJumpViewController.h"
@interface ReplacePwdViewController : SVJumpViewController
@property (nonatomic, copy) void(^successPwd)(void);//回调函数,密码设置成功后提示
@end

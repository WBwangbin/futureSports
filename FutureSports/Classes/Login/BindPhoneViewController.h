//
//  BindPhoneViewController.h
//  FutureSports
//
//  Created by wangbin on 2017/10/10.
//  Copyright © 2017年 wangbin. All rights reserved.
//
#import "SVJumpViewController.h"

@interface BindPhoneViewController : SVJumpViewController
@property (nonatomic, copy) NSString *device;
@property (nonatomic, copy) NSString *sourcetype;//1.QQ 2.weibo 3.wechat
@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) int sex;//0男 1女
@property (nonatomic, copy) NSString *headurl;
@end

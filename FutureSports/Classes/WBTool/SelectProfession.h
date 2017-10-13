//
//  SelectProfession.h
//  FutureSports
//
//  Created by wangbin on 2017/10/1.
//  Copyright © 2017年 wangbin. All rights reserved.
//

//自定义职位选择器

#import <UIKit/UIKit.h>

@interface SelectProfession : UIView

@property (nonatomic, copy) void (^block)(NSString *);

@end

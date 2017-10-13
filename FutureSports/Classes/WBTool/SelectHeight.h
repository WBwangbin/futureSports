//
//  SelectHeight.h
//  FutureSports
//
//  Created by wangbin on 2017/10/1.
//  Copyright © 2017年 wangbin. All rights reserved.
//

//自定义身高选择器

#import <UIKit/UIKit.h>

@interface SelectHeight : UIView

@property (nonatomic, copy) void (^block)(NSString *);

@end

//
//  SelectTimeV.h
//  FutureSports
//
//  Created by wangbin on 2017/9/29.
//  Copyright © 2017年 wangbin. All rights reserved.
//

//自定义时间选择器

#import <UIKit/UIKit.h>

@interface SelectTimeV : UIView

@property (nonatomic, copy) void (^block)(NSString *);

@end

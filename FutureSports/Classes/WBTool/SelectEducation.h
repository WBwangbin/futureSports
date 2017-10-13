//
//  SelectEducation.h
//  FutureSports
//
//  Created by wangbin on 2017/10/1.
//  Copyright © 2017年 wangbin. All rights reserved.
//

//自定义学历选择器

#import <UIKit/UIKit.h>

@interface SelectEducation : UIView

@property (nonatomic, copy) void (^block)(NSString *);

@end

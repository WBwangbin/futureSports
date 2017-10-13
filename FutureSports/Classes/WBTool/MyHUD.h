//
//  MyHUD.h
//  FutureSports
//
//  Created by wangbin on 2017/9/28.
//  Copyright © 2017年 wangbin. All rights reserved.
//

//加载等待动画(自定义转菊花/弹出提示)

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface MyHUD : NSObject

//展示文本提示
+ (void)showInView:(UIView *)view text:(NSString *)text;
//展示动图提示
+ (MBProgressHUD *)showHUDAddTo:(UIView *)view animated:(BOOL)animated;
//隐藏提示
+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;

@end

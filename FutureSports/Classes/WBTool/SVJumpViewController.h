//
//  SVJumpViewController.h
//  FutureSports
//
//  Created by wangbin on 2017/9/29.
//  Copyright © 2017年 wangbin. All rights reserved.
//

//没有tabbar,默认是自定义返回按钮,initwithRightButton方法是既有返回又有跳过按钮

#import <UIKit/UIKit.h>

@interface SVJumpViewController : UIViewController

-(UIView *)initwithRightButton:(NSString *)str;

@end

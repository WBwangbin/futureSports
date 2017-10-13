//
//  SVHtmlTools.h
//  FutureSports
//
//  Created by wangbin on 2017/9/27.
//  Copyright © 2017年 wangbin. All rights reserved.
//

/**
 *** 加载内置网页
 */

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface SVHtmlTools : NSObject

- (void)loadHtmlWithFileName:(NSString *)fileName webView:(WKWebView *)webView;

@end

//
//  HTMLController.m
//  FutureSports
//
//  Created by wangbin on 2017/9/27.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "SVHtmlTools.h"
#import "HTMLController.h"
#import <WebKit/WebKit.h>

@interface HTMLController ()
@end

@implementation HTMLController
{
    NSString *clauseName;//条框名称
}

-(instancetype)initWithWebName:(NSString *)name
{
    if (self = [super init])
    {
        clauseName = name;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBackButton];
    [self comeBackSuperViewWhenSwipeRight];

    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.selectionGranularity = WKSelectionGranularityCharacter;
    WKWebView *webView = [[WKWebView alloc] init];
    webView.backgroundColor = [UIColor whiteColor];
    //设置当前View是否不透明
    webView.opaque = NO;
    //禁用回弹
    webView.scrollView.bounces = NO;
    //禁用滑动
    webView.scrollView.scrollEnabled = NO;
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.and.height.equalTo (self.view);
      make.left.mas_equalTo (self.view.mas_left).with.offset (SafeDistanceDouble);
      make.right.mas_equalTo (self.view.mas_right).with.offset (-SafeDistanceDouble);
    }];
    // 加载内置的网页
    SVHtmlTools *htmlTool = [[SVHtmlTools alloc] init];
    [htmlTool loadHtmlWithFileName:clauseName webView:webView];
}


@end

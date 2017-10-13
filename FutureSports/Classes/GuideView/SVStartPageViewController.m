//
//  SVStartPageViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/9/25.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "AppDelegate.h"
#import "SVGuideView.h"
#import "SVStartPageViewController.h"
#import "LoginViewController.h"


// 指导页的个数
static const int GUIDE_VIEW_NUM = 2;
@interface SVStartPageViewController ()
@end

@implementation SVStartPageViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"进入到启动页");
    //隐藏navigationBar
    self.navigationController.navigationBar.hidden = YES;
    //设置电池栏字体颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    // 显示新功能指引界面
    [self showGuideView];
}

- (void)showGuideView
{
    SVGuideView *guideView = [[SVGuideView alloc] initWithPageNumber:GUIDE_VIEW_NUM];
    guideView.delegate = self;
    [self.view addSubview:guideView];
}

#pragma mark  代理方法 

- (void)hideGuideView:(SVGuideView *)guideView
{
//    #pragma mark 坑
//    LoginViewController *loginVc = [[LoginViewController alloc]init];
//    [self.navigationController pushViewController:loginVc animated:YES];

        LoginViewController *loginVc = [[LoginViewController alloc]init];
        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
        window.rootViewController = [[UINavigationController alloc]initWithRootViewController:loginVc ];
}

@end

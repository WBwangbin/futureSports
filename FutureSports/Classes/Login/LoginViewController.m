//
//  LoginViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/9/25.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginModeViewController.h"
#import "RegisterModeViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"进入到新用户-登录/注册页");
    self.view.backgroundColor = [UIColor whiteColor];
    //设置电池栏字体颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    //隐藏navigationBar
    self.navigationController.navigationBar.hidden = YES;
    [self creatUI];
}

-(void)creatUI
{
    //应用logo
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_icon"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).with.offset(-150);
        make.size.equalTo(CGSizeMake(115,115));
    }];

    UILabel *welcomeLabel = [[UILabel alloc]init];
    [welcomeLabel setText:@"欢迎使用"];
    [welcomeLabel setFont:[UIFont systemFontOfSize:28]];
    [welcomeLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:welcomeLabel];
    [welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.bottom).with.offset(50);
        make.centerX.equalTo(self.view);
    }];

    //登录按钮
    UIButton *buttonLogin = [WBViewTool  initWithLoginButton:@"登录"];
    [buttonLogin addTarget:self
                    action:@selector (buttonLoginClick:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonLogin];
    [buttonLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.bottom.equalTo (self.view.bottom).with.offset (-150);
        make.height.mas_equalTo (45);
        make.left.mas_equalTo (self.view.left).with.offset(50);
        make.right.mas_equalTo (self.view.right).with.offset(-50);
    }];
    //注册按钮
    UIButton *buttonRegister = [WBViewTool  initWithLoginButton:@"注册"];
    [buttonRegister addTarget:self
                       action:@selector (buttonRegisterClick:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonRegister];
    [buttonRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.top.equalTo (buttonLogin.bottom).with.offset (30);
        make.size.equalTo(buttonLogin);
    }];
}

//点击事件
- (void)buttonLoginClick:(UIButton *)button
{
    LoginModeViewController * loginModeViewController = [[LoginModeViewController alloc]init];
    [self.navigationController pushViewController:loginModeViewController animated:YES];

}

- (void)buttonRegisterClick:(UIButton *)button
{
    RegisterModeViewController * registerModeViewController = [[RegisterModeViewController alloc]init];
    [self.navigationController pushViewController:registerModeViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

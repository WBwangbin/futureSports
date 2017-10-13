//
//  RegisterModeViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/9/26.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "RegisterModeViewController.h"
#import "HTMLController.h"
#import "RegisterPhoneViewController.h"
#import "BindPhoneViewController.h"

@interface RegisterModeViewController ()

@end

@implementation RegisterModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进入到注册方式页");
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
}
-(void)creatUI
{
    //文字
    UILabel *registerLabel = [[UILabel alloc] init];
    [self.view addSubview:registerLabel];
    registerLabel.text = @"注册";
    registerLabel.font = [UIFont systemFontOfSize:22];
    registerLabel.textColor = [UIColor blackColor];
    [registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.top.equalTo (self.view.top).with.offset(100);
    }];

    //手机注册按钮
    UIButton *registerButton = [WBViewTool  initWithLoginButton:@"手机注册"];
    [registerButton addTarget:self
                    action:@selector (registerButtonClick:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.top.equalTo (registerLabel.bottom).with.offset (50);
        make.height.mas_equalTo (45);
        make.left.mas_equalTo (self.view.left).with.offset(50);
        make.right.mas_equalTo (self.view.right).with.offset(-50);
    }];

    if (!self.loginCtrl) {
        self.loginCtrl = [[LoginModeViewController alloc]init];
    }
    //三方注册
    UIButton *weChatButton = [WBViewTool initWithRegisterButton:@"微信注册"];
    [weChatButton addTarget:self.loginCtrl action:@selector(ButtonClickWechat) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:weChatButton];
    [weChatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.top.equalTo (registerButton.bottom).with.offset (70);
        make.height.mas_equalTo (45);
        make.left.mas_equalTo (self.view.left).with.offset(50);
        make.right.mas_equalTo (self.view.right).with.offset(-50);
    }];

    UIButton *weiboButton = [WBViewTool  initWithRegisterButton:@"微博注册"];
    [weiboButton addTarget:self.loginCtrl
                     action:@selector (ButtonClickWeibo)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weiboButton];
    [weiboButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.top.equalTo (weChatButton.bottom).with.offset (20);
        make.height.mas_equalTo (45);
        make.left.mas_equalTo (self.view.left).with.offset(50);
        make.right.mas_equalTo (self.view.right).with.offset(-50);
    }];

    UIButton *qqButton = [WBViewTool  initWithRegisterButton:@"QQ注册"];
    [qqButton addTarget:self.loginCtrl
                    action:@selector (ButtonClickqq)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqButton];
    [qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.top.equalTo (weiboButton.bottom).with.offset (20);
        make.height.mas_equalTo (45);
        make.left.mas_equalTo (self.view.left).with.offset(50);
        make.right.mas_equalTo (self.view.right).with.offset(-50);
    }];

    //文字
    UILabel * agreeLabel = [[UILabel alloc] init];
    [self.view addSubview:agreeLabel];
    agreeLabel.text = @"注册即表示同意.未来体育";
    agreeLabel.font = [UIFont systemFontOfSize:10];
    agreeLabel.textColor = [UIColor blackColor];
    [agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX).with.offset(-50);
        make.bottom.equalTo(self.view.bottom);
        make.height.equalTo(50);
    }];
    //HyperlinksButton
    UIButton *serviceButton = [[HyperlinksButton alloc]initWithTitle:@"服务条款" Font:10 LineColor:[UIColor blackColor] TitleColor:[UIColor blackColor]];
    [serviceButton addTarget:self
                         action:@selector (serviceButtonClick:)
               forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serviceButton];
    [serviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(agreeLabel.right);
        make.bottom.equalTo(self.view.bottom);
        make.height.equalTo(50);
    }];

    //文字
    UILabel * andLabel = [[UILabel alloc] init];
    [self.view addSubview:andLabel];
    andLabel.text = @"和";
    andLabel.font = [UIFont systemFontOfSize:10];
    andLabel.textColor = [UIColor blackColor];
    [andLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(serviceButton.right);;
        make.bottom.equalTo(self.view.bottom);
        make.height.equalTo(50);
    }];
    //HyperlinksButton
    UIButton *privacyButton = [[HyperlinksButton alloc]initWithTitle:@"隐私条款" Font:10 LineColor:[UIColor blackColor] TitleColor:[UIColor blackColor]];
    [privacyButton addTarget:self
                    action:@selector (privacyButtonClick:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:privacyButton];
    [privacyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(andLabel.right);
        make.bottom.equalTo(self.view.bottom);
        make.height.equalTo(50);
    }];

}
//点击事件
- (void)registerButtonClick:(UIButton *)button
{
    NSLog (@"手机注册");
    RegisterPhoneViewController * registerPhoneViewController = [[RegisterPhoneViewController alloc]init];
    [self.navigationController pushViewController:registerPhoneViewController animated:YES];
}

- (void)serviceButtonClick:(UIButton *)button
{
    NSLog (@"进入服务条款");
    HTMLController *serviceCtrl = [[HTMLController alloc] initWithWebName:@"faq"];
    serviceCtrl.title = @"服务条款";
    [self.navigationController pushViewController:serviceCtrl animated:YES];
}

- (void)privacyButtonClick:(UIButton *)button
{
    NSLog (@"进入隐私条款");
    HTMLController *privacyCtrl = [[HTMLController alloc] initWithWebName:@"Privacy"];
    privacyCtrl.title = @"隐私条款";
    [self.navigationController pushViewController:privacyCtrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

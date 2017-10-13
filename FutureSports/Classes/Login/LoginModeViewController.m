//
//  LoginModeViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/9/26.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "LoginModeViewController.h"
#import "LoginPwdViewController.h"
#import "RegisterModeViewController.h"
#import "BindPhoneViewController.h"
#import <UMSocialCore/UMSocialCore.h>

@interface LoginModeViewController ()
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *headurl;
@property (nonatomic, assign) int sex;//0男 1女
@end

@implementation LoginModeViewController
{
    UILabel *otherLoginLabel;
    UIView *sharedView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进入到登录方式页");
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
}

-(void)creatUI
{
    //文字
    UILabel *loginLabel = [[UILabel alloc] init];
    [self.view addSubview:loginLabel];
    loginLabel.text = @"登录";
    loginLabel.font = [UIFont systemFontOfSize:22];
    loginLabel.textColor = [UIColor blackColor];
    [loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.top.equalTo (self.view.top).with.offset(100);
    }];

    //手机登录按钮
    UIButton *buttonLogin = [WBViewTool  initWithLoginButton:@"手机登录"];
    [buttonLogin addTarget:self
                    action:@selector (buttonLoginClick:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonLogin];
    [buttonLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.top.equalTo (loginLabel.bottom).with.offset (50);
        make.height.mas_equalTo (45);
        make.left.mas_equalTo (self.view.left).with.offset(50);
        make.right.mas_equalTo (self.view.right).with.offset(-50);
    }];

    //文字
    otherLoginLabel = [[UILabel alloc] init];
    [self.view addSubview:otherLoginLabel];
    otherLoginLabel.text = @"其他登录方式";
    otherLoginLabel.font = [UIFont systemFontOfSize:16];
    otherLoginLabel.textColor = [UIColor blackColor];
    [otherLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.top.equalTo(buttonLogin.bottom).with.offset(140);
    }];

    //创建第三方登录按钮
    [self creatSharedView];

    //文字
    UILabel * nowLabel = [[UILabel alloc] init];
    [self.view addSubview:nowLabel];
    nowLabel.text = @"你还没有账号?现在就去";
    nowLabel.font = [UIFont systemFontOfSize:10];
    nowLabel.textColor = [UIColor blackColor];
    [nowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX).with.offset(-10);
        make.bottom.equalTo(self.view.bottom);
        make.height.equalTo(50);
    }];
    //HyperlinksButton
    UIButton *buttonGoRegister = [[HyperlinksButton alloc]initWithTitle:@"注册" Font:10 LineColor:[UIColor blackColor] TitleColor:[UIColor blackColor]];
    [buttonGoRegister addTarget:self
                    action:@selector (buttonGoRegisterClick:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonGoRegister];
    [buttonGoRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nowLabel.right);
        make.bottom.equalTo(self.view.bottom);
        make.height.equalTo(50);
    }];

}

//用masony布局九宫格(单行按钮或文字)
- (void)creatSharedView
{
    sharedView = [[UIView alloc] init];
    [self.view addSubview:sharedView];

    CGFloat margin = 30;
    CGFloat marginLeftRight = 60;
    CGFloat buttonW = (kScreenW - marginLeftRight * 2 - margin * 2) / 3;

    //微信按钮
    UIButton *weChatButton = [[UIButton alloc] init];
    [weChatButton setImage:[UIImage imageNamed:@"login_weixin"]
                  forState:UIControlStateNormal];
    [weChatButton addTarget:self
                     action:@selector (ButtonClickWechat)
           forControlEvents:UIControlEventTouchUpInside];
    [sharedView addSubview:weChatButton];

    // weChat
    UILabel *weChatLabel = [[UILabel alloc] init];
    weChatLabel.text = @"微信";
    weChatLabel.textAlignment = NSTextAlignmentCenter;
    weChatLabel.font = [UIFont systemFontOfSize:SmallFontSize];
    weChatLabel.textColor = DeepBlueTextColor;
    [sharedView addSubview:weChatLabel];

    //微博
    UIButton *weiboButton = [[UIButton alloc] init];
    [weiboButton setImage:[UIImage imageNamed:@"login_weibo"]
                 forState:UIControlStateNormal];
    [weiboButton addTarget:self
                    action:@selector (ButtonClickWeibo)
          forControlEvents:UIControlEventTouchUpInside];
    [sharedView addSubview:weiboButton];

    // weibo
    UILabel *weiboLabel = [[UILabel alloc] init];
    weiboLabel.text = @"微博";
    weiboLabel.textAlignment = NSTextAlignmentCenter;
    weiboLabel.font = [UIFont systemFontOfSize:SmallFontSize];
    weiboLabel.textColor = DeepBlueTextColor;
    [sharedView addSubview:weiboLabel];
    //qq
    UIButton *qqButton = [[UIButton alloc] init];
    [qqButton setImage:[UIImage imageNamed:@"login_qq"]
                    forState:UIControlStateNormal];
    [qqButton addTarget:self
                       action:@selector (ButtonClickqq)
             forControlEvents:UIControlEventTouchUpInside];
    [sharedView addSubview:qqButton];
    // qq
    UILabel *qqLabel = [[UILabel alloc] init];
    qqLabel.text = @"QQ";
    qqLabel.textAlignment = NSTextAlignmentCenter;
    qqLabel.font = [UIFont systemFontOfSize:SmallFontSize];
    qqLabel.textColor = DeepBlueTextColor;
    [sharedView addSubview:qqLabel];

    [sharedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (otherLoginLabel.bottom).with.offset(20);
        make.left.equalTo (self.view);
        make.right.equalTo (self.view);
        make.height.equalTo (150);
    }];

    [weChatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (sharedView.mas_top);
        make.left.equalTo (sharedView.mas_left).with.offset(marginLeftRight);
        make.width.mas_equalTo (buttonW);
        make.height.mas_equalTo (buttonW);
    }];

    [weChatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weChatButton.mas_bottom);
        make.centerX.equalTo (weChatButton.mas_centerX);
    }];

    [weiboButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (sharedView.mas_top);
        make.left.equalTo (weChatButton.mas_right).with.offset (margin);
        make.width.equalTo (weChatButton.mas_width);
        make.height.equalTo (weChatButton.mas_height);
    }];

    [weiboLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weiboButton.mas_bottom);
        make.centerX.equalTo (weiboButton.mas_centerX);
    }];

    [qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (sharedView.mas_top);
        make.left.equalTo (weiboButton.mas_right).with.offset (margin);
        make.width.equalTo (weChatButton.mas_width);
        make.height.equalTo (weChatButton.mas_height);
    }];

    [qqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (qqButton.mas_bottom);
        make.centerX.equalTo (qqButton.mas_centerX);
    }];

}

//点击事件
- (void)buttonLoginClick:(UIButton *)button
{
    NSLog (@"手机登录");
    LoginPwdViewController * loginPwdViewController = [[LoginPwdViewController alloc]init];
    [self.navigationController pushViewController:loginPwdViewController animated:YES];
}
- (void)buttonGoRegisterClick:(UIButton *)button
{
    NSLog (@"去注册页");
    RegisterModeViewController * registerModeViewController = [[RegisterModeViewController alloc]init];
    registerModeViewController.loginCtrl = self;
    [self.navigationController pushViewController:registerModeViewController animated:YES];
}

- (void)ButtonClickWechat
{
    NSLog (@"微信登录");
    __weak typeof(self)weakSelf = self;
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatTimeLine currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"微信登录失败---%@",error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);

            // 第三方登录数据(为空表示平台未提供)
            // 授权数据
            NSLog(@" uid: %@", resp.uid);
            NSLog(@" openid: %@", resp.openid);
            NSLog(@" accessToken: %@", resp.accessToken);
            NSLog(@" refreshToken: %@", resp.refreshToken);
            NSLog(@" expiration: %@", resp.expiration);
            // 第三方平台SDK原始数据
            NSLog(@" originalResponse: %@", resp.originalResponse);

            self.nickname = resp.name;
            self.headurl = resp.iconurl;
            if ([resp.unionGender isEqualToString:@"男"]) {
                self.sex = 0;
            }else if ([resp.unionGender isEqualToString:@"女"]){
                self.sex = 1;
            }else{
                self.sex = 0;
            }
            [weakSelf isExistThirdPartWithType:3 Openid:resp.openid];
        }
    }];
}

- (void)ButtonClickWeibo
{
    NSLog (@"微博登录");
    __weak typeof(self)weakSelf = self;
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"新浪微博登录失败%@",error);
        } else {
            UMSocialUserInfoResponse *resp = result;

            // 授权信息
            NSLog(@"Sina uid: %@", resp.uid);
            NSLog(@"Sina name: %@", resp.name);//昵称
            NSLog(@"Sina iconurl: %@", resp.iconurl);//头像
            NSLog(@"Sina gender: %@", resp.unionGender);//性别

            self.nickname = resp.name;
            self.headurl = resp.iconurl;
            if ([resp.unionGender isEqualToString:@"男"]) {
                self.sex = 0;
            }else if ([resp.unionGender isEqualToString:@"女"]){
                self.sex = 1;
            }else{
                self.sex = 0;
            }
            [weakSelf isExistThirdPartWithType:2 Openid:resp.uid];
        }
    }];
}

- (void)ButtonClickqq
{
    NSLog (@"qq登录按钮");
    __weak typeof(self)weakSelf = self;
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"QQ登录失败%@",error);
        } else {
            UMSocialUserInfoResponse *resp = result;

            // 授权信息
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);

            self.nickname = resp.name;
            self.headurl = resp.iconurl;
            if ([resp.unionGender isEqualToString:@"男"]) {
                self.sex = 0;
            }else if ([resp.unionGender isEqualToString:@"女"]){
                self.sex = 1;
            }else{
                self.sex = 0;
            }
            [weakSelf isExistThirdPartWithType:1 Openid:resp.openid];
        }
    }];
}

//判断第三方账号是否绑定手机号(1.QQ 2.weibo 3.wechat)
- (void)isExistThirdPartWithType:(int)type Openid:(NSString *)openid
{
    NSDictionary *params = @{@"sourcetype":@(type),@"openid":openid};
    NSString *url = HTTP_USER_ISEXIST_THIRD_URL;

    __weak typeof(self)weakSelf = self;
    [MyHUD showHUDAddTo:weakSelf.view animated:YES];
    [[ApiTool shareApiTool] get:url params:params success:^(NSDictionary * _Nullable jsonDic) {

        int code = [[jsonDic objectForKey:@"code"] intValue];
        NSString *msg = [jsonDic objectForKey:@"msg"];
        if (code == 0) {
            int isExist = [[jsonDic objectForKey:@"isExist"] intValue];
            if (isExist == 1) {//已绑定手机号
                NSString *phone = [NSString stringWithFormat:@"%@",[jsonDic objectForKey:@"phone"]];
                [weakSelf thirdpartLoginWithType:type Openid:openid Phone:phone];
            }else{//未绑定手机号
                [MyHUD hideHUDForView:weakSelf.view animated:YES];
                BindPhoneViewController *bindVc = [[BindPhoneViewController alloc]init];
                bindVc.device = _device;
                bindVc.sourcetype = [NSString stringWithFormat:@"%d",type];
                bindVc.openid = openid;
                bindVc.nickname = _nickname;
                bindVc.sex = _sex;
                bindVc.headurl = _headurl;
                [self.navigationController pushViewController:bindVc animated:YES];
            }
        }else{
            [MyHUD hideHUDForView:weakSelf.view animated:YES];
            [MyHUD showInView:weakSelf.view text:msg];
        }
    } failure:^(NSError * _Nullable error) {
        [MyHUD hideHUDForView:weakSelf.view animated:YES];
        [MyHUD showInView:weakSelf.view text:KNOINTERNET];
    }];
}

//第三方登录
- (void)thirdpartLoginWithType:(int)type Openid:(NSString *)openid Phone:(NSString *)phone
{
    NSDictionary *params = @{@"sourcetype":[NSString stringWithFormat:@"%d",type],@"openid":openid,@"phone":phone};
    NSString *url = HTTP_USER_THIRD_LOGIN_URL;
    __weak typeof(self)weakSelf = self;
    [[ApiTool shareApiTool] get:url params:params success:^(NSDictionary * _Nullable jsonDic) {
        [MyHUD hideHUDForView:weakSelf.view animated:YES];

        int code = [[jsonDic objectForKey:@"code"] intValue];
        NSString *msg = [jsonDic objectForKey:@"msg"];

        if (code == 0) {
            NSDictionary *user = [jsonDic objectForKey:@"user"];

            NSString *sign = [user objectForKey:@"sign"];
            NSString *userid = [NSString stringWithFormat:@"%@",[user objectForKey:@"userid"]];
            NSString *role = [NSString stringWithFormat:@"%@",[user objectForKey:@"userRole"]];

            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:userid forKey:KLvUserid];
            [userDefault setObject:sign forKey:KSign];
            [userDefault setObject:phone forKey:KPhone];
            [userDefault setObject:role forKey:KRole];
            [userDefault synchronize];

            //设置标签,别名
//            [[SetTagManager shareTagManager] setTagWithTagString:@"" Alias:userid];
            //根据人物不同登录不同的界面
            if ([role isEqualToString:@"1"]){
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                [userDefault setObject:@"open" forKey:KFirstOpen];
                [userDefault synchronize];
            }else if ([role isEqualToString:@"2"]){
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                [userDefault setObject:@"open" forKey:KFirstOpen];
                [userDefault synchronize];
            }else{
            }
        }else{
            [MyHUD showInView:weakSelf.view text:msg];
        }
    } failure:^(NSError * _Nullable error) {
        [MyHUD hideHUDForView:weakSelf.view animated:YES];
        [MyHUD showInView:weakSelf.view text:KNOINTERNET];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
@end

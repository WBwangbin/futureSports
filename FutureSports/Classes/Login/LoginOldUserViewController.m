//
//  LoginOldUserViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/10/2.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "LoginOldUserViewController.h"
#import "MethodToolsModel.h"
#import "NSTimer+Addition.h"
#import "ReplacePwdViewController.h"
#import "RootViewController.h"
#import "ReplacePwdViewController.h"
#import "LoginViewController.h"


@interface LoginOldUserViewController ()<UITextFieldDelegate>
//输入密码
@property (strong, nonatomic) UITextField *PwdTextField;
//登录按钮
@property (strong, nonatomic) UIButton *LoginBtn;
//眼睛按钮
@property (strong, nonatomic) UIButton *eyeBtn;

@end

@implementation LoginOldUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进入到老用户-登录页");
    self.view.backgroundColor = [UIColor whiteColor];
    //设置电池栏字体颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    //隐藏navigationBar
    self.navigationController.navigationBar.hidden = YES;

    //左按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setImage:[UIImage imageNamed:@"homeindicator.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftNavBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).with.offset(7);
        make.centerY.equalTo(self.view.top).with.offset(35);
        make.size.equalTo(CGSizeMake(47, 23));
    }];

    [self creatUI];
    [self dismissKeyboard];
}
-(void)leftNavBtnClick
{
    LoginViewController *loginVc = [[LoginViewController alloc]init];
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    window.rootViewController = [[UINavigationController alloc]initWithRootViewController:loginVc ];
}
-(void)creatUI
{
    //头像
    UIImageView *userIconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_server"]];
    [self.view addSubview:userIconView];
    [userIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.top).with.offset(100);
        make.size.equalTo(CGSizeMake(105,105));
    }];

    UILabel *usernameLabel = [[UILabel alloc]init];
    [usernameLabel setText:@"user name"];
    [usernameLabel setFont:[UIFont systemFontOfSize:20]];
    [usernameLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:usernameLabel];
    [usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userIconView.bottom).with.offset(10);
        make.centerX.equalTo(self.view.centerX);
    }];

    UILabel *welcomeLabel = [[UILabel alloc]init];
    [welcomeLabel setText:@"欢迎回来"];
    [welcomeLabel setFont:[UIFont systemFontOfSize:30]];
    [welcomeLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:welcomeLabel];
    [welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(usernameLabel.bottom).with.offset(0);
        make.centerX.equalTo(self.view.centerX);
    }];

    UILabel *numLabel = [[UILabel alloc]init];
    [numLabel setText:@"手机号:  86+1777815****"];
    [numLabel setFont:[UIFont systemFontOfSize:20]];
    [numLabel setTextColor:[UIColor blackColor]];
    numLabel.textAlignment =  NSTextAlignmentLeft;
    [self.view addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(welcomeLabel.bottom).with.offset(30);
        make.left.equalTo(self.view.left).with.offset(50);
        make.right.equalTo(self.view.right).with.offset(-50);
    }];

    UILabel *PwdLabel = [[UILabel alloc]init];
    [PwdLabel setText:@"密    码:  "];
    [PwdLabel setFont:[UIFont systemFontOfSize:20]];
    [PwdLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:PwdLabel];
    [PwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numLabel.bottom).with.offset(20);
        make.left.equalTo(self.view.left).with.offset(50);
    }];

    _PwdTextField =[[UITextField alloc]init];
    _PwdTextField.placeholder = @"请输入密码";
    [self.view addSubview:_PwdTextField];
    [_PwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(PwdLabel);
        make.left.equalTo(PwdLabel.right);
        make.right.equalTo(numLabel.right);
    }];

    //黑线
    UIView *bottomPwdLine = [[UIView alloc]init];
    bottomPwdLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bottomPwdLine];
    [bottomPwdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.top.equalTo(_PwdTextField.bottom).with.offset(1);
        make.left.equalTo(_PwdTextField.left);
        make.right.equalTo(_PwdTextField.right);
    }];

    //眼睛按钮
    _eyeBtn = [[UIButton alloc] init];
    [_eyeBtn setImage:[UIImage imageNamed:@"login_eye_pre"]
             forState:UIControlStateNormal];
    [_eyeBtn addTarget:self
                action:@selector (eyeBtnClick:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_eyeBtn];
    [_eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_PwdTextField.right);
        make.centerY.equalTo(_PwdTextField.centerY);
    }];

    //忘记密码
    UIButton *forgetBtn = [[HyperlinksButton alloc]initWithTitle:@"忘记密码?" Font:12 LineColor:[UIColor blackColor] TitleColor:[UIColor blackColor]];
    [forgetBtn addTarget:self
                  action:@selector (forgetBtnClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(PwdLabel.left);
        make.top.equalTo(PwdLabel.bottom).with.offset(10);
    }];

    _LoginBtn =  [WBViewTool  initWithRegisterButton:@"登录"];
    [_LoginBtn addTarget:self
                  action:@selector (loginBtnClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [_LoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_LoginBtn];
    [_LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.bottom.equalTo (self.view.bottom).with.offset (-100);
        make.height.mas_equalTo (45);
        make.left.mas_equalTo (self.view.left).with.offset(50);
        make.right.mas_equalTo (self.view.right).with.offset(-50);
    }];

    self.PwdTextField.secureTextEntry = YES;
    self.PwdTextField.delegate = self;
    self.PwdTextField.returnKeyType = UIReturnKeyDone;
    [self.PwdTextField addTarget:self action:@selector(TextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)forgetBtnClick:(UIButton *)sender
{
    ReplacePwdViewController *replacePwdVc = [[ReplacePwdViewController alloc]init];
    __weak typeof(self)weakSelf = self;
    replacePwdVc.successPwd = ^{
        [MyHUD showInView:weakSelf.view text:@"重置密码成功,请登录"];
    };
    [self.navigationController pushViewController:replacePwdVc animated:YES];
}
- (void)eyeBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if ([sender isSelected]) {
        [_eyeBtn setImage:[UIImage imageNamed:@"login_eye"]
                 forState:UIControlStateNormal];
        _PwdTextField.secureTextEntry = NO;
    }else{
        [_eyeBtn setImage:[UIImage imageNamed:@"login_eye_pre"]
                 forState:UIControlStateNormal];
        _PwdTextField.secureTextEntry = YES;
    }
}

- (void)TextFieldDidChange:(UITextField *)textField
{
    UITextRange *selectedRange = textField.markedTextRange;
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position) {
        self.PwdTextField.text = [MethodToolsModel disable_letterNumber:textField.text];
        if (self.PwdTextField.text.length > 18) {
            self.PwdTextField.text = [self.PwdTextField.text substringToIndex:18];
            [self dismissKeyboard];
        }
    }
    [self updateBtnColor];
}
#pragma mark - 按钮点击
- (void)loginBtnClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (![self judgeInput]) {
        return;
    }
    NSLog(@"登录成功,跳转到根首页");
    RootViewController * rootViewController = [[RootViewController alloc]init];
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    window.rootViewController = [[UINavigationController alloc]initWithRootViewController:rootViewController ];
}

- (BOOL)judgeInput
{
    if (self.PwdTextField.text.length == 0) {
        [MyHUD showInView:self.view text:@"请输入密码"]; return NO;
    }
    if (self.PwdTextField.text.length < 6) {
        [MyHUD showInView:self.view text:@"请输入正确的密码"];
        return NO;
    }
    return YES;
}

- (void)updateBtnColor
{
    if (self.PwdTextField.text.length > 0) {
        [_LoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [_LoginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

#pragma mark - textFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self updateBtnColor];
}

- (void)dismissKeyboard
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

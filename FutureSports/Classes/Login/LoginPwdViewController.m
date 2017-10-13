//
//  LoginPwdViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/9/27.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "LoginPwdViewController.h"
#import "MethodToolsModel.h"
#import "SetTagManager.h"
#import "ReplacePwdViewController.h"
#import "LoginVerifyViewController.h"

@interface LoginPwdViewController ()<UITextFieldDelegate>
@property (nonatomic, assign) NSInteger i;
@end

@implementation LoginPwdViewController
{
    UITextField *PhoneTextField;
    UITextField *PwdTextField;
    UIButton *LoginBtn;
    UIButton *eyepreButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进入到密码登录页");
    [self creatUI];
    [self dismissKeyboard];
}
-(void)creatUI
{
    UILabel *loginPwdLabel = [[UILabel alloc]init];
    [loginPwdLabel setText:@"密码登录"];
    [loginPwdLabel setFont:[UIFont systemFontOfSize:22]];
    [loginPwdLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:loginPwdLabel];
    [loginPwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).with.offset(100);
        make.right.equalTo(self.view.centerX).with.offset(-20);
    }];

    //竖线
    UIView *verticalLine = [[UIView alloc]init];
    verticalLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:verticalLine];
    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(2);
        make.height.equalTo(loginPwdLabel);
        make.left.equalTo(loginPwdLabel.right).with.offset(10);
        make.top.equalTo(loginPwdLabel);
    }];

    UIButton *sendMessageLoginButton = [[UIButton alloc]init];
    [sendMessageLoginButton setTitle:@"验证码登录" forState:UIControlStateNormal];
    [sendMessageLoginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [sendMessageLoginButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    sendMessageLoginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    sendMessageLoginButton.titleLabel.font = [UIFont systemFontOfSize:22];
    [sendMessageLoginButton addTarget:self action:@selector(verifyClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendMessageLoginButton];
    [sendMessageLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(verticalLine.centerY);
        make.left.equalTo(verticalLine.right).with.offset(10);
    }];

    UILabel *phoneNumbLabel = [[UILabel alloc]init];
    [phoneNumbLabel setText:@"手机号"];
    [phoneNumbLabel setFont:[UIFont systemFontOfSize:16]];
    [phoneNumbLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:phoneNumbLabel];
    [phoneNumbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginPwdLabel.bottom).with.offset(30);
        make.left.equalTo(self.view.left).with.offset(40);
    }];

    PhoneTextField =[[UITextField alloc]init];
    PhoneTextField.placeholder = @"请输入手机号";
    [self.view addSubview:PhoneTextField];
    [PhoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneNumbLabel.bottom).with.offset(10);
        make.left.equalTo(phoneNumbLabel.left);
        make.right.equalTo(self.view.right).with.offset(-40);
    }];

    //黑线
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.top.equalTo(PhoneTextField.bottom).with.offset(10);
        make.left.equalTo(phoneNumbLabel.left);
        make.right.equalTo(self.view.right).with.offset(-40);
    }];

    UILabel *passwordLabel = [[UILabel alloc]init];
    [passwordLabel setText:@"密码"];
    [passwordLabel setFont:[UIFont systemFontOfSize:16]];
    [passwordLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:passwordLabel];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomLine.bottom).with.offset(30);
        make.left.equalTo(phoneNumbLabel.left);
    }];

    PwdTextField =[[UITextField alloc]init];
    PwdTextField.placeholder = @"请输入密码";
    [self.view addSubview:PwdTextField];
    [PwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordLabel.bottom).with.offset(10);
        make.left.equalTo(phoneNumbLabel.left);
        make.right.equalTo(self.view.right).with.offset(-40);
    }];

    //黑线
    UIView *bottomPwdLine = [[UIView alloc]init];
    bottomPwdLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bottomPwdLine];
    [bottomPwdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.top.equalTo(PwdTextField.bottom).with.offset(10);
        make.left.equalTo(phoneNumbLabel.left);
        make.right.equalTo(self.view.right).with.offset(-40);
    }];

    PhoneTextField.textColor = [UIColor blackColor];
    PhoneTextField.delegate = self;
    PhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [PhoneTextField addTarget:self action:@selector(PhoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    PwdTextField.textColor = [UIColor blackColor];
    PwdTextField.secureTextEntry = YES;
    PwdTextField.delegate = self;
    PwdTextField.returnKeyType = UIReturnKeyDone;
    [PwdTextField addTarget:self action:@selector(TextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    //眼睛按钮
    eyepreButton = [[UIButton alloc] init];
    [eyepreButton setImage:[UIImage imageNamed:@"login_eye_pre"]
                  forState:UIControlStateNormal];
    [eyepreButton addTarget:self
                     action:@selector (eyepreButtonClick:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eyepreButton];
    [eyepreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(PwdTextField.right);
        make.centerY.equalTo(PwdTextField.centerY);
    }];

    //忘记密码
    UIButton *forgetBtn = [[HyperlinksButton alloc]initWithTitle:@"忘记密码?" Font:12 LineColor:[UIColor blackColor] TitleColor:[UIColor blackColor]];
    [forgetBtn addTarget:self
                  action:@selector (forgetBtnClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomPwdLine.left);
        make.top.equalTo(bottomPwdLine.bottom).with.offset(10);
    }];

    LoginBtn =  [WBViewTool  initWithRegisterButton:@"登录"];
    [LoginBtn addTarget:self
                 action:@selector (loginBtnClick:)
       forControlEvents:UIControlEventTouchUpInside];
    [LoginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:LoginBtn];
    [LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.bottom.equalTo (self.view.bottom).with.offset (-100);
        make.height.mas_equalTo (45);
        make.left.mas_equalTo (self.view.left).with.offset(50);
        make.right.mas_equalTo (self.view.right).with.offset(-50);
    }];

}

- (void)verifyClick:(UIButton *)sender
{
    LoginVerifyViewController * loginVerifyViewController = [[LoginVerifyViewController alloc]init];
    [self.navigationController pushViewController:loginVerifyViewController animated:YES];
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
#pragma mark - 点击事件
-(void)eyepreButtonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if ([sender isSelected]) {
        [eyepreButton setImage:[UIImage imageNamed:@"login_eye"]
                      forState:UIControlStateNormal];
        PwdTextField.secureTextEntry = NO;
    }else{
        [eyepreButton setImage:[UIImage imageNamed:@"login_eye_pre"]
                      forState:UIControlStateNormal];
        PwdTextField.secureTextEntry = YES;
    }
}



//登录按钮点击事件
- (void)loginBtnClick:(UIButton *)sender
{
    //退出键盘
    [self.view endEditing:YES];
    //判断没有输入就确认的情况
    if (![self judgeInput]) {
        return;
    }
    //字符串切割
    NSArray *textArr = [PhoneTextField.text componentsSeparatedByString:@" "];
    //取出第一个元素
    NSMutableString *text = [NSMutableString stringWithString:[textArr firstObject]];

    [textArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            //在字符串末尾追加字符串
            [text appendString:obj];
        }
    }];

    //准备
    NSDictionary *params = @{@"user":text,@"passwd":PwdTextField.text,@"timeidentify":@(1),@"uol":@"1"};
    NSString *url = HTTP_USER_LOGIN_URL;

    [MyHUD showHUDAddTo:self.view animated:YES];

    //get请求
    __weak typeof(self)weakSelf = self;
    [[ApiTool shareApiTool] get:url params:params success:^(NSDictionary *jsonDic) {

        int code = [[jsonDic objectForKey:@"code"] intValue];
        NSString *msg = [jsonDic objectForKey:@"msg"];
        if (code == 0) {
            NSDictionary *user = [jsonDic objectForKey:@"user"];
            NSString *sign = [user objectForKey:@"sign"];
            NSString *userid = [NSString stringWithFormat:@"%@",[user objectForKey:@"userid"]];

            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:userid forKey:KLvUserid];
            [userDefault setObject:sign forKey:KSign];
            [userDefault synchronize];

            //设置标签,别名
            [[SetTagManager shareTagManager] setTagWithTagString:@"" Alias:userid];
            //查询个人信息
            [self RequestUserInfoWithSign:sign userid:userid];
        }else{
            [MyHUD hideHUDForView:weakSelf.view animated:YES];
            [MyHUD showInView:weakSelf.view text:msg];
            //登录失败做处理
            [self.navigationController popViewControllerAnimated:YES];
        }

    } failure:^(NSError *error) {
        [MyHUD hideHUDForView:weakSelf.view animated:YES];
        [MyHUD showInView:weakSelf.view text:KNOINTERNET];
        //登录失败做处理
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

//查询个人信息
- (void)RequestUserInfoWithSign:(NSString *)sign userid:(NSString *)userid
{
    //准备
    NSDictionary *params = @{@"userid":userid,@"lvuserid":userid,@"sign":sign,@"t":@"1"};
    NSString *url = HTTP_USER_GET_INFO_URL;

    __weak typeof(self)weakSelf = self;

    //post请求
    // 判断身份,密码,决定跳转界面
    [[ApiTool shareApiTool] post:url params:params success:^(NSDictionary *jsonDic) {
        [MyHUD hideHUDForView:weakSelf.view animated:YES];
        int code = [[jsonDic objectForKey:@"code"] intValue];
        NSString *msg = [jsonDic objectForKey:@"msg"];
        if (code == 0) {
            NSDictionary *extinfo = [jsonDic objectForKey:@"extinfo"];
            NSDictionary *baseinfo = [jsonDic objectForKey:@"baseinfo"];
            NSString *role = [NSString stringWithFormat:@"%@",[extinfo objectForKey:@"role"]];
            NSString *phone = [NSString stringWithFormat:@"%@",[baseinfo objectForKey:@"phone"]];

            NSUserDefaults *defaulf = [NSUserDefaults standardUserDefaults];
            [defaulf setObject:role forKey:KRole];
            [defaulf setObject:phone forKey:KPhone];
            [defaulf synchronize];

            //跳转界面
            if ([role isEqualToString:@"1"]){
                NSLog(@"1111111111111");
                [self.navigationController popViewControllerAnimated:YES];
            }else if ([role isEqualToString:@"2"]){
                NSLog(@"2222222222222222");
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                NSLog(@"3333333333333");
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else{
            [MyHUD showInView:weakSelf.view text:msg];
            NSLog(@"444444444%@",msg);
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        [MyHUD hideHUDForView:weakSelf.view animated:YES];
        [MyHUD showInView:weakSelf.view text:KNOINTERNET];
        NSLog(@"555555555555%@",KNOINTERNET);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

//判断没有输入的情况
- (BOOL)judgeInput
{
    if (PhoneTextField.text.length == 0) {
        [MyHUD showInView:self.view text:@"请输入手机号"]; return NO;
    }
    if (PwdTextField.text.length == 0) {
        [MyHUD showInView:self.view text:@"请输入密码"]; return NO;
    }
    return YES;
}

#pragma mark - textFieldDelegate
//结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self updateBtnCorlor];
}
//点击enter,输入法就是消失.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//账号发生改变
- (void)PhoneTextFieldDidChange:(UITextField *)textField
{
    if (textField == PhoneTextField) {
        if (textField.text.length > _i) {
            if (textField.text.length == 4 || textField.text.length == 9 ) {//输入
                NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
                [str insertString:@" " atIndex:(textField.text.length-1)];
                textField.text = str;
            }
            if (textField.text.length >= 13 ) {//输入完成
                textField.text = [textField.text substringToIndex:13];
                [textField resignFirstResponder];
                [PwdTextField becomeFirstResponder];
            }
            _i = textField.text.length;

        }else if (textField.text.length < _i){//删除
            if (textField.text.length == 4 || textField.text.length == 9) {
                textField.text = [NSString stringWithFormat:@"%@",textField.text];
                textField.text = [textField.text substringToIndex:(textField.text.length-1)];
            }
            _i = textField.text.length;
        }
    }
}

//密码发生改变
- (void)TextFieldDidChange:(UITextField *)textField
{
    UITextRange *selectedRange = textField.markedTextRange;
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position) {
        PwdTextField.text = [MethodToolsModel disable_letterNumber:textField.text];
        if (PwdTextField.text.length > 18) {
            PwdTextField.text = [PwdTextField.text substringToIndex:18];
            [self dismissKeyboard];
        }
    }
    [self updateBtnCorlor];
}

//退出键盘的手势
- (void)dismissKeyboard
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self.view endEditing:YES];
}
//更新按钮状态
- (void)updateBtnCorlor
{
    if (PhoneTextField.text.length > 0 && PwdTextField.text.length > 0) {
        [LoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [LoginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

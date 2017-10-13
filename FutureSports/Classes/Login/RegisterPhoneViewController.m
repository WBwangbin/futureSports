//
//  RegisterPhoneViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/9/29.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "RegisterPhoneViewController.h"
#import "MethodToolsModel.h"
#import "NSTimer+Addition.h"
#import "RegisterSuccessViewController.h"

@interface RegisterPhoneViewController ()<UITextFieldDelegate>

//手机号
@property (strong, nonatomic) UITextField *PhoneTextField;
//输入验证码
@property (strong, nonatomic) UITextField *VerifyTextField;
//输入密码
@property (strong, nonatomic) UITextField *PwdTextField;
//登录按钮
@property (strong, nonatomic) UIButton *LoginBtn;
//获取验证按钮
@property (nonatomic, strong) UIButton *VerifyBtn;
//计时器
@property (nonatomic, strong) NSTimer *VerifyTime;

@property (assign, nonatomic) int timeNum;

@property (nonatomic, assign) NSInteger i;
//眼睛按钮
@property (strong, nonatomic) UIButton *eyeBtn;

@end

@implementation RegisterPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进入到注册-手机号注册");
    [self creatUI];
    [self dismissKeyboard];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_VerifyTime) {
        [_VerifyTime invalidate];
    }
}

-(void)creatUI
{
    UILabel *forgetPwdLabel = [[UILabel alloc]init];
    [forgetPwdLabel setText:@"手机号注册"];
    [forgetPwdLabel setFont:[UIFont systemFontOfSize:26]];
    [forgetPwdLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:forgetPwdLabel];
    [forgetPwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).with.offset(100);
        make.left.equalTo(self.view.left).with.offset(40);
    }];

    _PhoneTextField =[[UITextField alloc]init];
    _PhoneTextField.placeholder = @"请输入手机号";
    [self.view addSubview:_PhoneTextField];
    [_PhoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(forgetPwdLabel.bottom).with.offset(40);
        make.left.equalTo(self.view.left).with.offset(40);
        make.right.equalTo(self.view.right).with.offset(-40);
    }];

    //黑线
    UIView *bottomPhoneLine = [[UIView alloc]init];
    bottomPhoneLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bottomPhoneLine];
    [bottomPhoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.top.equalTo(_PhoneTextField.bottom).with.offset(10);
        make.left.equalTo(self.view.left).with.offset(40);
        make.right.equalTo(self.view.right).with.offset(-40);
    }];


    _VerifyTextField =[[UITextField alloc]init];
    _VerifyTextField.placeholder = @"请输入验证码";
    [self.view addSubview:_VerifyTextField];
    [_VerifyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_PhoneTextField.bottom).with.offset(40);
        make.left.equalTo(self.view.left).with.offset(40);
        make.right.equalTo(self.view.right).with.offset(-40);
    }];

    //黑线
    UIView *bottomVerifyLine = [[UIView alloc]init];
    bottomVerifyLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bottomVerifyLine];
    [bottomVerifyLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.top.equalTo(_VerifyTextField.bottom).with.offset(10);
        make.left.equalTo(self.view.left).with.offset(40);
        make.right.equalTo(self.view.right).with.offset(-40);
    }];

    _PwdTextField =[[UITextField alloc]init];
    _PwdTextField.placeholder = @"请输入密码(至少6位数)";
    [self.view addSubview:_PwdTextField];
    [_PwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_VerifyTextField.bottom).with.offset(40);
        make.left.equalTo(self.view.left).with.offset(40);
        make.right.equalTo(self.view.right).with.offset(-40);
    }];

    //黑线
    UIView *bottomPwdLine = [[UIView alloc]init];
    bottomPwdLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bottomPwdLine];
    [bottomPwdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.top.equalTo(_PwdTextField.bottom).with.offset(10);
        make.left.equalTo(self.view.left).with.offset(40);
        make.right.equalTo(self.view.right).with.offset(-40);
    }];

    //获取验证码按钮
    _VerifyBtn =  [[UIButton alloc]init];
    [_VerifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _VerifyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_VerifyBtn setTitleColor:RGBCOLOR(10, 157, 255) forState:UIControlStateNormal];
    [_VerifyBtn setTitleColor:RGBCOLOR(132, 206, 255) forState:UIControlStateSelected];
    _VerifyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_VerifyBtn addTarget:self action:@selector(VerifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_VerifyBtn];
    [_VerifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo (_VerifyTextField.centerY);
        make.right.equalTo (_PhoneTextField.right);
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


    _LoginBtn =  [WBViewTool  initWithRegisterButton:@"下一步"];
    [_LoginBtn addTarget:self
                  action:@selector (registerBtnClick:)
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
    self.PhoneTextField.delegate = self;
    self.VerifyTextField.delegate = self;
    self.PwdTextField.delegate = self;
    self.PhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.VerifyTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.PwdTextField.returnKeyType = UIReturnKeyDone;

    [self.PhoneTextField addTarget:self action:@selector(PhoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.VerifyTextField addTarget:self action:@selector(VerifyTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.PwdTextField addTarget:self action:@selector(TextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

//    UIButton *button = [[HyperlinksButton alloc]initWithTitle:[NSString stringWithFormat:@"联系客服"] Font:10 LineColor:[UIColor blackColor] TitleColor:[UIColor blackColor]];
//    [button addTarget:self action:@selector(PhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view.bottom);
//        make.centerX.equalTo(self.view.centerX);
//    }];

}

- (void)PhoneTextFieldDidChange:(UITextField *)textField
{
    if (textField == _PhoneTextField) {
        if (textField.text.length > _i) {
            if (textField.text.length == 4 || textField.text.length == 9 ) {//输入
                NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
                [str insertString:@" " atIndex:(textField.text.length-1)];
                textField.text = str;
            }
            if (textField.text.length >= 13 ) {//输入完成
                textField.text = [textField.text substringToIndex:13];
                [textField resignFirstResponder];
                [_VerifyTextField becomeFirstResponder];
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

- (void)VerifyTextFieldDidChange:(UITextField *)textField
{
    UITextRange *selectedRange = textField.markedTextRange;
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position) {
        self.VerifyTextField.text = [MethodToolsModel disable_letterNumber:textField.text];
        if (self.VerifyTextField.text.length >= 6) {
            self.VerifyTextField.text = [self.VerifyTextField.text substringToIndex:6];
            [textField resignFirstResponder];
            [_PwdTextField becomeFirstResponder];

        }
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

#pragma mark - 计时器计时
- (void)verifyTimeBegin
{
    if (self.VerifyTime){
        //如果计时器存在，就从新开始计时
        [_VerifyTime resumeTimerAfterTimeInterval:1];
    }else{
        self.VerifyTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self
                                                         selector:@selector(timeAfter) userInfo:nil
                                                          repeats:YES];
    }
}

//每1s刷新一次
- (void)timeAfter
{
    self.timeNum--;
    [_VerifyBtn setTitle:[NSString stringWithFormat:@"%ds后重新获取", self.timeNum] forState:UIControlStateSelected];
    if (self.timeNum == 0)
    {
        _VerifyBtn.selected = NO;
        _VerifyBtn.userInteractionEnabled = YES;
        [_VerifyTime pauseTimer];
    }
}

#pragma mark - 按钮点击

//获取验证码
- (void)VerifyBtnClick
{
    [self.view endEditing:YES];
    if (![self judgePhone]) {
        return;
    }
    NSArray *textArr = [self.PhoneTextField.text componentsSeparatedByString:@" "];
    NSMutableString *text = [NSMutableString stringWithString:[textArr firstObject]];
    [textArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            [text appendString:obj];
        }
    }];

    [MyHUD showHUDAddTo:self.view animated:YES];

    NSDictionary *params = @{@"phone":text};

    NSString *url = HTTP_USER_GET_PHONE_CODE_URL;

    [[ApiTool shareApiTool] get:url params:params success:^(NSDictionary *jsonDic) {

        [MyHUD hideHUDForView:self.view animated:YES];
        int code = [[jsonDic objectForKey:@"code"] intValue];
        NSString *msg = [jsonDic objectForKey:@"msg"];
        if (code == 0) {
            _VerifyBtn.selected = YES;
            _VerifyBtn.userInteractionEnabled = NO;
            _timeNum = 60;
            [_VerifyBtn setTitle:[NSString stringWithFormat:@"%ds后重新获取", _timeNum] forState:UIControlStateSelected];
            //计时器开始计时
            [self verifyTimeBegin];

            [MyHUD showInView:self.view text:msg];
        }else{
            [MyHUD showInView:self.view text:msg];
        }
    } failure:^(NSError *error) {
        [MyHUD hideHUDForView:self.view animated:YES];
        [MyHUD showInView:self.view text:KNOINTERNET];
    }];

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
- (void)registerBtnClick:(UIButton *)sender
{
    //注册成功后做处理
    RegisterSuccessViewController * registerSuccessViewController = [[RegisterSuccessViewController alloc]init];
    [self.navigationController pushViewController:registerSuccessViewController animated:YES];
    
    [self.view endEditing:YES];
    if (![self judgeInput]) {
        return;
    }
    NSArray *textArr = [self.PhoneTextField.text componentsSeparatedByString:@" "];
    NSMutableString *text = [NSMutableString stringWithString:[textArr firstObject]];
    [textArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            [text appendString:obj];
        }
    }];

    [MyHUD showHUDAddTo:self.view animated:YES];

    NSDictionary *params = @{@"phone":text,@"password":self.PwdTextField.text,@"code":self.VerifyTextField.text};

    NSString *url = HTTP_USER_USERREG_URL;

    [[ApiTool shareApiTool] get:url params:params success:^(NSDictionary *jsonDic) {
        [MyHUD hideHUDForView:self.view animated:YES];
        int code = [[jsonDic objectForKey:@"code"] intValue];
        NSString *msg = [jsonDic objectForKey:@"msg"];
        if (code == 0) {
            if (self.successPwd) {
                self.successPwd();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MyHUD showInView:self.view text:msg];
        }
    } failure:^(NSError *error) {
        [MyHUD hideHUDForView:self.view animated:YES];
        [MyHUD showInView:self.view text:KNOINTERNET];
    }];

}

- (BOOL)judgePhone
{
    if (self.PhoneTextField.text.length == 0) {
        [MyHUD showInView:self.view text:@"请输入手机号"];
        return NO;
    }
    return YES;
}

- (BOOL)judgeInput
{
    if (self.PhoneTextField.text.length == 0) {
        [MyHUD showInView:self.view text:@"请输入手机号"]; return NO;
    }
    if (self.VerifyTextField.text.length == 0) {
        [MyHUD showInView:self.view text:@"请输入验证码"]; return NO;
    }
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
    if (self.PhoneTextField.text.length > 0 && self.VerifyTextField.text.length > 0 && self.PwdTextField.text.length > 0) {
        [_LoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [_LoginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

- (void)PhoneBtn:(UIButton *)sender
{
    [self callPhoneStr:myPhone withVC:self];
}

- (void)callPhoneStr:(NSString*)phoneStr withVC:(UIViewController *)selfvc
{
    NSLog(@"点击了呼叫按钮");
    NSString* PhoneStr = [NSString stringWithFormat:@"tel://%@",phoneStr];
    if ([PhoneStr hasPrefix:@"sms:"] || [PhoneStr hasPrefix:@"tel:"]) {
        UIApplication * app = [UIApplication sharedApplication];
        if ([app canOpenURL:[NSURL URLWithString:PhoneStr]]) {
            [app openURL:[NSURL URLWithString:PhoneStr] options:@{} completionHandler:nil];
        }
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

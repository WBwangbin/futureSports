//
//  BindPhoneViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/10/10.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "BindPhoneViewController.h"
#import "NSTimer+Addition.h"
#import "SetTagManager.h"

@interface BindPhoneViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NSTimer *VerifyTime;
@property (assign, nonatomic) int timeNum;
@property (nonatomic, assign) NSInteger i;
@end

@implementation BindPhoneViewController
{
    UITextField *PhoneTextField;
    UITextField *VerifyTextField;
    UIButton *VerifyBtn;
    UIButton *LoginBtn;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_VerifyTime) {
        [_VerifyTime invalidate];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatUI];
    [self dismissKeyboard];
}
-(void)creatUI
{

    UILabel *bindPhoneNumbLabel = [[UILabel alloc]init];
    [bindPhoneNumbLabel setText:@"绑定手机号"];
    [bindPhoneNumbLabel setFont:[UIFont systemFontOfSize:26]];
    [bindPhoneNumbLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:bindPhoneNumbLabel];
    [bindPhoneNumbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).with.offset(100);
        make.left.equalTo(self.view.left).with.offset(40);
    }];

    PhoneTextField =[[UITextField alloc]init];
    PhoneTextField.placeholder = @"请输入手机号";
    [self.view addSubview:PhoneTextField];
    [PhoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bindPhoneNumbLabel.bottom).with.offset(40);
        make.left.equalTo(self.view.left).with.offset(40);
        make.right.equalTo(self.view.right).with.offset(-40);
    }];

    //黑线
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.top.equalTo(PhoneTextField.bottom).with.offset(10);
        make.left.equalTo(self.view.left).with.offset(40);
        make.right.equalTo(self.view.right).with.offset(-40);
    }];

    VerifyTextField =[[UITextField alloc]init];
    VerifyTextField .placeholder = @"请输入验证码";
    [self.view addSubview:VerifyTextField ];
    [VerifyTextField  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PhoneTextField.bottom).with.offset(40);
        make.left.equalTo(self.view.left).with.offset(40);
        make.right.equalTo(self.view.right).with.offset(-40);
    }];

    //黑线
    UIView *bottomPwdLine = [[UIView alloc]init];
    bottomPwdLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bottomPwdLine];
    [bottomPwdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.top.equalTo(VerifyTextField.bottom).with.offset(10);
        make.left.equalTo(self.view.left).with.offset(40);
        make.right.equalTo(self.view.right).with.offset(-40);
    }];

    PhoneTextField.textColor = [UIColor blackColor];
    PhoneTextField.delegate = self;
    PhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [PhoneTextField addTarget:self action:@selector(PhoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    VerifyTextField.textColor = [UIColor blackColor];
    VerifyTextField.keyboardType = UIKeyboardTypeNumberPad;
    VerifyTextField.delegate = self;
    VerifyTextField.returnKeyType = UIReturnKeyDone;
    [VerifyTextField addTarget:self action:@selector(TextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];


    //获取验证码按钮
    VerifyBtn =  [[UIButton alloc]init];
    [VerifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    VerifyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [VerifyBtn setTitleColor:RGBCOLOR(10, 157, 255) forState:UIControlStateNormal];
    [VerifyBtn setTitleColor:RGBCOLOR(132, 206, 255) forState:UIControlStateSelected];
    VerifyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [VerifyBtn addTarget:self action:@selector(VerifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:VerifyBtn];
    [VerifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(VerifyTextField.right);
        make.centerY.equalTo(VerifyTextField.centerY);
    }];

    //绑定
    LoginBtn =  [WBViewTool  initWithRegisterButton:@"绑定"];
    [LoginBtn addTarget:self
                 action:@selector (BindBtn:)
       forControlEvents:UIControlEventTouchUpInside];
    [LoginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:LoginBtn];
    [LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.bottom.equalTo (self.view.bottom).with.offset (-150);
        make.height.mas_equalTo (45);
        make.left.mas_equalTo (self.view.left).with.offset(50);
        make.right.mas_equalTo (self.view.right).with.offset(-50);
    }];
}


#pragma mark - 点击事件
//获取验证码
- (void)VerifyBtnClick
{
    [self.view endEditing:YES];
    if (![self judgePhone]) {
        return;
    }
    NSArray *textArr = [PhoneTextField.text componentsSeparatedByString:@" "];
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
            VerifyBtn.selected = YES;
            VerifyBtn.userInteractionEnabled = NO;
            _timeNum = 60;
            [VerifyBtn setTitle:[NSString stringWithFormat:@"%ds后重新获取", _timeNum] forState:UIControlStateSelected];
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

//绑定按钮点击事件
- (void)BindBtn:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (![self judgeInput]) {
        return;
    }
    NSArray *textArr = [PhoneTextField.text componentsSeparatedByString:@" "];
    NSMutableString *text = [NSMutableString stringWithString:[textArr firstObject]];
    [textArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            [text appendString:obj];
        }
    }];

    NSDictionary *params = @{@"phone":text};
    NSString *url = HTTP_USER_THIRD_LOGIN_URL;
    [MyHUD showHUDAddTo:self.view animated:YES];

    __weak typeof(self)weakSelf = self;
    [[ApiTool shareApiTool] get:url params:params success:^(NSDictionary * _Nullable jsonDic) {
        [MyHUD hideHUDForView:weakSelf.view animated:YES];

        int code = [[jsonDic objectForKey:@"code"] intValue];
        NSString *msg = [jsonDic objectForKey:@"msg"];
        if (code == 0) {

            NSDictionary *user = [jsonDic objectForKey:@"user"];

            NSString *sign = [user objectForKey:@"sign"];
            NSString *userid = [NSString stringWithFormat:@"%@",[user objectForKey:@"userid"]];
            NSString *phone = [user objectForKey:@"phone"];
            NSString *role = [NSString stringWithFormat:@"%@",[user objectForKey:@"userRole"]];

            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:userid forKey:KLvUserid];
            [userDefault setObject:sign forKey:KSign];
            [userDefault setObject:phone forKey:KPhone];
            [userDefault setObject:role forKey:KRole];
            [userDefault synchronize];

            //设置标签,别名
            [[SetTagManager shareTagManager] setTagWithTagString:@"" Alias:userid];

            if ([role isEqualToString:@"1"]){
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                [userDefault setObject:@"open" forKey:KFirstOpen];
                [userDefault synchronize];
                //做处理
                [self.navigationController popViewControllerAnimated:YES];
            }else if ([role isEqualToString:@"2"]){
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                [userDefault setObject:@"open" forKey:KFirstOpen];
                [userDefault synchronize];
                //做处理
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else{
            //做处理
            [self.navigationController popViewControllerAnimated:YES];
            [MyHUD showInView:weakSelf.view text:msg];
        }
    } failure:^(NSError * _Nullable error) {
        //做处理
        [self.navigationController popViewControllerAnimated:YES];
        [MyHUD hideHUDForView:weakSelf.view animated:YES];
        [MyHUD showInView:weakSelf.view text:KNOINTERNET];
    }];
}
//判断没有输入的情况
- (BOOL)judgePhone
{
    if (PhoneTextField.text.length == 0) {
        [MyHUD showInView:self.view text:@"请输入手机号"]; return NO;
    }
    return YES;
}
//判断没有输入的情况
- (BOOL)judgeInput
{
    if (PhoneTextField.text.length == 0) {
        [MyHUD showInView:self.view text:@"请输入手机号"]; return NO;
    }
    if (VerifyTextField.text.length == 0) {
        [MyHUD showInView:self.view text:@"请输入验证码"]; return NO;
    }
    return YES;
}
//更新按钮状态
- (void)updateBtnCorlor
{
    if (PhoneTextField.text.length > 0 && VerifyTextField.text.length > 0) {
        [LoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [LoginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
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

//手机号发生改变
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
//验证码发生改变
- (void)TextFieldDidChange:(UITextField *)textField
{
    UITextRange *selectedRange = textField.markedTextRange;
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position) {
        
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
            [self dismissKeyboard];
        }
    }
    [self updateBtnCorlor];
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
    [VerifyBtn setTitle:[NSString stringWithFormat:@"%ds后重新获取", self.timeNum] forState:UIControlStateSelected];
    if (self.timeNum == 0)
    {
        VerifyBtn.selected = NO;
        VerifyBtn.userInteractionEnabled = YES;
        [_VerifyTime pauseTimer];
    }
}

//退出键盘的手势
- (void)dismissKeyboard
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

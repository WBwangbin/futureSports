//
//  RegisterSexViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/9/29.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "RegisterSexViewController.h"
#import "SelectTimeV.h"
#import "RegisterLocationViewController.h"

@interface RegisterSexViewController ()
@property (nonatomic, strong) UIDatePicker *myDatePicker;

@end

@implementation RegisterSexViewController
{
    UIButton * manBtn;
    UIButton * womanBtn;
    UIButton *timeButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进入到注册-性别/出生日期页");
    //添加右侧按钮
    UIView *view = [[SVJumpViewController alloc]initwithRightButton:@"跳过"];
    [self.view addSubview:view];

    [self creatUI];
}
-(void)creatUI
{
    UILabel *youLabel = [[UILabel alloc]init];
    [youLabel setText:@"你的性别是?"];
    [youLabel setFont:[UIFont systemFontOfSize:25]];
    [youLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:youLabel];
    [youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).with.offset(80);
        make.centerX.equalTo(self.view.centerX);
    }];

    UILabel *dontLabel = [[UILabel alloc]init];
    [dontLabel setText:@"别搞错了哦!否则很麻烦!"];
    [dontLabel setFont:[UIFont systemFontOfSize:15]];
    [dontLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:dontLabel];
    [dontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(youLabel.bottom).with.offset(10);
        make.centerX.equalTo(self.view.centerX);
    }];

    manBtn =  [WBViewTool  initWithRegisterButton:@"男"];
    [manBtn addTarget:self
                 action:@selector (manBtnClick)
       forControlEvents:UIControlEventTouchUpInside];
    [manBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    manBtn.layer.cornerRadius = 30;
    manBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:manBtn];
    [manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX).with.offset(-50);
        make.top.equalTo (dontLabel.bottom).with.offset (20);
        make.height.mas_equalTo (60);
        make.width.mas_equalTo (60);
    }];

    womanBtn =  [WBViewTool  initWithRegisterButton:@"女"];
    [womanBtn addTarget:self
               action:@selector (womanBtnClick)
     forControlEvents:UIControlEventTouchUpInside];
    [womanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    womanBtn.layer.cornerRadius = 30;
    womanBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:womanBtn];
    [womanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX).with.offset(50);
        make.top.equalTo (dontLabel.bottom).with.offset (20);
        make.height.mas_equalTo (60);
        make.width.mas_equalTo (60);
    }];

    UILabel *youAgeLabel =[[UILabel alloc]init];
    [youAgeLabel setText:@"你的出生年月?"];
    [youAgeLabel setFont:[UIFont systemFontOfSize:25]];
    [youAgeLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:youAgeLabel];
    [youAgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(manBtn.bottom).with.offset(50);
        make.centerX.equalTo(self.view.centerX);
    }];

    UILabel *secretLabel = [[UILabel alloc]init];
    [secretLabel setText:@"除了你想告诉的人,这绝对是秘密!"];
    [secretLabel setFont:[UIFont systemFontOfSize:15]];
    [secretLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:secretLabel];
    [secretLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(youAgeLabel.bottom).with.offset(20);
        make.centerX.equalTo(self.view.centerX);
    }];

    //HyperlinksButton
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents *comp = [calendar components: unitFlags fromDate:[NSDate date]];


    timeButton = [[HyperlinksButton alloc]initWithTitle:[NSString stringWithFormat:@"%ld年%ld月%ld日",comp.year,comp.month,comp.day] Font:30 LineColor:[UIColor blackColor] TitleColor:[UIColor blackColor]];
    [timeButton addTarget:self
                      action:@selector (timeButtonClick)
            forControlEvents:UIControlEventTouchUpInside];
    //按钮文字居中方式
    timeButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:timeButton];
    [timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(secretLabel.bottom).with.offset(30);
    }];


    UIButton * continueBtn =  [WBViewTool  initWithRegisterButton:@"继续"];
    [continueBtn addTarget:self
                 action:@selector (continueBtnClick)
       forControlEvents:UIControlEventTouchUpInside];
    [continueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:continueBtn];
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.bottom.equalTo (self.view.bottom).with.offset (-100);
        make.height.mas_equalTo (45);
        make.left.mas_equalTo (self.view.left).with.offset(50);
        make.right.mas_equalTo (self.view.right).with.offset(-50);
    }];


}

-(void)continueBtnClick
{
    RegisterLocationViewController * registerLocationViewController = [[RegisterLocationViewController alloc]init];
    [self.navigationController pushViewController:registerLocationViewController animated:YES];
}
-(void)timeButtonClick
{
    //添加时间选择器
    SelectTimeV *selectTimeV = [[SelectTimeV alloc] init];
    selectTimeV.block = ^(NSString *timeStr) {
        if (timeStr) {
            [timeButton setTitle:timeStr forState:(UIControlStateNormal)];
            //信息上传至服务器
        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
}

-(void)manBtnClick
{
    NSLog(@"选择了男");
    [manBtn setBackgroundColor:[UIColor lightGrayColor]];
    [womanBtn setBackgroundColor:[UIColor whiteColor]];
    //信息上传至服务器
}
-(void)womanBtnClick
{
    NSLog(@"选择了女");
    [manBtn setBackgroundColor:[UIColor whiteColor]];
    [womanBtn setBackgroundColor:[UIColor lightGrayColor]];
    //信息上传至服务器
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

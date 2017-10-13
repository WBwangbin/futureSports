//
//  RegisterEducationViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/9/30.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "RegisterEducationViewController.h"
#import "RegisterSportViewController.h"
#import "SelectEducation.h"
#import "SelectProfession.h"

@interface RegisterEducationViewController ()

@end

@implementation RegisterEducationViewController
{
    UIButton * heightButton;
    UIButton * weightButton;
    UILabel *useWeightLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进入到注册-学历/职业");
    //添加右侧按钮
    UIView *view = [[SVJumpViewController alloc]initwithRightButton:@"跳过"];
    [self.view addSubview:view];
    [self creatUI];
}

-(void)creatUI
{
    UILabel *youHeightLabel = [[UILabel alloc]init];
    [youHeightLabel setText:@"你的学历?"];
    [youHeightLabel setFont:[UIFont systemFontOfSize:25]];
    [youHeightLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:youHeightLabel];
    [youHeightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).with.offset(80);
        make.centerX.equalTo(self.view.centerX);
    }];

    UILabel *useHeightLabel = [[UILabel alloc]init];
    [useHeightLabel setText:@"运动也要拼学历?"];
    [useHeightLabel setFont:[UIFont systemFontOfSize:15]];
    [useHeightLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:useHeightLabel];
    [useHeightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(youHeightLabel.bottom).with.offset(10);
        make.centerX.equalTo(self.view.centerX);
    }];

    //学历
    heightButton = [[HyperlinksButton alloc]initWithTitle:[NSString stringWithFormat:@"本科"] Font:30 LineColor:[UIColor blackColor] TitleColor:[UIColor blackColor]];
    [heightButton addTarget:self
                     action:@selector (heightButtonClick)
           forControlEvents:UIControlEventTouchUpInside];
    heightButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:heightButton];
    [heightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(useHeightLabel.bottom).with.offset(20);
    }];


    UILabel *youWeightLabel = [[UILabel alloc]init];
    [youWeightLabel setText:@"你的职业?"];
    [youWeightLabel setFont:[UIFont systemFontOfSize:25]];
    [youWeightLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:youWeightLabel];
    [youWeightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(heightButton.bottom).with.offset(60);
        make.centerX.equalTo(self.view.centerX);
    }];

    useWeightLabel = [[UILabel alloc]init];
    [useWeightLabel setText:@"根据您的职业偏好为您推荐志同道合的好友"];
    [useWeightLabel setFont:[UIFont systemFontOfSize:15]];
    [useWeightLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:useWeightLabel];
    [useWeightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(youWeightLabel.bottom).with.offset(10);
        make.centerX.equalTo(self.view.centerX);
    }];

    //职业
    weightButton = [[HyperlinksButton alloc]initWithTitle:[NSString stringWithFormat:@"IT|互联网|通信"] Font:30 LineColor:[UIColor blackColor] TitleColor:[UIColor blackColor]];
    [weightButton addTarget:self
                     action:@selector (weightButtonClick)
           forControlEvents:UIControlEventTouchUpInside];
    weightButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [self.view addSubview:weightButton];
    [weightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(useWeightLabel.bottom).with.offset(20);
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
    RegisterSportViewController * registerSportViewController = [[RegisterSportViewController alloc]init];
    [self.navigationController pushViewController:registerSportViewController animated:YES];
}
-(void)heightButtonClick
{
    NSLog(@"点击了学历");
    //添加学历选择器
    SelectEducation *selectEducation = [[SelectEducation alloc] init];
    selectEducation.block = ^(NSString *timeStr) {
        if (timeStr) {
            [heightButton setTitle:timeStr forState:(UIControlStateNormal)];
            NSLog(@"学历是%@",timeStr);
            //信息上传至服务器

        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:selectEducation];
}
-(void)weightButtonClick
{
    NSLog(@"点击了职业");
    //添加体重选择器
    SelectProfession *selectProfession = [[SelectProfession alloc] init];
    selectProfession.block = ^(NSString *timeStr) {
        if (timeStr) {
            [weightButton setTitle:timeStr forState:(UIControlStateNormal)];
            NSLog(@"职业是%@",timeStr);
            //信息上传至服务器

        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:selectProfession];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

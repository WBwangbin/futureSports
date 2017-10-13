//
//  RegisterHeightWeightViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/9/30.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "RegisterHeightWeightViewController.h"
#import "RegisterEducationViewController.h"
#import "SelectHeight.h"
#import "SelectWeight.h"

@interface RegisterHeightWeightViewController ()

@end

@implementation RegisterHeightWeightViewController

{
    UIButton * heightButton;
    UIButton * weightButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进入到注册-身高体重设置页");
    //添加右侧按钮
    UIView *view = [[SVJumpViewController alloc]initwithRightButton:@"要测一下,先不填"];
    [self.view addSubview:view];

    [self creatUI];
}

-(void)creatUI
{
    UILabel *youHeightLabel = [[UILabel alloc]init];
    [youHeightLabel setText:@"你的身高?"];
    [youHeightLabel setFont:[UIFont systemFontOfSize:25]];
    [youHeightLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:youHeightLabel];
    [youHeightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).with.offset(80);
        make.centerX.equalTo(self.view.centerX);
    }];

    UILabel *useHeightLabel = [[UILabel alloc]init];
    [useHeightLabel setText:@"用于运动评估"];
    [useHeightLabel setFont:[UIFont systemFontOfSize:15]];
    [useHeightLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:useHeightLabel];
    [useHeightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(youHeightLabel.bottom).with.offset(10);
        make.centerX.equalTo(self.view.centerX);
    }];

    //身高
    heightButton = [[HyperlinksButton alloc]initWithTitle:[NSString stringWithFormat:@"175cm"] Font:30 LineColor:[UIColor blackColor] TitleColor:[UIColor blackColor]];
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
    [youWeightLabel setText:@"你的体重?"];
    [youWeightLabel setFont:[UIFont systemFontOfSize:25]];
    [youWeightLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:youWeightLabel];
    [youWeightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(heightButton.bottom).with.offset(60);
        make.centerX.equalTo(self.view.centerX);
    }];

    UILabel *useWeightLabel = [[UILabel alloc]init];
    [useWeightLabel setText:@"用于运动评估"];
    [useWeightLabel setFont:[UIFont systemFontOfSize:15]];
    [useWeightLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:useWeightLabel];
    [useWeightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(youWeightLabel.bottom).with.offset(10);
        make.centerX.equalTo(self.view.centerX);
    }];

    //体重
    weightButton = [[HyperlinksButton alloc]initWithTitle:[NSString stringWithFormat:@"70kg"] Font:30 LineColor:[UIColor blackColor] TitleColor:[UIColor blackColor]];
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
    RegisterEducationViewController * registerEducationViewController = [[RegisterEducationViewController alloc]init];
    [self.navigationController pushViewController:registerEducationViewController animated:YES];
}
-(void)heightButtonClick
{
    NSLog(@"点击了身高");
    //添加身高选择器
    SelectHeight *selectHeight = [[SelectHeight alloc] init];
    selectHeight.block = ^(NSString *timeStr) {
        if (timeStr) {
            [heightButton setTitle:timeStr forState:(UIControlStateNormal)];
            NSLog(@"身高是%@",timeStr);
            //信息上传至服务器
        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:selectHeight];
}
-(void)weightButtonClick
{
    NSLog(@"点击了体重");
    //添加体重选择器
    SelectWeight *selectWeight = [[SelectWeight alloc] init];
    selectWeight.block = ^(NSString *timeStr) {
        if (timeStr) {
            [weightButton setTitle:timeStr forState:(UIControlStateNormal)];
            NSLog(@"体重是%@",timeStr);
            //信息上传至服务器
        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:selectWeight];
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

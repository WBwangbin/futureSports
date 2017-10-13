//
//  RegisterSportViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/9/30.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "RegisterSportViewController.h"
#import "RegisterFirendsViewController.h"

@interface RegisterSportViewController ()

@end

@implementation RegisterSportViewController
{
    UIImageView *footBallImageView;
    UIImageView *basketBallImageView;
    UIImageView *badmintonImageView;
    UIImageView *tennisImageView;
    UIImageView *skiingImageView;
    UIImageView *yogaImageView;

    BOOL footBallBool;
    BOOL basketBallBool;
    BOOL badmintonBool;
    BOOL tennisBool;
    BOOL skiingBool;
    BOOL yogaBool;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     NSLog(@"进入到注册-运动偏好设置页");
    //添加右侧按钮
    UIView *view = [[SVJumpViewController alloc]initwithRightButton:@"跳过"];
    [self.view addSubview:view];
    [self creatUI];

    //初始化
    footBallBool = YES;
    basketBallBool = YES;
    badmintonBool = YES;
    tennisBool = YES;
    skiingBool = YES;
    yogaBool = YES;
}

-(void)creatUI
{
    UILabel *youLabel = [[UILabel alloc]init];
    [youLabel setText:@"你要参与的运动?"];
    [youLabel setFont:[UIFont systemFontOfSize:25]];
    [youLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:youLabel];
    [youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).with.offset(80);
        make.centerX.equalTo(self.view.centerX);
    }];

    UIButton * footBallBtn =  [WBViewTool  initWithRegisterButton:@"足球"];
    [footBallBtn addTarget:self
                    action:@selector (footBallBtnClick)
          forControlEvents:UIControlEventTouchUpInside];
    [footBallBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:footBallBtn];
    [footBallBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.top.equalTo (youLabel.top).with.offset(50);
        make.height.mas_equalTo (45);
        make.left.mas_equalTo (self.view.left).with.offset(66);
        make.right.mas_equalTo (self.view.right).with.offset(-66);
    }];

    UIButton * basketBallBtn =  [WBViewTool  initWithRegisterButton:@"篮球"];
    [basketBallBtn addTarget:self
                    action:@selector (basketBallBtnClick)
          forControlEvents:UIControlEventTouchUpInside];
    [basketBallBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:basketBallBtn];
    [basketBallBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.top.equalTo (footBallBtn.bottom).with.offset(10);
        make.height.mas_equalTo (45);
        make.size.mas_equalTo(footBallBtn);
    }];

    UIButton * badmintonBtn =  [WBViewTool  initWithRegisterButton:@"羽毛球"];
    [badmintonBtn addTarget:self
                      action:@selector (badmintonBtnClick)
            forControlEvents:UIControlEventTouchUpInside];
    [badmintonBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:badmintonBtn];
    [badmintonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.top.equalTo (basketBallBtn.bottom).with.offset(10);
        make.height.mas_equalTo (45);
        make.size.mas_equalTo(footBallBtn);
    }];

    UIButton * tennisBtn =  [WBViewTool  initWithRegisterButton:@"网球"];
    [tennisBtn addTarget:self
                     action:@selector (tennisBtnClick)
           forControlEvents:UIControlEventTouchUpInside];
    [tennisBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:tennisBtn];
    [tennisBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.top.equalTo (badmintonBtn.bottom).with.offset(10);
        make.height.mas_equalTo (45);
        make.size.mas_equalTo(footBallBtn);
    }];

    UIButton * skiingBtn =  [WBViewTool  initWithRegisterButton:@"滑雪"];
    [skiingBtn addTarget:self
                  action:@selector (skiingBtnClick)
        forControlEvents:UIControlEventTouchUpInside];
    [skiingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:skiingBtn];
    [skiingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.top.equalTo (tennisBtn.bottom).with.offset(10);
        make.height.mas_equalTo (45);
        make.size.mas_equalTo(footBallBtn);
    }];

    UIButton * yogaBtn =  [WBViewTool  initWithRegisterButton:@"瑜伽"];
    [yogaBtn addTarget:self
                  action:@selector (yogaBtnClick)
        forControlEvents:UIControlEventTouchUpInside];
    [yogaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:yogaBtn];
    [yogaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.top.equalTo (skiingBtn.bottom).with.offset(10);
        make.height.mas_equalTo (45);
        make.size.mas_equalTo(footBallBtn);
    }];

    //选中图片
    footBallImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"designer_Selected"]];
    footBallImageView.hidden = YES;
    [footBallBtn addSubview:footBallImageView];
    [footBallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footBallBtn).with.offset(20);
        make.centerY.equalTo(footBallBtn);
        make.size.equalTo(CGSizeMake(20,20));
    }];
    //选中图片
    basketBallImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"designer_Selected"]];
    basketBallImageView.hidden = YES;
    [basketBallBtn addSubview:basketBallImageView];
    [basketBallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(basketBallBtn).with.offset(20);
        make.centerY.equalTo(basketBallBtn);
        make.size.equalTo(CGSizeMake(20,20));
    }];
    //选中图片
    badmintonImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"designer_Selected"]];
    badmintonImageView.hidden = YES;
    [badmintonBtn addSubview:badmintonImageView];
    [badmintonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(badmintonBtn).with.offset(20);
        make.centerY.equalTo(badmintonBtn);
        make.size.equalTo(CGSizeMake(20,20));
    }];
    //选中图片
    tennisImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"designer_Selected"]];
    tennisImageView.hidden = YES;
    [tennisBtn addSubview:tennisImageView];
    [tennisImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tennisBtn).with.offset(20);
        make.centerY.equalTo(tennisBtn);
        make.size.equalTo(CGSizeMake(20,20));
    }];
    //选中图片
    skiingImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"designer_Selected"]];
    skiingImageView.hidden = YES;
    [skiingBtn addSubview:skiingImageView];
    [skiingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(skiingBtn).with.offset(20);
        make.centerY.equalTo(skiingBtn);
        make.size.equalTo(CGSizeMake(20,20));
    }];
    //选中图片
    yogaImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"designer_Selected"]];
    yogaImageView.hidden = YES;
    [yogaBtn addSubview:yogaImageView];
    [yogaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yogaBtn).with.offset(20);
        make.centerY.equalTo(yogaBtn);
        make.size.equalTo(CGSizeMake(20,20));
    }];


    UIButton * continueBtn =  [WBViewTool  initWithRegisterButton:@"继续"];
    [continueBtn addTarget:self
                    action:@selector (continueBtnClick)
          forControlEvents:UIControlEventTouchUpInside];
    [continueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:continueBtn];
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.bottom.equalTo (self.view.bottom).with.offset(-50);
        make.height.mas_equalTo (45);
        make.left.mas_equalTo (self.view.left).with.offset(50);
        make.right.mas_equalTo (self.view.right).with.offset(-50);
    }];
}
-(void)footBallBtnClick
{
    if (footBallBool) {
        footBallImageView.hidden = NO;
        footBallBool = NO;
        NSLog(@"选择了足球");
    }else{
        footBallImageView.hidden = YES;
        footBallBool = YES;
        NSLog(@"取消选择了足球");
    }
}
-(void)basketBallBtnClick
{
    if (basketBallBool) {
        basketBallImageView.hidden = NO;
        basketBallBool = NO;
        NSLog(@"选择了篮球");
    }else{
        basketBallImageView.hidden = YES;
        basketBallBool = YES;
        NSLog(@"取消选择了篮球");
    }
}
-(void)badmintonBtnClick
{
    if (badmintonBool) {
        badmintonImageView.hidden = NO;
        badmintonBool = NO;
        NSLog(@"选择了羽毛球");
    }else{
        badmintonImageView.hidden = YES;
        badmintonBool = YES;
        NSLog(@"取消选择了羽毛球");
    }
}
-(void)tennisBtnClick
{
    if (tennisBool) {
        tennisImageView.hidden = NO;
        tennisBool = NO;
        NSLog(@"选择了网球");
    }else{
        tennisImageView.hidden = YES;
        tennisBool = YES;
        NSLog(@"取消选择了网球");
    }
}
-(void)skiingBtnClick
{
    if (skiingBool) {
        skiingImageView.hidden = NO;
        skiingBool = NO;
        NSLog(@"选择了滑雪");
    }else{
        skiingImageView.hidden = YES;
        skiingBool = YES;
        NSLog(@"取消选择了滑雪");
    }
}
-(void)yogaBtnClick
{
    if (yogaBool) {
        yogaImageView.hidden = NO;
        yogaBool = NO;
            NSLog(@"选择了瑜伽");
    }else{
        yogaImageView.hidden = YES;
        yogaBool = YES;
            NSLog(@"取消选择了瑜伽");
    }
}
-(void)continueBtnClick
{
    RegisterFirendsViewController * registerFirendsViewController = [[RegisterFirendsViewController alloc]init];
    [self.navigationController pushViewController:registerFirendsViewController animated:YES];
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

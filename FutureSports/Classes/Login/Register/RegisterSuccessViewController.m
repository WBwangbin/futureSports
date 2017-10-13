
//
//  RegisterSuccessViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/9/29.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "RegisterSuccessViewController.h"
#import "RegisterSexViewController.h"
@interface RegisterSuccessViewController ()

@end

@implementation RegisterSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进入到注册-成功页");
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
}
-(void)creatUI
{
    //对勾图片
    UIImageView *yesImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"designer_Selected"]];
    [self.view addSubview:yesImageView];
    [yesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(50);
        make.top.equalTo(self.view.top).with.offset(50);
        make.size.equalTo(CGSizeMake(70,70));
    }];

    UILabel *successLabel = [[UILabel alloc]init];
    [successLabel setText:@"注册成功"];
    [successLabel setFont:[UIFont systemFontOfSize:28]];
    [successLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:successLabel];
    [successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yesImageView.bottom).with.offset(20);
        make.left.equalTo(yesImageView.left);
    }];
    UILabel *welcomeLabel = [[UILabel alloc]init];
    welcomeLabel.numberOfLines = 0;
    [welcomeLabel setText:@"喔!欢迎你成为 Sporter中的一员"];
    [welcomeLabel setFont:[UIFont systemFontOfSize:20]];
    [welcomeLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:welcomeLabel];
    [welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(successLabel.bottom).with.offset(20);
        make.left.equalTo(successLabel.left);
        make.right.equalTo(self.view.right).with.offset(-SafeDistance);
    }];
    UILabel *accordLabel = [[UILabel alloc]init];
    [accordLabel setText:@"按照惯例"];
    [accordLabel setFont:[UIFont systemFontOfSize:28]];
    [accordLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:accordLabel];
    [accordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(welcomeLabel.bottom).with.offset(20);
        make.left.equalTo(welcomeLabel.left);
    }];

    UILabel *soLabel = [[UILabel alloc]init];
    [soLabel setText:@"一般我们会问新来的几个问题,以便你获得更极致的体验!"];
    [soLabel setFont:[UIFont systemFontOfSize:20]];
    [soLabel setTextColor:[UIColor blackColor]];
    soLabel.numberOfLines = 0;
    [self.view addSubview:soLabel];
    [soLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(accordLabel.bottom).with.offset(20);
        make.left.equalTo(accordLabel.left);
        make.right.equalTo(self.view.right).with.offset(-SafeDistanceDouble);
    }];

    UIButton * beginBtn =  [WBViewTool  initWithRegisterButton:@"开始吧!"];
    [beginBtn addTarget:self
                  action:@selector (beginBtnClick)
        forControlEvents:UIControlEventTouchUpInside];
    [beginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:beginBtn];
    [beginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.bottom.equalTo (self.view.bottom).with.offset (-100);
        make.height.mas_equalTo (45);
        make.left.mas_equalTo (self.view.left).with.offset(50);
        make.right.mas_equalTo (self.view.right).with.offset(-50);
    }];

}
-(void)beginBtnClick
{
    RegisterSexViewController * registerSexViewController = [[RegisterSexViewController alloc]init];
    [self.navigationController pushViewController:registerSexViewController animated:YES];
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

//
//  SVJumpViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/9/29.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "SVJumpViewController.h"
#import "RootViewController.h"
//#import "UMSocialManager."
@interface SVJumpViewController ()

@end

@implementation SVJumpViewController

//默认是加个左返回按钮
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //左按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setImage:[UIImage imageNamed:@"homeindicator.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftNavBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).with.offset(7);
        make.centerY.equalTo(self.view.top).with.offset(35);
        make.size.equalTo(CGSizeMake(47, 23));
    }];
}

//有左返回按钮,又有右跳过按钮
-(UIView *)initwithRightButton:(NSString *)str
{
    self.view.backgroundColor = [UIColor whiteColor];

    //左按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setImage:[UIImage imageNamed:@"homeindicator.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftNavBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).with.offset(7);
        make.centerY.equalTo(self.view.top).with.offset(35);
        make.size.equalTo(CGSizeMake(47, 23));
    }];
    //右按钮
    UIButton * rightbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightbutton setTitle:str forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(rightNavBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightbutton];
    [rightbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.right).with.offset(-15);
        make.centerY.equalTo(self.view.top).with.offset(35);
    }];
    return self.view;
}
-(void)leftNavBtnClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightNavBtnClick:(UIButton *)button
{
    RootViewController * rootViewController = [[RootViewController alloc]init];
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    window.rootViewController = [[UINavigationController alloc]initWithRootViewController:rootViewController ];
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

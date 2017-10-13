//
//  RegisterFirendsViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/9/30.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "RegisterFirendsViewController.h"
#import "RootViewController.h"

@interface RegisterFirendsViewController ()

@end

@implementation RegisterFirendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进入到注册-推荐好友");
    //添加右侧按钮
    UIView *view = [[SVJumpViewController alloc]initwithRightButton:@"跳过"];
    [self.view addSubview:view];
    [self creatUI];
}

-(void)creatUI
{
    UILabel *youLabel = [[UILabel alloc]init];
    [youLabel setText:@"推荐好友"];
    [youLabel setFont:[UIFont systemFontOfSize:25]];
    [youLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:youLabel];
    [youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).with.offset(80);
        make.centerX.equalTo(self.view.centerX);
    }];

    UIButton * continueBtn =  [WBViewTool  initWithRegisterButton:@"完成"];
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

-(void)continueBtnClick
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

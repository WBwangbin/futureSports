//
//  RegisterLocationViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/9/30.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "RegisterLocationViewController.h"
#import "RegisterHeightWeightViewController.h"
//定位头
#import <CoreLocation/CoreLocation.h>

@interface RegisterLocationViewController ()<CLLocationManagerDelegate>//定位协议
@property (nonatomic, strong) CLLocationManager *locationManager;//定位
@end

@implementation RegisterLocationViewController
{
    UIButton * locationeBtn;
    NSString *mystr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进入到注册-位置页");
    //添加右侧按钮
    UIView *view = [[SVJumpViewController alloc]initwithRightButton:@"跳过"];
    [self.view addSubview:view];

    [self creatUI];

    //进入界面定位一下
    [self startLocation];//定位
}

-(void)creatUI
{
    UILabel *youLabel = [[UILabel alloc]init];
    [youLabel setText:@"你所在的城市?"];
    [youLabel setFont:[UIFont systemFontOfSize:25]];
    [youLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:youLabel];
    [youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).with.offset(80);
        make.centerX.equalTo(self.view.centerX);
    }];

    UILabel *dontLabel = [[UILabel alloc]init];
    [dontLabel setText:@"不必担心暴露行踪,还可以帮助运动记录轨迹"];
    [dontLabel setFont:[UIFont systemFontOfSize:15]];
    [dontLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:dontLabel];
    [dontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(youLabel.bottom).with.offset(10);
        make.centerX.equalTo(self.view.centerX);
    }];

    //定位图片
    UIImageView *yesImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"designer_Selected"]];
    [self.view addSubview:yesImageView];
    [yesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).with.offset(-50);
        make.size.equalTo(CGSizeMake(70,70));
    }];

    //文字变化的适配问题?
    if(mystr){
        locationeBtn =  [WBViewTool  initWithRegisterButton:mystr];
    }else{
        locationeBtn =  [WBViewTool  initWithRegisterButton:@" 开始定位    "];
    }

    [locationeBtn addTarget:self
                    action:@selector (locationeBtnClick)
          forControlEvents:UIControlEventTouchUpInside];
    [locationeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:locationeBtn];
    [locationeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (self.view.centerX);
        make.top.equalTo (yesImageView.bottom).with.offset(20);
        make.height.mas_equalTo (45);
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
-(void)locationeBtnClick
{
    NSLog(@"开始定位");
    [MyHUD showInView:self.view text:@"开始定位"];
    [self startLocation];//定位

}
-(void)continueBtnClick
{
    RegisterHeightWeightViewController * registerHeightWeightViewController = [[RegisterHeightWeightViewController alloc]init];
    [self.navigationController pushViewController:registerHeightWeightViewController animated:YES];
}
//开始定位
- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        //控制定位精度,越高耗电量越
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        // 总是授权
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
        [MyHUD showInView:self.view  text:@"访问被拒绝"];
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
        [MyHUD showInView:self.view  text:@"无法获取位置信息"];
    }
}
//定位代理经纬度回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            //返回位置信息
            //两个样本北京/遵化
            NSLog(@"国家---%@",placemark.country);//中国
            NSLog(@"国家码---%@",placemark.ISOcountryCode);//CN
            NSLog(@"城市---%@", placemark.locality);//北京市/唐山市
            NSLog(@"区名---%@",placemark.subLocality); //昌平区/遵化市
            NSLog(@"街道---%@",placemark.name);//上白路/东旧寨镇
            NSLog(@"街道---%@",placemark.thoroughfare);//上白路/null
            NSLog(@"省名---%@",placemark.administrativeArea);//null/河北省

//            NSLog(@"%@",placemark.subAdministrativeArea);
//            NSLog(@"%@",placemark.subThoroughfare);
//            NSLog(@"%@",placemark.postalCode);
//            NSLog(@"%@",placemark.inlandWater);
//            NSLog(@"%@",placemark.ocean);
//            NSLog(@"%@",placemark.areasOfInterest);

            if (![NSString fnt_isEmpty:placemark.locality]&& ![NSString fnt_isEmpty:placemark.subLocality])
            {
                mystr = [NSString stringWithFormat:@" %@  %@    ",placemark.locality,placemark.subLocality];
            }
            if ([NSString fnt_isEmpty:placemark.locality]&& ![NSString fnt_isEmpty:placemark.subLocality])
            {
                mystr = [NSString stringWithFormat:@" %@      ",placemark.subLocality];
            }
            if (![NSString fnt_isEmpty:placemark.locality]&& [NSString fnt_isEmpty:placemark.subLocality])
            {
                mystr = [NSString stringWithFormat:@"  %@    ",placemark.locality];
            }
            if ([NSString fnt_isEmpty:placemark.locality]&& [NSString fnt_isEmpty:placemark.subLocality])
            {
                mystr = [NSString stringWithFormat:@" 定位内容为空  "];
            }
            [MyHUD showInView:self.view  text:@"定位成功"];
            [locationeBtn setTitle:mystr forState:(UIControlStateNormal)];
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
            [MyHUD showInView:self.view  text:@"定位失败"];
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
            [MyHUD showInView:self.view  text:@"定位失败"];
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  AppDelegate.m
//  FutureSports
//
//  Created by wangbin on 2017/9/21.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "AppDelegate.h"
#import "SVStartPageViewController.h"
#import "RootViewController.h"
#import "LoginOldUserViewController.h"

//指纹识别
#import <LocalAuthentication/LocalAuthentication.h>
//友盟三方登录
#import <UMSocialCore/UMSocialCore.h>
//友盟三方登录key
static NSString *USHARE_DEMO_APPKEY = @"57bfdf8667e58e01eb0032e5";
static NSString *WXAppKey = @"wxd02e8e4ff67cc588";
static NSString *WXAppSecret = @"92d4cd542254a57630d7e0a7055f68f4";
//static NSString *WXRedirectURL = @"";
static NSString *WBAppKey = @"2375947753";
static NSString *WBAppSecret = @"7eb07be7e3122fd580e8e8803a3cfabf";
static NSString *WBRedirectURL = @"http://www.naycent.com";
static NSString *QQAppKey = @"1106352508";
//static NSString *QQAppSecret = @"";
static NSString *QQRedirectURL = @"http://mobile.umeng.com/social";

//日志
#import <DDLog.h>//整个框架的基础
#import <DDASLLogger.h>//发送日志语句到苹果的日志系统，以便它们显示在Console.app上
#import <DDTTYLogger.h>//发送日志语句到Xcode控制台，如果可用
#import <DDFileLogger.h>//把日志语句发送至文件
//日志级别阈值以上的DDLog语句都将编译到你的项目中。
//DDLog 必须配置打印级别
//下面的这些不同的日志等级也许正有你所需要的：
//1.如果你将日志级别设置为 LOG_LEVEL_ERROR，那么你只会看到DDlogError语句。
//2.如果你将日志级别设置为LOG_LEVEL_WARN，那么你只会看到DDLogError和DDLogWarn语句。
//3.如果您将日志级别设置为 LOG_LEVEL_INFO,那么你会看到error、Warn和Info语句。
//4.如果您将日志级别设置为LOG_LEVEL_VERBOSE,那么你会看到所有DDLog语句。
//5.如果您将日志级别设置为 LOG_LEVEL_OFF,你将不会看到任何DDLog语句。
static const int ddLogLevel = DDLogLevelAll;



@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];


    DDLogVerbose(@"Verbose");
    DDLogDebug(@"Debug");
    DDLogInfo(@"Info");
    DDLogWarn(@"Warn");
    DDLogError(@"Error");


    //日志收集(日志会被拦截，开发的时候注掉)
    //    [self redirectNSlogToDocumentFolder];


    //指纹识别
    [self safeToFaceID];

    //获取用户信息
    NSLog(@"************************用户信息*****************************");
    NSLog(@"用户手机iOS版本%@",[UIDevice currentDevice].systemVersion);
    NSLog(@"当前WIFI名称为%@",[SVCurrentDevice getWifiName]);
    NSLog(@"当前ip地址为%@",[SVCurrentDevice getIPAddress]);
    NSLog(@"当前设备型号为%@",[SVCurrentDevice deviceType]);
    NSLog(@"************************************************************");

    //停留1s再进主界面
//    [NSThread sleepForTimeInterval:1.0];

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];

    // 如果是第一次进入该APP，则为新用户
    WBPerferences *probeInfo = [WBPerferences sharedInstance];
    if (![probeInfo isFirstStart])//如果是第一次启动
    {
        // 设置首次启动为NO
        //        [probeInfo setFirstStart:YES];
    }

    //进入页面判断
    int value = 1;
    if (value == 2) {
        //根控制器
        RootViewController *rootTabBarController = [[RootViewController alloc]init];
        self.window.rootViewController = rootTabBarController;
    } else if(value == 1) {
        //老用户
        LoginOldUserViewController *loginOldUserVc = [[LoginOldUserViewController alloc]init];
        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
        window.rootViewController = [[UINavigationController alloc]initWithRootViewController:loginOldUserVc ];
    }else{
        //新用户
        self.window.rootViewController =
        [[UINavigationController alloc] initWithRootViewController:[[SVStartPageViewController alloc] init]];
    }
    
    //网络状态的代理对象设置
    NetworkChangeMonitor *realReachability = [NetworkChangeMonitor sharedInstance];
    [realReachability addDelegate:self];

    //异常捕获发送到信息
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);

    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];

    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    [self configUSharePlatforms];
    [self confitUShareSettings];



    return YES;
}
#pragma mark - 日志收集
- (void)redirectNSlogToDocumentFolder
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

    NSDateFormatter *dateformat = [[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString *fileName = [NSString stringWithFormat:@"LOG-%@.txt",[dateformat stringFromDate:[NSDate date]]];
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];

    // 先删除已经存在的文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:logFilePath error:nil];

    // 将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}

#pragma mark - 指纹识别
-(void)safeToFaceID
{
    if ([[UIDevice currentDevice] systemVersion].floatValue > 8.0) {

        //新建LAContext实例
        LAContext  *authenticationContext= [[LAContext alloc]init];
        NSError *error;

        //LAPolicyDeviceOwnerAuthentication
        //1:检查Touch ID 是否可用
        if ([authenticationContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            NSLog(@"touchId 可用,正在进行指纹验证");
            //2:执行认证策略
            [authenticationContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"请输入您的指纹进入应用" reply:^(BOOL success, NSError * _Nullable error) {
                if (success) {
                    NSLog(@"通过了Touch Id指纹验证");
                }else{
                    if (error.code == -2) {//点击了取消按钮
                        NSLog(@"点击了取消按钮");
                        NSLog (@"****** exit******");
                        exit (0);
                    }else if (error.code == -4){//按下电源键
                        NSLog(@"按下电源键");
                        NSLog (@"****** exit******");
                        exit (0);
                    }
                    //                else if (error.code == -7){//在有TouchID 的功能下，没有设置TouchID的运行结果
                    //                else if (error.code == -6){//在iphone5上运行结果(没有指纹解锁功能)
                    //                else if (error.code == -8){//输入错误3次
                    //                else if (error.code == -1){//连续三次指纹识别错误
                    //                NSLog(@"未通过Touch Id指纹验证,错误描述: %@---", error.description);
                }
            }];
        }else{//Touch ID功能被锁定，下一次需要输入系统密码
            NSLog(@"touchId 不可用");
            NSLog(@"error====%@",error.description);
            //提示用户不可用
            //        ?????
        }
        return;
    }
}

#pragma mark - 网络状态改变,用户信息重新加载的设置

//启动应用后,要对网络进行检测,看是否需要重新加载用户信息
- (void)networkStatusChange:(NetworkChangeMonitorStatus)status
{
    NetworkChangeMonitorStatus lastNetworkStatus = [[WBPerferences sharedInstance] networkConnectionStatus];
    //当前网络状态和上次网络状态相同
    if (lastNetworkStatus == status)
    {
        //并且为手机网络,不需要加载数据,直接返回
        if (status != SVRealStatusViaWiFi && status != SVRealStatusNotReachable)
        {
            NSLog (@"手机网络是%li,直接返回", status);
            return;
        }
        //网络状态没有改变,检测网络名称是否改变
        WBPerferences *probeInfo = [WBPerferences sharedInstance];
        NSString *lastWifiName = probeInfo.wifiName;
        NSString *wifiName = [SVCurrentDevice getWifiName];
        // 如果上次wifi信息，和当前wifi信息不一致也需要重新加载数据
        if (lastWifiName)
        {
            // wifi不存在或者和上次WiFi一样,不需要重新加载数据
            if ([NSString fnt_isEmpty:wifiName] || [lastWifiName isEqualToString:wifiName])
            {
                NSLog (@"wifi不存在或者和上次WiFi一样,不需要重新加载数据,直接返回");
                return;
            }else{
                NSLog (@"wifi存在并且和上次WiFi不一样,需要重新加载数据");
                //
            }
        }
    }
    else
    {
        //当前网络状态和上次网络状态不一样，设置当前网络状态,需要重新加载数据
        [[WBPerferences sharedInstance] setNetworkConnectionStatus:status];
    }

    //设置当前网络状态类型
    switch (status)
    {
        case SVRealStatusViaWiFi:
            NSLog(@"%@", @"Network wifi! Free!");
            [MyHUD showInView:self.window text:@"WIFI网络已连接"];
            [[WBPerferences sharedInstance] setNetworkType:WifiNetworkType];
            break;
        case SVWWANType2G:
            NSLog (@"%@", @"RealReachabilityStatus2G");
            [MyHUD showInView:self.window text:@"已切换至2G网络"];
            [[WBPerferences sharedInstance] setNetworkType:MobileNetworkType];
            break;
        case SVWWANType3G:
            NSLog (@"%@", @"RealReachabilityStatus3G");
            [MyHUD showInView:self.window text:@"已切换至3G网络"];
            [[WBPerferences sharedInstance] setNetworkType:MobileNetworkType];
            break;
        case SVWWANType4G:
            NSLog (@"%@", @"RealReachabilityStatus4G");
            [MyHUD showInView:self.window text:@"已切换至4G网络"];
            [[WBPerferences sharedInstance] setNetworkType:MobileNetworkType];
            break;
        default:
            NSLog (@"%@", @"Network unreachable!");
            [MyHUD showInView:self.window text:@"无可用网络"];
            [[WBPerferences sharedInstance] setNetworkType:WifiNetworkType];//网络不可用时暂定为wifi
            break;
    }

    //当网络状态进行切换，或者网络类型切换时，发送通知，进行状态更新处理
    [[NSNotificationCenter defaultCenter] postNotificationName:SVNetworkStatusDidChangeNotification
                                                        object:self];

    // 如果网络不可达，则发送通知,不进行数据获取
    if (status == SVRealStatusNotReachable)
    {
        //如果网络不可达，则发送通知,不进行数据获取
        [[NSNotificationCenter defaultCenter] postNotificationName:SVNetworkStatusErrorNotification
                                                            object:self];
        NSLog (@"网络不通,做断网处理");
        //
        return;
    }
    //如果网络可达，则发送通知,进行数据获取
    if (status != SVRealStatusNotReachable)
    {
        //判断是否初始化配置
        NSLog (@"网络通,可以加载数据");
        //
        return;
    }
}

#pragma mark - 异常捕获发送到信息
//把捕获到的异常发送至开发者的邮箱
void UncaughtExceptionHandler(NSException *exception) {
    /**
     *  获取异常崩溃信息
     */
    NSArray *callStack = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *content = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[callStack componentsJoinedByString:@"\n"]];

    /**
     *  把异常崩溃信息发送至开发者邮件
     */
    NSMutableString *mailUrl = [NSMutableString string];
    [mailUrl appendString:@"mailto:wb514apple@icloud.com"];
    [mailUrl appendString:@"?subject=程序异常崩溃，请配合发送异常报告，谢谢合作！"];
    [mailUrl appendFormat:@"&body=%@", content];
    // 打开地址
//    NSString *mailPath = [mailUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailPath]];
}


#pragma mark - 友盟第三方登录

- (void)configUSharePlatforms
{
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppKey appSecret:WXAppSecret redirectURL:nil];
    // 设置分享到QQ互联的appID
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppKey  appSecret:nil redirectURL:QQRedirectURL];
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:WBAppKey  appSecret:WBAppSecret redirectURL:WBRedirectURL];
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}

#pragma mark -  友盟三方登录delegate系统回调

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
//仅支持iOS9以上系统，iOS8及以下系统不会回调
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
//支持目前所有iOS系统
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}









#pragma mark - delegate系统函数
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"FutureSports"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end

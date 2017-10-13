//
//  SVUIConfig.h
//  FutureSports
//
//  Created by wangbin on 2017/9/25.
//  Copyright © 2017年 wangbin. All rights reserved.
//


/**
 ***全局UI属性
 **/

#ifndef SVUIConfig_h
#define SVUIConfig_h


#pragma mark - color
//我的新的
#define LoginButtonColor RGBACOLOR (20, 177, 255, 1)
#define myPhone @"17778153219"
// 状态栏/电池栏(statusbar)
#define StatusRect  [[UIApplication sharedApplication] statusBarFrame]
//标题栏
#define NavRect  self.navigationController.navigationBar.frame
//电池栏高度(8是20,X是44)
#define StatusBarH 20


// 自定义颜色
#define RGBACOLOR(r, g, b, a) \
[UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:(a)]

//全局的颜色
#define LightBlue RGBACOLOR (42, 236, 255, 1)
#define NormalBlue RGBACOLOR (43, 156, 213, 1)
#define NormalBlueAlpha(a) RGBACOLOR (43, 156, 213, (a))
#define Transparent [UIColor clearColor]
#define TitleIcon RGBACOLOR (255, 255, 255, 1)

#define LightBlueTextColor [UIColor colorWithHexString:@"#2AECFF"] // 亮蓝文字颜色
#define DeepBlueTextColor [UIColor colorWithHexString:@"#2B9CD5"] // 深蓝文字颜色
#define NormalBlueTextColor [UIColor colorWithHexString:@"#29A5E5"] // 系统蓝色颜色
#define ButtonBorderNormalStateColor \
[UIColor colorWithHexString:@"#1A4f6B"] // 高级设置按钮正常边框颜色
#define AlertBackground [UIColor colorWithHexString:@"#090C19"] //弹框的背景颜色
#define AlertBackgroundAlpha(alpha) RGBACOLOR (250, 250, 250, alpha)
#define AlertMessage [UIColor colorWithHexString:@"#FAFAFA"]
#define Alerttext [UIColor colorWithHexString:@"#29E5F7"] //弹框文字颜色
#define AlerttextBandWidth [UIColor colorWithHexString:@"#a7abb2"] //带宽设置弹框文字颜色
#define WifiLabelColor [UIColor colorWithHexString:@"#526886"] // wifi文字颜色//灰色
#define DownUploadLabelColor [UIColor colorWithHexString:@"#7A808C"] //下载上传文字颜色
#define DelayValueLableColor [UIColor colorWithHexString:@"#FFA235"] //时延文字颜色
#define ChartLineColor [UIColor colorWithHexString:@"#94FF3E"] //线图线的文字颜色
#define StartGradualColor [UIColor colorWithHexString:@"#082640"] //渐变的起始颜色
#define ResolutionValueColor [UIColor colorWithHexString:@"#28DDf0"] //分辨率值文字颜色
#define VideoSourceLabelColor [UIColor colorWithHexString:@"#2B8BC1"] //视频资源文字颜色
#define ProgressTintColor [UIColor colorWithHexString:@"#88db45"] //进度条填充颜色
#define StatusLabeldColor [UIColor colorWithHexString:@"#3C6277"] //模拟播放提示文字颜色
#define TitleLabelColor [UIColor colorWithHexString:@"#1e9aa9"] //标题文字颜色
#define WhiteColor [UIColor colorWithHexString:@"#FFFFFF"] //白色
#define BlackColor [UIColor colorWithHexString:@"#000000"] //黑色
#define TabbarLabelColor [UIColor colorWithHexString:@"#869096"] // tabbar字体颜色
#define BeginButtonLabelColor [UIColor colorWithHexString:@"#0B182D"] //开始按钮文字颜色

#pragma mark - font

#define SmallerFontSize 10
#define SmallFontSize 12
#define NormalFontSize 14
#define LargeFontSize 20


#pragma mark - 适配设置

//安全距离：两个UI控件中间的最小距离
#define SafeDistance 8

#define SafeDistanceDouble 16
//// 屏幕大小
//#define kScreen [[UIScreen mainScreen] bounds]

// 屏幕宽度
#define kScreenW [[UIScreen mainScreen] bounds].size.width

// 屏幕高度
#define kScreenH [[UIScreen mainScreen] bounds].size.height


#define Screen_Width [[UIScreen mainScreen] bounds].size.width
#define Screen_Height [[UIScreen mainScreen] bounds].size.height

#define RGBCOLOR(r,g,b)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define FITWIDTH(W)  W / 375.0 * ([UIScreen mainScreen].bounds.size.width)
#define FITHEIGHT(H) H / 667.0 * ([UIScreen mainScreen].bounds.size.height)

//// 适配屏幕宽度
//#define FITWIDTH(W) (pixelToPonitW (W)) / 375.0 * ([UIScreen mainScreen].bounds.size.width)
//
//// 适配屏幕高度
//#define FITHEIGHT(H) (pixelToPonitH (H)) / 667.0 * ([UIScreen mainScreen].bounds.size.height)
////电池栏高度  20
//#define StatusBarH [UIApplication sharedApplication].statusBarFrame.size.height
//

////导航栏高度  44
////#define NavBarH       [UINavigationBar appearance].frame.size.height
//#define NavBarH self.navigationController.navigationBar.frame.size.height
//
////状态栏高度 64
//#define SNBarH StatusBarH + NavBarH
//
//// 电池栏和导航栏的默认高度
//#define NAVBARHEIGHT 64
//
//// Tabbar栏的高度 49
//#define TabBarH self.tabBarController.tabBar.frame.size.height;


//// 转换宽度像素，将1080P转换成750P
//#define changePixelW(P) (P / 1080.0) * 750.0
//
//// 转换高度像素，将1080P转换成750P
//#define changePixelH(P) (P / 1920.0) * 1334.0
//
//// 将像素转换为点-宽度
//#define pixelToPonitW(P) changePixelW (P) / 2.0
//
//// 将像素转换为点-高度
//#define pixelToPonitH(P) changePixelH (P) / 2.0
//
//// 将像素转换为点-圆角
//#define svCornerRadius(P) changePixelW (P) / 2.0


// 根据设备型号设置字体大小
#define iPhone5                                                                             \
([UIScreen instancesRespondToSelector:@selector (currentMode)] ?                        \
CGSizeEqualToSize (CGSizeMake (640, 1136), [[UIScreen mainScreen] currentMode].size) : \
NO);
#define iPhone6                                                                             \
([UIScreen instancesRespondToSelector:@selector (currentMode)] ?                        \
CGSizeEqualToSize (CGSizeMake (750, 1334), [[UIScreen mainScreen] currentMode].size) : \
NO)
#define iPhone6P                                                                             \
([UIScreen instancesRespondToSelector:@selector (currentMode)] ?                         \
CGSizeEqualToSize (CGSizeMake (1242, 2208), [[UIScreen mainScreen] currentMode].size) : \
NO)
#define pixelToFontsize(P)                \
(iPhone6P ? (P / 2.0 / 96.0 * 72.0) : \
(iPhone6 ? (P / 1.2 / 2.0 / 96.0 * 72.0) : (P / 1.3 / 2.0 / 96.0 * 72.0)))



#endif /* SVUIConfig_h */

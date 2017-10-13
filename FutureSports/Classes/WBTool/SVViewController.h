//
//  SVViewController.h
//  FutureSports
//
//  Created by wangbin on 2017/9/27.
//  Copyright © 2017年 wangbin. All rights reserved.
//

//有tabbar,有自定义返回按钮,的控制器

@interface SVViewController : UIViewController
// 自定义返回按钮
- (void)initBackButton;
//添加右滑反回手势
- (void)comeBackSuperViewWhenSwipeRight;


// 初始化标题(图片的)
- (void)initTitleView;
// 初始化标题
- (void)initTitleViewWithTitle:(nonnull NSString *)title;

// 设置图片透明度
- (nullable UIImage *)imageByApplyingAlpha:(CGFloat)alpha image:(nonnull UIImage *)image;

// 初始化TableView
- (nullable UITableView *)createTableViewWithRect:(CGRect)rect
                                        WithStyle:(UITableViewStyle)style
                                        WithColor:(nonnull UIColor *)bgColor
                                     WithDelegate:(nonnull id)delegate
                                   WithDataSource:(nonnull id)dataSource;

// 当前页面是否正在显示
- (BOOL)isVisible;

@end

//
//  RootViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/9/29.
//  Copyright © 2017年 wangbin. All rights reserved.
//
#import "RootViewController.h"
#import "HomeViewController.h"
#import "SquareViewController.h"
#import "MessageViewController.h"
#import "MyViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进入到根控制器");
    self.view.backgroundColor = [UIColor yellowColor];
    [self addViewControllers];
    [self setTabBarItems];
}
- (void)addViewControllers
{
    HomeViewController *homeViewController = [HomeViewController new];
    UINavigationController *NavHomeViewController = [[UINavigationController alloc]initWithRootViewController:homeViewController];
    SquareViewController *squareViewController = [SquareViewController new];
    UINavigationController *NavSquareViewController = [[UINavigationController alloc]initWithRootViewController:squareViewController];
    MessageViewController *messageViewController = [MessageViewController new];
    UINavigationController *NavMessageViewController = [[UINavigationController alloc]initWithRootViewController:messageViewController];
    MyViewController *myViewController = [MyViewController new];
    UINavigationController *NavMyViewController = [[UINavigationController alloc]initWithRootViewController:myViewController];
    self.viewControllers = @[NavHomeViewController,NavSquareViewController,NavMessageViewController,NavMyViewController];
}

- (void)setTabBarItems
{
    NSArray *normalImgArr = @[@"Home",@"Message",@"project",@"my"];
    NSArray *selectedImgArr = @[@"Home_pre",@"Message_pre",@"project_pre",@"my_pre"];
    NSArray *titleArr = @[@"首页",@"广场",@"消息",@"我的"];

    NSArray *items = self.tabBar.items;

    for (int i = 0; i < items.count; i++) {
        UITabBarItem *item = items[i];
        [item setTitle:titleArr[i]];
        [item setImage:[self renderingImage:normalImgArr[i]]];
        [item setSelectedImage:[self renderingImage:selectedImgArr[i]]];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBCOLOR(182, 182, 182)} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBCOLOR(10, 157, 255)} forState:UIControlStateSelected];
        [item setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    }
    //取消阴影线
    CGRect rect = CGRectMake(0, 0, Screen_Width, Screen_Height);

    UIGraphicsBeginImageContext(rect.size);

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);

    CGContextFillRect(context, rect);

    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    [self.tabBar setBackgroundImage:img];

    [self.tabBar setShadowImage:img];

    [self dropShadowWithOffset:CGSizeMake(0, -0.5f) radius:1 color:[UIColor grayColor] opacity:0.3];

}

- (UIImage *)renderingImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}


- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity
{

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);

    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;

    self.tabBar.clipsToBounds = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

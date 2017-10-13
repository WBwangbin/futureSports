//
//  SVViewController.m
//  FutureSports
//
//  Created by wangbin on 2017/9/27.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "SVViewController.h"

@interface SVViewController ()

@end

@implementation SVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //显示navigationBar
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //隐藏navigationBar
    self.navigationController.navigationBar.hidden = YES;
}
// 初始化标题
- (void)initTitleView
{
    // 定义图片
    UIImage *titleImage = [UIImage imageNamed:@"speedpro.png"];

    // 自定义navigationItem.titleView
    UIImageView *imageView =
    [[UIImageView alloc] initWithFrame:CGRectMake (0, 0, titleImage.size.width, titleImage.size.height)];

    //设置图片名称
    imageView.image = titleImage;

    //让图片适应
    imageView.contentMode = UIViewContentModeScaleAspectFit;

    //把图片添加到navigationItem.titleView
    self.navigationItem.titleView = imageView;
}
// 初始化标题
- (void)initTitleViewWithTitle:(NSString *)title
{
    //设置状态栏文字的颜色
    UIColor *color = Alerttext;
    NSDictionary *dict =
    [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.navigationItem.title = title;
}

// 初始化TableView
- (UITableView *)createTableViewWithRect:(CGRect)rect
                               WithStyle:(UITableViewStyle)style
                               WithColor:(UIColor *)bgColor
                            WithDelegate:(id)delegate
                          WithDataSource:(id)dataSource
{
    UITableView *_tableView = [[UITableView alloc] initWithFrame:rect style:style];
    _tableView.backgroundColor = bgColor;
    _tableView.delegate = delegate;
    _tableView.dataSource = dataSource;
    // 设置tableView的section的分割线隐藏
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置tableView不可上下拖动
    _tableView.bounces = NO;

    return _tableView;
}

// 自定义返回按钮
- (void)initBackButton
{
    //自定义返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"homeindicator.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];

    // 为了保持平衡添加一个rightBtn
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake (0, 0, 47, 23)];
    UIBarButtonItem *rightBackBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBackBtn;
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

// 设置图片透明度
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha image:(UIImage *)image
{
    UIGraphicsBeginImageContextWithOptions (image.size, NO, 0.0f);

    CGContextRef ctx = UIGraphicsGetCurrentContext ();
    CGRect area = CGRectMake (0, 0, image.size.width, image.size.height);

    CGContextScaleCTM (ctx, 1, -1);
    CGContextTranslateCTM (ctx, 0, -area.size.height);

    CGContextSetBlendMode (ctx, kCGBlendModeMultiply);

    CGContextSetAlpha (ctx, alpha);

    CGContextDrawImage (ctx, area, image.CGImage);

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext ();

    UIGraphicsEndImageContext ();

    return newImage;
}

// 当前页面是否正在显示
- (BOOL)isVisible
{
    return (self.isViewLoaded && self.view.window);
}
//添加右滑返回手势
- (void)comeBackSuperViewWhenSwipeRight
{
    UISwipeGestureRecognizer *rightRecognizer =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector (handleSwipeFrom:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightRecognizer];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight)
    {
        NSLog (@"swipe right, comeback!");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

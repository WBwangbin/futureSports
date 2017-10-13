//
//  SVGuideView.m
//  FutureSports
//
//  Created by wangbin on 2017/9/25.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "SVGuideView.h"

@implementation SVGuideView
{
    // 引导页的数量
    int guideViewNumber;
    // 指示当前处于第几个引导页
    UIPageControl *pageControl;
    // 用于存放并显示引导页
    UIScrollView *scrollView;
}

//根据页面个数初始化View
- (id)initWithPageNumber:(int)pageNumber
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (!self)
    {
        NSLog (@"self is nil ,return");
        return nil;
    }

    guideViewNumber = pageNumber;
    // 初始化引导页
    scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 设置代理
    scrollView.delegate = self;
    // 设置整页显示
    scrollView.pagingEnabled = YES;
    // 设置内容大小
    scrollView.contentSize = CGSizeMake (kScreenW * pageNumber, kScreenH-StatusBarH);
    // 不显示滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    //避免弹跳效果,避免把根视图露出来
    [scrollView setBounces:NO];
    scrollView.backgroundColor = [UIColor redColor];
    [self addSubview:scrollView];
    // 初始化分页信息
    pageControl = [[UIPageControl alloc] init];
    // 设置选中分页的颜色(默认是白色)
//    pageControl.currentPageIndicatorTintColor = NormalBlueTextColor;
    // 设置未选中分页的颜色(默认是蓝色)
//    pageControl.pageIndicatorTintColor = NormalBlue;
    // 设置用户不可交互
    pageControl.userInteractionEnabled = NO;
    [self addSubview:pageControl];
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo (self);
      make.right.mas_equalTo (self);
      make.bottom.mas_equalTo (self).mas_offset (-6);
      make.height.mas_equalTo (27);
    }];
    // 设置总页数
    pageControl.numberOfPages = pageNumber;
    // 初始化每个引导页的图片
    for (int index = 1; index <= pageNumber; index++)
    {
        [self createGuideViewWithIndex:index];
    }
    return self;
}
- (void)createGuideViewWithIndex:(int)index
{
    // 根据语言获取图片，并将图片添加到引导页
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_%d.jpg", index]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake (kScreenW * (index - 1), -StatusBarH, kScreenW, kScreenH);

    // 如果是最后一页，添加按钮
    if (index == guideViewNumber)
    {
        imageView.userInteractionEnabled = YES;
        //添加单击手势
        UITapGestureRecognizer *singTap = [[UITapGestureRecognizer alloc] init];
        [singTap addTarget:self action:@selector (handleSingTap)];
        [singTap setNumberOfTapsRequired:1];
        [imageView addGestureRecognizer:singTap];
    }
    [scrollView addSubview:imageView];
}

// 单击手势的事件
- (void)handleSingTap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector (hideGuideView:)])
    {
        [self.delegate hideGuideView:self];
    }
}

//设置当前页
- (void)scrollViewDidScroll:(UIScrollView *)view
{
    // 计算当前是第几页
    int index = fabs (view.contentOffset.x / kScreenW);
    // 设置当前页
    [pageControl setCurrentPage:index];
}
@end

//
//  SVCustomProgress.m
//  FutureSports
//
//  Created by wangbin on 2017/9/25.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "SVCustomProgress.h"

@interface SVCustomProgress ()

@property (nonatomic, strong) UIImageView *progressImageView;

@end

@implementation SVCustomProgress

/**
 *  初始化进度条
 *  @param trankImage    背景图片的名称
 *  @param progressImage 进度图片的名称
 *
 *  @return 进度条
 */
- (id)initWithSetTrankImage:(NSString *)trankImage setProgressImage:(NSString *)progressImage
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        // 背景图像
        _trackView = [[UIImageView alloc] init];
        [_trackView setImage:[UIImage imageNamed:trankImage]];
        //当前view的主要作用是将出界了的_progressView剪切掉，所以需将clipsToBounds设置为YES
        _trackView.clipsToBounds = YES;
        [self addSubview:_trackView];
        [_trackView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.edges.mas_equalTo (self);
        }];
        // 填充图像
        self.progressImageView = [[UIImageView alloc] init];
        [self.progressImageView setImage:[UIImage imageNamed:progressImage]];
        [_trackView addSubview:self.progressImageView];
        [self.progressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.mas_equalTo (_trackView.mas_left);
          make.size.equalTo (_trackView);
          make.top.equalTo (_trackView);
        }];
    }
    return self;
}

/**
 *  设置进度条的值
 *
 *  @param progress 进度条的值
 */
- (void)setProgress:(CGFloat)progress
{
    _targetProgress = progress * _trackView.frame.size.width;
    [self changeProgressViewFrame];
}

/**
 *  修改显示内容
 */
- (void)changeProgressViewFrame
{
    [self.progressImageView updateConstraints:^(MASConstraintMaker *make) {
      make.right.mas_equalTo (_trackView.mas_left).with.offset (_targetProgress);
      make.size.equalTo (_trackView);
      make.top.equalTo (_trackView);
    }];
}

@end

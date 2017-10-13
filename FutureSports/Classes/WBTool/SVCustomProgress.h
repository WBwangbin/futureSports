//
//  SVCustomProgress.h
//  FutureSports
//
//  Created by wangbin on 2017/9/25.
//  Copyright © 2017年 wangbin. All rights reserved.
//

/**
 ***  启动界面的进度条
 **/

@interface SVCustomProgress : UIView
@property (retain, nonatomic) UIImageView *trackView; // 进度条背景图片
@property (nonatomic) CGFloat targetProgress; //进度

/**
 *  初始化进度条
 *
 *  @param trankImage    背景图片的名称
 *  @param progressImage 进度图片的名称
 *
 *  @return 进度条
 */
- (id)initWithSetTrankImage:(NSString *)trankImage setProgressImage:(NSString *)progressImage;

/**
 *  设置进度条的值
 *
 *  @param progress 进度条的值
 */
- (void)setProgress:(CGFloat)progress;

@end

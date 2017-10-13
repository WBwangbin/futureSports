//
//  SVGuideView.h
//  FutureSports
//
//  Created by wangbin on 2017/9/25.
//  Copyright © 2017年 wangbin. All rights reserved.
//

/**
 *** 引导页
 **/

@class SVGuideView;
@protocol SVGuideViewDelegate <NSObject>
//代理方法-隐藏引导页
- (void)hideGuideView:(SVGuideView *)guideView;
@end

@interface SVGuideView : UIView <UIScrollViewDelegate>
@property (nonatomic, assign) id<SVGuideViewDelegate> delegate;
//根据页面个数初始化View
- (id)initWithPageNumber:(int)pageNumber;

@end

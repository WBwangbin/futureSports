//
//  MyHUD.m
//  FutureSports
//
//  Created by wangbin on 2017/9/28.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "MyHUD.h"

@implementation MyHUD

+ (void)showInView:(UIView *)view text:(NSString *)text
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.color = [UIColor blackColor];
    HUD.contentColor = [UIColor whiteColor];
    HUD.mode = MBProgressHUDModeText;
    HUD.label.text = text;
    HUD.label.font = [UIFont systemFontOfSize:15];
    HUD.margin = 8;
    HUD.offset = CGPointMake(0, 150);
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hideAnimated:YES afterDelay:1.5];
}

+ (MBProgressHUD *)showHUDAddTo:(UIView *)view animated:(BOOL)animated
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.label.text = @"加载中...";
    HUD.contentColor = [UIColor whiteColor];
    HUD.label.font = [UIFont systemFontOfSize:14];
    HUD.margin = 15;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.bezelView.color = [UIColor colorWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:0.5];
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //自定义动画
    UIImageView *gifImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_1"]];
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    for (int i = 1; i < 19; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%d", i]];
        [arrM addObject:image];
    }
    [gifImageView setAnimationImages:arrM];
    [gifImageView setAnimationRepeatCount:0];
    [gifImageView setAnimationDuration:2.8];
    [gifImageView startAnimating];
    
    HUD.customView = gifImageView;
    
    [view addSubview:HUD];
    
    [HUD showAnimated:animated];
    
    return HUD;
}

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated
{
    MBProgressHUD *HUD = [self HUDForView:view];
    if (HUD != nil) {
        HUD.removeFromSuperViewOnHide = YES;
        [HUD hideAnimated:animated];
        return YES;
    }
    return NO;
}

+ (MBProgressHUD *)HUDForView:(UIView *)view
{
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            return (MBProgressHUD *)subview;
        }
    }
    return nil;
}

@end

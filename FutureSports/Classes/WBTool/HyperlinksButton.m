//
//  HyperlinksButton.m
//  FutureSports
//
//  Created by wangbin on 2017/9/26.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "HyperlinksButton.h"

@implementation HyperlinksButton
{
    UIColor *lineColor;
}
- (id)initWithTitle:(NSString *)title Font:(CGFloat)font LineColor:(UIColor *)color TitleColor:(UIColor *)titleColor
{
    self = [super init];
    if (self) {
        //按钮文字
        [self setTitle:title forState:UIControlStateNormal];
        //按钮字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:font];
        //按钮文字颜色
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        //按钮文字居中方式
        self.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        //底线颜色
        [self setColor:color];
    }
    return self;
}

-(void)setColor:(UIColor *)color{
    lineColor = [color copy];
    [self setNeedsDisplay];
}

- (void) drawRect:(CGRect)rect {
    CGRect textRect = self.titleLabel.frame;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGFloat descender = self.titleLabel.font.descender;
    if([lineColor isKindOfClass:[UIColor class]]){
        CGContextSetStrokeColorWithColor(contextRef, lineColor.CGColor);
    }
    //CGContextMoveToPoint(contextRef,线的起始位置x,线的起始位置y)
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender+5);
    //CGContextAddLineToPoint(Context,线的结束位置x,线的结束位置y)
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender+5);
    CGContextClosePath(contextRef);
    //CGContextDrawPath(画线方式)
    CGContextDrawPath(contextRef, kCGPathStroke);
}
@end

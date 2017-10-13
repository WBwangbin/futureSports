//
//  SelectHeight.m
//  FutureSports
//
//  Created by wangbin on 2017/10/1.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "SelectHeight.h"

@interface SelectHeight ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSInteger heightIndex;
    UIView *topV;//picker上面的头
}
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *heightArray;

@end

@implementation SelectHeight

//初始化组
- (NSMutableArray *)heightArray {

    if (_heightArray == nil) {
        _heightArray = [NSMutableArray array];
        //区间
        for (int height = 0; height <= 250; height++) {
            NSString *str = [NSString stringWithFormat:@"%dcm", height];
            [_heightArray addObject:str];
        }
    }
    return _heightArray;
}


//重写self初始化方法
- (instancetype)init
{
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        topV = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH, kScreenW, 40)];
        topV.backgroundColor = RGBACOLOR(242, 242, 242, 1.0);
        [self addSubview:topV];

        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, 0, 100, 40);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [topV addSubview:cancelBtn];

        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:16];
        label.text = @"选择身高";
        [topV addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(topV);
        }];

        UIButton *yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        yesBtn.frame = CGRectMake(kScreenW - 100, 0, 100, 40);
        [yesBtn setTitle:@"完成" forState:UIControlStateNormal];
        [yesBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [yesBtn addTarget:self action:@selector(yesBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [yesBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [topV addSubview:yesBtn];

        //添加手势
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelBtnClick)];
        //将手势添加到需要相应的view中去
        [self.viewForLastBaselineLayout addGestureRecognizer:tapGesture];
        //选择触发事件的方式（默认单机触发）
        [tapGesture setNumberOfTapsRequired:1];

        _pickerView = [[UIPickerView alloc] init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.frame = CGRectMake(0, kScreenH + 40, kScreenW, 160);
        [self addSubview:_pickerView];

        //picker默认选择为175cm
        [_pickerView selectRow:heightIndex + 175 inComponent:0 animated:YES];
        [self pickerView:_pickerView didSelectRow:heightIndex inComponent:0];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //当前选择文字设置
            UILabel *label = (UILabel *)[_pickerView viewForRow:heightIndex forComponent:0];
            label.textColor = RGBACOLOR(26, 174, 135, 1.0);
            label.font = [UIFont systemFontOfSize:16];
        });

        //开始动画
        [UIView animateWithDuration:0.25 animations:^{
            topV.frame = CGRectMake(0, kScreenH - 200, kScreenW, 40);
            _pickerView.frame = CGRectMake(0, kScreenH - 160, kScreenW, 160);
        }];

    }
    return self;
}

-(void)cancelBtnClick
{
    if (_block) {
        _block(nil);
    }
    [self remove];
}
-(void)yesBtnClick
{
    if (_block) {
        NSString *timeStr = [NSString stringWithFormat:@"%@",((UILabel *)[_pickerView viewForRow:heightIndex forComponent:0]).text];
        //不选择时,字符串为空,不传值
        NSLog(@"需要传值的字符串:%@",timeStr);
        if(!timeStr || [timeStr isEqualToString:@"(null)"]){
            NSLog(@"未转动pickerview");
        }else{
            _block(timeStr);
        }

    }
    [self remove];
}

#pragma mark - UIPickerView的数据源
//picker个数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//每个picker显示的内容
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
        return self.heightArray.count;
}
//退场动画
- (void)remove {
    [UIView animateWithDuration:0.25 animations:^{
        topV.frame = CGRectMake(0, kScreenH, kScreenW, 40);
        _pickerView.frame = CGRectMake(0, kScreenH+40, kScreenW, 160);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}
#pragma mark -UIPickerView的代理

// 滚动UIPickerView就会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {//当滑动时
        heightIndex = row;
        //改下文字颜色
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
            label.textColor = RGBACOLOR(26, 174, 135, 1.0);
            label.font = [UIFont systemFontOfSize:16] ;
        });
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor grayColor];
        }
    }
    //设置文字的属性
    UILabel *genderLabel = [[UILabel alloc] init];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.textColor = RGBACOLOR(153, 153, 153, 1.0);
    genderLabel.font = [UIFont systemFontOfSize:14] ;
    if (component == 0) {
        genderLabel.text = self.heightArray[row];
    }
    return genderLabel;
}
@end


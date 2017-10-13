//
//  SelectTimeV.m
//  FutureSports
//
//  Created by wangbin on 2017/9/29.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "SelectTimeV.h"

@interface SelectTimeV ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
    UIView *topV;//picker上面的头
    BOOL MYyear;
    NSInteger nowYear;
}
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *yearArray;
@property (nonatomic, strong) NSMutableArray *monthArray;
@property (nonatomic, strong) NSMutableArray *dayArray;

@end

@implementation SelectTimeV

//初始化年数组
- (NSMutableArray *)yearArray {

    if (_yearArray == nil) {
        _yearArray = [NSMutableArray array];
        //年区间
        for (int year = 0; year <= nowYear; year++) {
            NSString *str = [NSString stringWithFormat:@"%d年", year];
            [_yearArray addObject:str];
        }
    }
    return _yearArray;
}

//初始化月数组
- (NSMutableArray *)monthArray {

    if (_monthArray == nil) {
        _monthArray = [NSMutableArray array];
        for (int month = 1; month <= 12; month++) {
            NSString *str = [NSString stringWithFormat:@"%02d月", month];
            [_monthArray addObject:str];
        }
    }
    return _monthArray;
}

//初始化日数组
- (NSMutableArray *)dayArray {
    if (_dayArray == nil) {
        _dayArray = [NSMutableArray array];
        for (int day = 1; day <= 31; day++) {
            NSString *str = [NSString stringWithFormat:@"%02d日", day];
            [_dayArray addObject:str];
        }
    }
    return _dayArray;
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
        label.text = @"选择日期";
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

        NSCalendar *calendar = [[NSCalendar alloc]
                                initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
        unsigned unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |  NSCalendarUnitDay |
        NSCalendarUnitHour |  NSCalendarUnitMinute |
        NSCalendarUnitSecond | NSCalendarUnitWeekday;
        // 获取不同时间字段的信息
        NSDateComponents *comp = [calendar components: unitFlags fromDate:[NSDate date]];

        nowYear = comp.year;

        yearIndex = comp.year;
        monthIndex =  comp.month;
        dayIndex = comp.day;

        //picker默认选择值
        [_pickerView selectRow:yearIndex inComponent:0 animated:YES];
        [_pickerView selectRow:monthIndex-1 inComponent:1 animated:YES];
        [_pickerView selectRow:dayIndex inComponent:2 animated:YES];

        [self pickerView:_pickerView didSelectRow:yearIndex inComponent:0];
        [self pickerView:_pickerView didSelectRow:monthIndex-1 inComponent:1];
        [self pickerView:_pickerView didSelectRow:dayIndex inComponent:2];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            //当前选择文字设置
            UILabel *label = (UILabel *)[_pickerView viewForRow:yearIndex forComponent:0];
            label.textColor = RGBACOLOR(26, 174, 135, 1.0);
            label.font = [UIFont systemFontOfSize:16];
            
            label = (UILabel *)[_pickerView viewForRow:monthIndex forComponent:1];
            label.textColor = RGBACOLOR(26, 174, 135, 1.0);
            label.font = [UIFont systemFontOfSize:16] ;

            label = (UILabel *)[_pickerView viewForRow:dayIndex forComponent:2];
            label.textColor = RGBACOLOR(26, 174, 135, 1.0);
            label.font = [UIFont systemFontOfSize:16] ;
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
        NSString *timeStr = [NSString stringWithFormat:@"%@%@%@",((UILabel *)[_pickerView viewForRow:yearIndex forComponent:0]).text, ((UILabel *)[_pickerView viewForRow:monthIndex forComponent:1]).text, ((UILabel *)[_pickerView viewForRow:dayIndex forComponent:2]).text];
        //不选择时,字符串为空,不传值
        NSLog(@"需要传值的字符串:%@",timeStr);
        if(!timeStr || [timeStr isEqualToString:@"(null)"]||[timeStr rangeOfString:@"(null)"].location !=NSNotFound){
            NSLog(@"未转动pickerview");
        }else  {
            _block(timeStr);
        }
    }
    [self remove];
}

#pragma mark - UIPickerView的数据源
//picker个数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

//每个picker显示的内容
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.yearArray.count;
    }else if(component == 1) {
        return self.monthArray.count;
    }else {

        MYyear =  ((yearIndex % 4 == 0 && yearIndex% 100 != 0)|| yearIndex % 400 == 0);
        NSLog(@"选择的年份11111----%d-----%ld-%ld-%ld",MYyear,(long)yearIndex,(long)monthIndex+1,(long)dayIndex+1);

        if (MYyear){
            switch (monthIndex+1) {
                case 1:
                case 3:
                case 5:
                case 7:
                case 8:
                case 10:
                case 12: return 31;
                case 4:
                case 6:
                case 9:
                case 11: return 30;
                default: return 29;
            }
        }else{
            switch (monthIndex+1) {
                case 1:
                case 3:
                case 5:
                case 7:
                case 8:
                case 10:
                case 12: return 31;
                case 4:
                case 6:
                case 9:
                case 11: return 30;
                default: return 28;
            }
        }

    }
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
    MYyear =  ((yearIndex % 4 == 0 && yearIndex% 100 != 0)|| yearIndex % 400 == 0);

    
    NSLog(@"选择的年份2222---%d-----%ld",MYyear);
    if (component == 0) {//当滑动年时,修改日
        yearIndex = row;
        if ((monthIndex+1 == 2) && MYyear) {//闰年2月为29天
                dayIndex = 28;
        }
        if ((monthIndex+1 == 2)&&MYyear) {//非闰年2月为28天
                dayIndex = 27;
        }
        //重新加载日
        [pickerView reloadComponent:2];
        //动画更新日
        [pickerView selectRow:dayIndex inComponent:2 animated:YES];
        //改下文字颜色
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
            label.textColor = RGBACOLOR(26, 174, 135, 1.0);
            label.font = [UIFont systemFontOfSize:16] ;
        });
    }else if (component == 1) {//月当滑动时,修改日
        monthIndex = row;
        if (monthIndex+1 == 4 || monthIndex+1 == 6 || monthIndex+1 == 9 || monthIndex+1 == 11) {//如果是46911月天数为30天
                dayIndex = 29;
        }else if (monthIndex+1 == 2) {//如果是2月天数是为28天
                dayIndex = 27;
        }else{//其他的都是31天
            dayIndex = 30;
        }
        //重新加载日
        [pickerView reloadComponent:2];
        //动画更新日
        [pickerView selectRow:dayIndex inComponent:2 animated:YES];
        //改下文字颜色
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
            label.textColor = RGBACOLOR(26, 174, 135, 1.0);
            label.font = [UIFont systemFontOfSize:16] ;
            label = (UILabel *)[pickerView viewForRow:dayIndex forComponent:2];
            label.textColor = RGBACOLOR(26, 174, 135, 1.0);
            label.font = [UIFont systemFontOfSize:16] ;
        });

    }else {//日滑动时
        dayIndex = row;
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
        genderLabel.text = self.yearArray[row];
    }else if (component == 1) {
        genderLabel.text = self.monthArray[row];
    }else {
        genderLabel.text = self.dayArray[row];
    }
    return genderLabel;
}
@end

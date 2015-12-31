//
//  LSTimePickerView.m
//  timeKey
//
//  Created by admin on 15/8/7.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSTimePickerView.h"

@implementation LSTimePickerView

+(instancetype)TimePickerView
{
    LSTimePickerView *timeView = [[LSTimePickerView alloc] initWithType:alertType_sheetAction];
    timeView.height_sheetAction = 168+ 40;
    [timeView addView];
    [timeView setttingData];
    return timeView;
}

-(void)setttingData
{
    firstTimeLoad = YES;
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    
    NSString *currentyearString = [NSString stringWithFormat:@"%@",
                                   [formatter stringFromDate:date]];
    // Get Current  Month
    [formatter setDateFormat:@"MM"];
    currentMonthString = [NSString stringWithFormat:@"%02ld",(long)[[formatter stringFromDate:date]integerValue]];

    // Get Current  Date
    [formatter setDateFormat:@"dd"];
    NSString *currentDateString = [NSString stringWithFormat:@"%02ld",(long)[[formatter stringFromDate:date] integerValue]];
    
    
    // Get Current  Hour
//    [formatter setDateFormat:@"hh"];
//    NSString *currentHourString = [NSString stringWithFormat:@"%02ld",(long)[[formatter stringFromDate:date] integerValue]];
//    
//    // Get Current  Minutes
//    [formatter setDateFormat:@"mm"];
//    NSString *currentMinutesString = [NSString stringWithFormat:@"%02ld",(long)[[formatter stringFromDate:date] integerValue]];
//    
//    // Get Current  AM PM
//    [formatter setDateFormat:@"a"];
//    NSString *currentTimeAMPMString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    
    // PickerView -  Years data
    yearArray = [[NSMutableArray alloc]init];
    for (int i = 1970; i <= 2050 ; i++)
    {
        [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
    }

    // PickerView -  Months data
    monthArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    
    // PickerView -  Hours data
    hoursArray = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    
    
    // PickerView -  Hours data
    minutesArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < 60; i++)
    {
        [minutesArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }

    // PickerView -  AM PM data
    amPmArray = @[@"上午",@"下午"];
    // PickerView -  days data
    DaysArray = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 31; i++)
    {
        [DaysArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
    
    
    // PickerView - Default Selection as per current Date
    [self.customPicker selectRow:[yearArray indexOfObject:currentyearString] inComponent:0 animated:YES];
    [self.customPicker selectRow:[monthArray indexOfObject:currentMonthString] inComponent:1 animated:YES];
    
    [self.customPicker selectRow:[DaysArray indexOfObject:currentDateString] inComponent:2 animated:YES];
//    
//    if ([currentHourString integerValue] > 12) {
//        currentHourString =  [NSString stringWithFormat:@"%02ld", [currentHourString integerValue]-12];
//    }
//    [self.customPicker selectRow:[hoursArray indexOfObject:currentHourString] inComponent:3 animated:YES];
//    
//    [self.customPicker selectRow:[minutesArray indexOfObject:currentMinutesString] inComponent:4 animated:YES];
//    
//    if ([currentTimeAMPMString isEqualToString:@"AM"]) {
//        [self.customPicker selectRow:0 inComponent:5 animated:YES];
//    }else
//    {
//       [self.customPicker selectRow:1 inComponent:5 animated:YES];
//    }
//   
    

}

-(void)addView
{
    self.customPicker = [[UIPickerView alloc] init];
    self.customPicker.frame = CGRectMake(0, 40, self.contentView.frame.size.width, 168);
    [self.contentView addSubview:self.customPicker];
     self.customPicker.delegate = self;
    self.customPicker.dataSource = self;
    self.toolView = [[UIView alloc] init];
    self.toolView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 40);
    self.toolView.backgroundColor = color_main;
    [self.contentView addSubview:self.toolView];
    
    
    CGFloat BtnW = 60;
    
    UIButton *cancleBtn =[[UIButton alloc] init];
    cancleBtn.frame = CGRectMake(0, 5, BtnW, 30);
    [cancleBtn addTarget:self action:@selector(toolAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.toolView addSubview:cancleBtn];
    
    UIButton *okBtn =[[UIButton alloc] init];
    okBtn.frame = CGRectMake(self.contentView.frame.size.width - BtnW , 5, BtnW, 30);
    [okBtn addTarget:self action:@selector(toolAction:) forControlEvents:UIControlEventTouchUpInside];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.toolView addSubview:okBtn];
    okBtn.tag = 42;
    cancleBtn.tag = 43;
    
}

-(void)toolAction:(UIButton *)btn
{
    
    if (btn.tag == 42) {
        [self cancle:^{
            //确定
          
            self.currentTime   =   [NSString stringWithFormat:@"%@-%@-%@",[yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]],[monthArray objectAtIndex:[self.customPicker selectedRowInComponent:1]],[DaysArray objectAtIndex:[self.customPicker selectedRowInComponent:2]]];
            
            if(self.okBlock)
            {
                self.okBlock(self);
            }
        
        }];
    }else
    {
        [self cancle:^{
            self.currentTime = nil;
        }];
    }

}



#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        selectedYearRow = row;
        [self.customPicker reloadAllComponents];
    }
    else if (component == 1)
    {
        selectedMonthRow = row;
        [self.customPicker reloadAllComponents];
    }
    else if (component == 2)
    {
        selectedDayRow = row;
        [self.customPicker reloadAllComponents];
        
    }
    
}


#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    // Custom View created for each component
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH/3, 60);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
 
    if (component == 0)
    {
        pickerLabel.text = [NSString stringWithFormat:@"%@年",[yearArray objectAtIndex:row]] ; // Year
    }
    else if (component == 1)
    {
        pickerLabel.text = [NSString stringWithFormat:@"%@月",[monthArray objectAtIndex:row]] ;  // Month
    }
    else if (component == 2)
    {
        pickerLabel.text =  [NSString stringWithFormat:@"%@日",[DaysArray objectAtIndex:row]]; // Date
    
    }
    else if (component == 3)
    {
        pickerLabel.text =  [hoursArray objectAtIndex:row]; // Hours
    }
    else if (component == 4)
    {
        pickerLabel.text =  [minutesArray objectAtIndex:row]; // Mins
    }
    else
    {
        pickerLabel.text =  [amPmArray objectAtIndex:row]; // AM/PM
    }
    
    return pickerLabel;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


// 选中某行某列
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        return [yearArray count];
        
    }
    else if (component == 1)
    {
       
        return [monthArray count];
    }
    else if (component == 2)
    { // day
        
        if (firstTimeLoad)
        {     
            
            if (currentMonth == 1 || currentMonth == 3 || currentMonth == 5 || currentMonth == 7 || currentMonth == 8 || currentMonth == 10 || currentMonth == 12)
            {
                return 31;
            }
            else if (currentMonth == 2)
            {
                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    
                    return 29;
                }
                else
                {
                     return 28; // or return 29
                }
            }
            else
            {
                return 30;
            }
        }
        else
        {
            
            if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
            {
                return 31;
            }
            else if (selectedMonthRow == 1)
            {
                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    return 29;
                }
                else
                {
                    return 28; // or return 29
                }
                
            }
            else
            {
                return 30;
            }
            
        }
        
        
    }
    else if (component == 3)
    { // hour
        
        return 12;
        
    }
    else if (component == 4)
    { // min
        return 60;
    }
    else
    { // am/pm
        return 2;
        
    }
    
    
}

@end

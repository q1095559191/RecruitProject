//
//  LSTimePickerView.h
//  timeKey
//
//  Created by admin on 15/8/7.
//  Copyright (c) 2015年 sliu. All rights reserved.
//

#import "LSCoustomAlert.h"
@class LSTimePickerView;
#define currentMonth [[monthArray objectAtIndex:selectedMonthRow]intValue]
@interface LSTimePickerView : LSCoustomAlert<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray    *yearArray;
    NSArray           *monthArray;
    NSMutableArray    *DaysArray;
    NSArray           *amPmArray;
    NSArray           *hoursArray;
    NSMutableArray    *minutesArray;
    NSString          *currentMonthString;
    
    NSInteger         selectedYearRow;
    NSInteger         selectedMonthRow;
    NSInteger         selectedDayRow;
    
    BOOL              firstTimeLoad;

}
typedef void(^OkBlock)(LSTimePickerView *);
+(instancetype)TimePickerView;

@property (strong   , nonatomic)  UIView             *toolView;
@property (strong   , nonatomic)  UIPickerView       *customPicker;
@property (copy     , nonatomic)  NSString           *currentTime;
@property (copy     , nonatomic)  NSString           *currentTimeStr;
@property (nonatomic, copy     )  OkBlock            okBlock;


@end

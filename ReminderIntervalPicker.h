//
//  ReminderIntervalPicker.h
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#define kDaysComponent 0
#define kHoursComponent 1
#define kMinutesComponent 2

#import <UIKit/UIKit.h>

@class Reminder;

@interface ReminderIntervalPicker : UIPickerView
<UIPickerViewDelegate, UIPickerViewDataSource>
{
	Reminder *reminder;
}

@property (nonatomic, retain) Reminder *reminder;

-(NSInteger)valueInSeconds;

-(int)selectedIntervalDayIndex;
-(int)selectedIntervalHourIndex;
-(int)selectedIntervalMinuteIndex;

@end

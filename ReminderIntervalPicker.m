//
//  ReminderIntervalPicker.m
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ReminderIntervalPicker.h"
#import "Medication.h"

@implementation ReminderIntervalPicker
@synthesize reminder;

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		
	}
	return self;
}

- (void)dealloc {
    [super dealloc];
}

- (NSInteger)valueInSeconds
{
	NSInteger dayRow = [self selectedRowInComponent:kDaysComponent];
	NSInteger hourRow = [self selectedRowInComponent:kHoursComponent];
	NSInteger minuteRow = [self selectedRowInComponent:kMinutesComponent];
	NSInteger daySeconds = dayRow * 24 * 60 * 60;
	NSInteger hourSeconds = hourRow * 60 * 60;
	NSInteger minuteSeconds = minuteRow * 5 * 60;
	
	NSLog(@"Day Minutes: %d, Hour Minutes: %d, Minute Minutes: %d", daySeconds, hourSeconds, minuteSeconds);
	
	if (daySeconds < 0)
		daySeconds = 0;
	if (hourSeconds < 0)
		hourSeconds = 0;
	if (minuteSeconds < 0)
		minuteSeconds = 0;
	
	return (daySeconds + hourSeconds + minuteSeconds);
}

#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
	if(component == kDaysComponent)
		return 366;
	else if(component == kHoursComponent)
		return 25;
	
	return 13;
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView 
						 titleForRow:(NSInteger)pickerRow 
						forComponent:(NSInteger)component 
{ 
	switch (component) {
		case kDaysComponent:
			return [NSString stringWithFormat:@"%d days", pickerRow];
			break;
		case kHoursComponent:
			return [NSString stringWithFormat:@"%d hours", pickerRow];
			break;
		default:
			return [NSString stringWithFormat:@"%d mins", pickerRow * 5];
			break;
	}
}


#pragma mark Selected Rows
-(int)selectedIntervalDayIndex
{
	return [reminder intervalDays];
}
-(int)selectedIntervalHourIndex
{
	return [reminder intervalHours];
}
-(int)selectedIntervalMinuteIndex
{
	return [reminder intervalMinutes] / 5;
}

@end

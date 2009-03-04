//
//  ReminderDetails.h
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Medication;
@class ReminderIntervalPicker;

@interface ReminderDetailsController : UIViewController
	<UITextFieldDelegate> {
		IBOutlet UITextField *name;
		IBOutlet ReminderIntervalPicker *intervalPicker;
		Medication *reminder;
}
@property (nonatomic, retain) Medication *reminder;
@property (nonatomic, retain) UITextField *name;
@property (nonatomic, retain) ReminderIntervalPicker *intervalPicker;

-(IBAction)save:(id)sender;

@end
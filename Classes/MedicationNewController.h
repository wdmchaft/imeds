//
//  ReminderNewController.h
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Medication;
@class ReminderIntervalPicker;

@interface MedicationNewController : UIViewController
	<UITextFieldDelegate> {
	IBOutlet UITextField *name;
	IBOutlet ReminderIntervalPicker *intervalPicker;
	Medication *reminder;
}

@property (nonatomic, retain) UITextField *name;
@property (nonatomic, retain) ReminderIntervalPicker *intervalPicker;
@property (nonatomic, retain) Medication *reminder;

-(IBAction)save:(id)sender;
-(IBAction)cancel:(id)sender;

@end

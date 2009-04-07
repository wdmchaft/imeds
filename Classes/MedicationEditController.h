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

@interface MedicationEditController : UIViewController
	<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {
		IBOutlet UITextField *nameField;
		IBOutlet ReminderIntervalPicker *intervalPicker;
		Medication *medication;
		NSMutableDictionary *tempValues;
}
@property (nonatomic, retain) Medication *medication;
@property (nonatomic, retain) UITextField *nameField;
@property (nonatomic, retain) ReminderIntervalPicker *intervalPicker;
@property (nonatomic, retain) NSMutableDictionary *tempValues;

-(IBAction)save:(id)sender;

@end
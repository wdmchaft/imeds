//
//  MedicationEditController.h
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#define kSectionName 0
#define kSectionInterval 1
#define kSectionTimesOfDay 2
#define kSectionMinimumTimeBetweenDoses 3

#import <UIKit/UIKit.h>

@class Medication;
@class IntervalPicker;

@interface MedicationEditController : UIViewController
	<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {
		IBOutlet UITextField *nameField;
		IBOutlet IntervalPicker *intervalPicker;
		Medication *medication;
		NSMutableDictionary *tempValues;
}
@property (nonatomic, retain) Medication *medication;
@property (nonatomic, retain) UITextField *nameField;
@property (nonatomic, retain) IntervalPicker *intervalPicker;
@property (nonatomic, retain) NSMutableDictionary *tempValues;

-(IBAction)save:(id)sender;

@end
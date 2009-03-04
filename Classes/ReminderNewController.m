//
//  ReminderNewController.m
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ReminderNewController.h"
#import "RegularReminderAppDelegate.h"
#import "RootViewController.h"
#import "Medication.h"
#import "ReminderIntervalPicker.h"

@implementation ReminderNewController
@synthesize name;
@synthesize intervalPicker;
@synthesize reminder;

-(IBAction)cancel:(id)sender
{
	RegularReminderAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navigationController popViewControllerAnimated:YES];
}
- (IBAction)save:(id)sender
{
	reminder.name = name.text;
	reminder.interval = [intervalPicker valueInSeconds];
	[reminder save];
	
	[reminder release];
	
	RegularReminderAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
	intervalPicker.delegate = intervalPicker;
	intervalPicker.dataSource = intervalPicker;
	name.clearsOnBeginEditing = NO;
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
																	 initWithTitle:@"Cancel"
																	 style:UIBarButtonItemStylePlain
																	 target:self
																	 action:@selector(cancel:)];
	
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
	
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
																 initWithTitle:@"Save"
																 style:UIBarButtonItemStyleDone
																 target:self
																 action:@selector(save:)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
	reminder = [[Medication alloc] init];
	intervalPicker.reminder = reminder;
	[super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[intervalPicker release];
	[reminder release];
  [super dealloc];
}

#pragma mark -
#pragma mark Text Field Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}


@end

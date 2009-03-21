//
//  ReminderDetails.m
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MedicationDetailsController.h"
#import "RegularReminderAppDelegate.h"
#import "Medication.h"
#import "ReminderIntervalPicker.h"
#import "MedicationSearchController.h"

@implementation MedicationDetailsController
@synthesize medication;
@synthesize nameField;
@synthesize intervalPicker;
@synthesize tempValues;

- (IBAction)save:(id)sender
{
	medication.name = nameField.text;
	medication.interval = [intervalPicker valueInSeconds];
	[medication save];
	
	RegularReminderAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
	intervalPicker.delegate = intervalPicker;
	intervalPicker.dataSource = intervalPicker;
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
																 initWithTitle:@"Save"
																 style:UIBarButtonItemStyleDone
																 target:self
																 action:@selector(save:)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
	
	// Setup textfield
	nameField.clearsOnBeginEditing = NO;
	
	[super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	self.title = medication.name;
	nameField.text = medication.name;
	
	intervalPicker.reminder = medication;
	[intervalPicker selectRow:[intervalPicker selectedIntervalDayIndex] inComponent:kDaysComponent animated:NO];
	[intervalPicker selectRow:[intervalPicker selectedIntervalHourIndex] inComponent:kHoursComponent animated:NO];
	[intervalPicker selectRow:[intervalPicker selectedIntervalMinuteIndex] inComponent:kMinutesComponent animated:NO];
	
	NSString *messageString = [[NSString alloc] initWithFormat:@"It's %@ baby!", medication.name];
	[messageString release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[self.title release];
	[self.nameField release];
	[super dealloc];
}

#pragma mark -
#pragma mark Text Field Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

#pragma mark -
#pragma mark Table Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}


// Right now there's only one row, so this should be ok...
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *MedicationCellIdentifier = @"MedicationCellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MedicationCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero 
																	 reuseIdentifier:MedicationCellIdentifier] autorelease];
		
		//Label
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 45, 25)];
		label.textAlignment = UITextAlignmentRight;
		label.font = [UIFont boldSystemFontOfSize:14];
		label.text = @"Name";
		[cell.contentView addSubview:label];
		[label release];
		
		//Name Field
		nameField = [[UITextField alloc] initWithFrame:CGRectMake(60, 12, 210, 25)];
		nameField.clearsOnBeginEditing = NO;
		[nameField setDelegate:self];
		nameField.returnKeyType = UIReturnKeyDone;
		[nameField addTarget:self 
									action:@selector(textFieldDone:) 
				forControlEvents:UIControlEventEditingDidEndOnExit];
		[cell.contentView addSubview:nameField];
		
		
		//Accessory Button
		UIButton * searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
		// button normal state
		[searchButton setFrame:CGRectMake(0, 0, 18, 19)];
		UIImage *buttonImageNormal = [UIImage imageNamed:@"searchicon.png"];
		[searchButton setBackgroundImage:buttonImageNormal forState:UIControlStateNormal];
		[searchButton addTarget:self action:@selector(showSearch) forControlEvents:UIControlEventTouchUpInside];
		
		[cell setAccessoryView: searchButton];
	}
	
	nameField.text = medication.name;
	
	return cell;
}

- (void)showSearch
{
	MedicationSearchController * medicationSearchController = [[MedicationSearchController alloc] initWithNibName:@"MedicationSearch" bundle:nil];
	medicationSearchController.medication = medication;
	RegularReminderAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navigationController pushViewController:medicationSearchController animated:YES];
}

#pragma mark -
#pragma mark Table Delegate Methods
- (NSIndexPath *)tableView:(UITableView *)tableView 
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	MedicationSearchController * childController = [[MedicationSearchController alloc] initWithNibName:@"MedicationSearch"
																																															bundle:nil];
	RegularReminderAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navigationController pushViewController:childController animated:YES];
	[childController release];
	return nil;
}


@end
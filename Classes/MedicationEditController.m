//
//  MedicationEditController.m
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MedicationEditController.h"
#import "RegularReminderAppDelegate.h"
#import "Medication.h"
#import "ReminderIntervalPicker.h"
#import "MedicationSearchController.h"

@implementation MedicationEditController
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
}


- (void)dealloc {
	[self.nameField release];
	[medication release];
	[intervalPicker release];
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
	switch (section) {
		case 0:
			return 1;
			break;
		default:
			return 7;
			break;
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if(section==1) {
		return @"Interval";
	} else if (section == 2) {
		return @"Times of Day";
	} else {
		return nil;
	}
}

// Cells
- (UITableViewCell *)nameFieldCell:(UITableView *)tableView {
	static NSString *MedicationCellIdentifier = @"MedicationCellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MedicationCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero 
																	 reuseIdentifier:MedicationCellIdentifier] autorelease];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		//Name Field
		nameField = [[UITextField alloc] initWithFrame:CGRectMake(11, 11, 259, 25)];
		nameField.clearsOnBeginEditing = NO;
		nameField.placeholder = @"Name";
		nameField.returnKeyType = UIReturnKeyDone;
		nameField.clearButtonMode = UITextFieldViewModeAlways;
		[nameField setDelegate:self];
		[nameField addTarget:self 
									action:@selector(textFieldDone:) 
				forControlEvents:UIControlEventEditingDidEndOnExit];
		[cell.contentView addSubview:nameField];
		
		
		//Accessory Button
		UIButton * searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
		// button normal state
		[searchButton setFrame:CGRectMake(0, 0, 18, 19)];
		UIImage *buttonImageNormal = [UIImage imageNamed:@"searchicon.png"];
		[searchButton setImage:buttonImageNormal forState:UIControlStateNormal];
		[searchButton setImage:buttonImageNormal forState:UIControlStateSelected];
		[searchButton addTarget:self action:@selector(showSearch) forControlEvents:UIControlEventTouchUpInside];
		
		[cell setAccessoryView: searchButton];
	}
	
	nameField.text = medication.name;
	
	return cell;
}

- (UITableViewCell *)intervalCell:(NSInteger)row tableView:(UITableView *)tableView {
	static NSString *IntervalCellIdentifier = @"IntervalCellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IntervalCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero 
																	 reuseIdentifier:IntervalCellIdentifier] autorelease];
	}
	switch(row) {
		case 0:
			cell.text = @"Every Day";
			break;
		case 1:
			cell.text = @"Every Other Day";
			break;
		case 2:
			cell.text = @"Once a Week";
			break;
		case 3:
			cell.text = @"Every Two Weeks";
			break;
		case 4:
			cell.text = @"Once a Month";
			break;
		case 5:
			cell.text = @"On Specified Days";
			break;
		case 6:
			cell.text = @"As Needed";
			break;
	}
	
	return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.section == 0)
		return [self nameFieldCell:tableView];
	else if(indexPath.section == 1) {
		return [self intervalCell:indexPath.row	tableView:tableView];
	}
}


- (void)showSearch
{
	MedicationSearchController * medicationSearchController = [[MedicationSearchController alloc] initWithNibName:@"MedicationSearch" bundle:nil];
	medicationSearchController.medication = medication;
	medicationSearchController.startingSearchText = nameField.text;
	
	RegularReminderAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navigationController pushViewController:medicationSearchController animated:YES];
	[medicationSearchController release];
}

#pragma mark -
#pragma mark Table Delegate Methods
- (NSIndexPath *)tableView:(UITableView *)tableView 
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self showSearch];
}


@end
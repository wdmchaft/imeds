//
//  RootViewController.m
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/14/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "RootViewController.h"
#import "RegularReminderAppDelegate.h"
#import "ReminderDetailsController.h"
#import "ReminderNewController.h"
#import "Medication.h"
#import "ReminderCell.h"


@implementation RootViewController
@synthesize medications;
@synthesize childController;

#pragma mark -
#pragma mark Database


// TODO is it really necessary to have tempReminders?
- (void)loadReminders {
	self.medications = [Medication allObjects];
}


#pragma mark -
#pragma mark standard
- (void)viewDidLoad {
	self.title = @"Reminders";
	
	// set up "new" button
	UIBarButtonItem *newButton = [[UIBarButtonItem alloc]
																	 initWithTitle:@"New"
																	 style:UIBarButtonItemStylePlain
																	 target:self
																	 action:@selector(new)];
	self.navigationItem.rightBarButtonItem = newButton;
	
	[super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated { 
	[self loadReminders];
	[self.tableView reloadData];
	[super viewWillAppear:animated]; 
} 


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)new {
	ReminderNewController *newController = [[ReminderNewController alloc] initWithNibName:@"ReminderNew"
																																								 bundle:nil];
	
	RegularReminderAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navigationController pushViewController:newController animated:YES];
}


#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;	
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [medications count];
}


// Customize the appearance of table view cells.
- (ReminderCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *ReminderCellIdentifier = @"ReminderCellIdentifier";

	ReminderCell *cell = [tableView dequeueReusableCellWithIdentifier:ReminderCellIdentifier];
	if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReminderCell" 
																								 owner:self options:nil]; 
		cell = [nib objectAtIndex:0]; 
	}
	
	Medication *medication = [self.medications objectAtIndex:[indexPath row]];
  cell.medication = medication;
  [cell setupLabels];
	cell.tag = [indexPath row];
	
	
	return cell;
}

#pragma mark Table View Delegate Methods
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView
				 accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellAccessoryDetailDisclosureButton;
}

- (void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath*)indexPath
{
	if (childController == nil)
	{
		childController = [[ReminderDetailsController alloc] initWithNibName:@"ReminderDetails"
																																	 bundle:nil];
	}
	NSUInteger row = [indexPath row];
	
	Medication *selectedReminder = [medications objectAtIndex:row];
	
	childController.reminder = selectedReminder;
	
	RegularReminderAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navigationController pushViewController:childController animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark Table Delegate Methods
- (NSIndexPath *)tableView:(UITableView *)tableView 
	willSelectRowAtIndexPath:(NSIndexPath *)indexPath { 
	return nil; 
} 

- (CGFloat) 
tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath 
{ 
	return kTableViewRowHeight; 
}


- (void)dealloc {
	[childController dealloc];
	[medications dealloc];
  [super dealloc];
}

@end
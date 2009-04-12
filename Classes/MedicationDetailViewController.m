//
//  MedicationDetailViewController.m
//  RegularReminder
//
//  Created by Daniel Higginbotham on 4/7/09.
//  Copyright 2009 flyingmachinestudios.com. All rights reserved.
//

#import "MedicationDetailViewController.h"
#import "MedicationEditController.h"
#import "Medication.h"
#import "RegularReminderAppDelegate.h"

@implementation MedicationDetailViewController

@synthesize medication, nameLabel, lastTakenExactLabel, lastTakenRelativeLabel, takeAgainExactLabel, takeAgainRelativeLabel;

#pragma mark Standard
-(void)viewDidLoad {
	nameLabel.font = [UIFont systemFontOfSize:30];
  
  UIBarButtonItem *editButton = [[UIBarButtonItem alloc] 
																 initWithTitle:@"Edit"
																 style:UIBarButtonItemStyleBordered
																 target:self 
																 action:@selector(edit)]; 
	self.navigationItem.rightBarButtonItem = editButton; 
  [editButton release];
  
  [super viewDidLoad];
}

-(void)setupLabels
{
	takeAgainExactLabel.text = [medication takeAgain];
	lastTakenRelativeLabel.text = [medication lastTakenString];
}

-(void)viewWillAppear:(BOOL)animated {
	nameLabel.text = medication.name;
	self.title = medication.name;
	[self setupLabels];
}

- (void)dealloc {
	[medication release];
	[nameLabel release];
	[lastTakenExactLabel release];
	[lastTakenRelativeLabel release];
	[takeAgainExactLabel release];
	[takeAgainRelativeLabel release];
  [super dealloc];
}

#pragma mark -
- (void) edit {
  MedicationEditController * controller = [[MedicationEditController alloc] initWithNibName:@"MedicationEdit" bundle:nil];
	controller.medication = medication;
	RegularReminderAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navigationController pushViewController:controller animated:YES];
	[controller release];
}


@end

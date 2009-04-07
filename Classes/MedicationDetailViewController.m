//
//  MedicationDetailViewController.m
//  RegularReminder
//
//  Created by Daniel Higginbotham on 4/7/09.
//  Copyright 2009 flyingmachinestudios.com. All rights reserved.
//

#import "MedicationDetailViewController.h"
#import "Medication.h"

@implementation MedicationDetailViewController

@synthesize medication, nameLabel, lastTakenExactLabel, lastTakenRelativeLabel, takeAgainExactLabel, takeAgainRelativeLabel;

#pragma mark Standard
-(void)viewDidLoad {
	nameLabel.font = [UIFont systemFontOfSize:30];
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


@end

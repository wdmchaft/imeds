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

@synthesize medication, name;

#pragma mark Standard
-(void)viewDidLoad {
	name.font = [UIFont systemFontOfSize:30];
}

-(void)viewWillAppear:(BOOL)animated {
	name.text = medication.name;
	self.title = medication.name;
}

- (void)dealloc {
	[medication release];
	[name release];
  [super dealloc];
}


@end

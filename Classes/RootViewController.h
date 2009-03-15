//
//  RootViewController.h
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/14/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#define kTableViewRowHeight 81;

#import <UIKit/UIKit.h>
#import "/usr/include/sqlite3.h"


@class MedicationDetailsController;

@interface RootViewController : UITableViewController {
	NSArray *medications;
	MedicationDetailsController *childController;
	NSTimer *refreshTimer;
}
@property (nonatomic, retain) NSArray *medications;
@property (nonatomic, retain) MedicationDetailsController *childController;

-(void)loadMedications;
-(void)refreshMedicationCells:(NSTimer *)theTimer;


@end
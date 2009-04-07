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


@class MedicationEditController;

@interface RootViewController : UITableViewController {
	NSArray *medications;
	MedicationEditController *childController;
	NSTimer *refreshTimer;
}
@property (nonatomic, retain) NSArray *medications;
@property (nonatomic, retain) MedicationEditController *childController;

-(void)loadMedications;
-(void)refreshMedicationCells:(NSTimer *)theTimer;


@end
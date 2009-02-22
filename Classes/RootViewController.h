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


@class ReminderDetailsController;

@interface RootViewController : UITableViewController {
	NSArray *reminders;
	ReminderDetailsController *childController;
}
@property (nonatomic, retain) NSArray *reminders;
@property (nonatomic, retain) ReminderDetailsController *childController;

-(void)loadReminders;


@end
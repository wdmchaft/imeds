//
//  Reminder.h
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#define kDaySeconds 86400
#define kTimeFormat @"h:mm a"

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"
@class MedicationLog;

@interface Medication : SQLitePersistentObject {
	NSString *name;	
	int interval;
}

@property (nonatomic, retain) NSString *name;
@property int interval;

-(int)intervalDays;
-(int)intervalHours;
-(int)intervalMinutes;

- (NSString *)takeAgain;
- (NSString *)lastTakenString;
- (NSDate *)takeAgainDate;
- (NSString *)takeAgainTimeString;
- (MedicationLog *)lastLog;
- (BOOL)overdue;


@end

//
//  Reminder.h
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#define kDaySeconds 86400
#define kDateFormat @"%I:%M %p"

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface Medication : SQLitePersistentObject {
	NSString *name;	
	int interval;
	NSDate *lastTaken;
}

@property (nonatomic, retain) NSString *name;
@property int interval;
@property (nonatomic, retain) NSDate *lastTaken;

-(int)intervalDays;
-(int)intervalHours;
-(int)intervalMinutes;

- (NSString *)takeAgain;
- (NSString *)lastTakenString;
- (NSCalendarDate *)takeAgainDate;
- (NSCalendarDate *)lastTakenCalendarDate;
- (BOOL)overdue;


@end

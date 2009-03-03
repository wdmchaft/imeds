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



@interface Reminder : SQLitePersistentObject {
	NSString *name;	
	int interval;
	NSDate *lastSet;
}

@property (nonatomic, retain) NSString *name;
@property int interval;
@property (nonatomic, retain) NSDate *lastSet;

-(int)intervalDays;
-(int)intervalHours;
-(int)intervalMinutes;

- (NSString *)takeAgain;
- (NSString *)lastTaken;
- (NSCalendarDate *)takeAgainDate;
- (NSCalendarDate *)lastSetCalendarDate;

@end

//
//  Reminder.m
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Medication.h"


@implementation Medication
@synthesize name, interval, lastSet, medicationLogs;

- (int)intervalDays
{
	return interval / (24 * 60 * 60);
}
- (int)intervalHours
{
	return (interval - ([self intervalDays] * 24 * 60 * 60)) / (60 * 60);
}
- (int)intervalMinutes
{
	return (interval - ([self intervalDays] * 24 * 60 * 60) - ([self intervalHours] * 60 * 60)) / 60;
}

- (NSString *)takeAgain
{	
	NSString *prefix;
	
	NSCalendarDate *takeAgainDate = [self takeAgainDate];
  NSDate *today = [NSDate date];
	
  NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]  autorelease];
  [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	
  NSString *takeAgainDateString = [dateFormatter stringFromDate:takeAgainDate];
  
	if ([takeAgainDateString isEqualToString:[dateFormatter stringFromDate:today]]) {
		prefix = @"Today";
	} else if ([takeAgainDateString isEqualToString:
              [dateFormatter stringFromDate:
               [today addTimeInterval:kDaySeconds]]]) {
		prefix = @"Tomorrow";
	} else {
    int dayDifference = [takeAgainDate timeIntervalSinceNow] / kDaySeconds;
    if(dayDifference > 0)
      prefix = [NSString stringWithFormat:@"In %d days", dayDifference];
    else
      prefix = [NSString stringWithFormat:@"%d days ago", (dayDifference * -1)];
	}
  
	
	return [NSString stringWithFormat:@"%@ @ %@", prefix, takeAgainDate];
}

- (NSString *)lastTaken
{	
  NSUInteger days, hours, minutes;
  NSMutableArray *timePieces = [NSMutableArray arrayWithCapacity:3];
  
	if(lastSet == nil)
	{
		return @"never";
	}
	
  NSTimeInterval timeSinceLastTaken = [[NSDate date] timeIntervalSinceDate:[self lastSet]];
  
  days = timeSinceLastTaken / 86400;
  timeSinceLastTaken -= days * 86400;
  if(days > 0)
    [timePieces addObject:[NSString stringWithFormat:@"%d days", days]];
  
  hours = timeSinceLastTaken / 3600;
  timeSinceLastTaken -= hours * 3600;
  if(hours > 0)
    [timePieces addObject:[NSString stringWithFormat:@"%d hrs", hours]];
  
  minutes = timeSinceLastTaken / 60;
  timeSinceLastTaken -= minutes * 60;
  if(minutes > 0)
    [timePieces addObject:[NSString stringWithFormat:@"%d mins", minutes]];
  
  if([timePieces count] == 0)
    [timePieces addObject:[NSString stringWithString:@"less than a minute"]];
  
  return [NSString stringWithFormat:@"%@ ago", [timePieces componentsJoinedByString:@", "]];
  
//	return [NSString stringWithFormat:@"%@", [self lastSetCalendarDate]];
}
                                     
- (NSCalendarDate *)lastSetCalendarDate
{
  return [lastSet dateWithCalendarFormat:kDateFormat timeZone:[NSTimeZone localTimeZone]];
}

- (BOOL)overdue
{
  NSDate *now = [NSDate date];
  if([now compare:[self takeAgainDate]] == NSOrderedDescending)
    return YES;
  else
    return NO;
}

-(void)dealloc
{
	[name release];
	[lastSet release];
	[super dealloc];
}

- (NSCalendarDate *)takeAgainDate
{
	NSCalendarDate *lastSetDate;
	
	if(lastSet == nil) {
		lastSetDate = [NSCalendarDate date];
	} else {
		lastSetDate = [self lastSetCalendarDate];
	}
	
	NSCalendarDate *nextTime = [lastSetDate addTimeInterval:interval];
	[nextTime setCalendarFormat:kDateFormat];	
	return nextTime;
}

@end

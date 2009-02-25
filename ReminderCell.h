//
//  ReminderCell.h
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#define kMinimumGestureLength       25 
#define kMaximumVariance            5 

#import <UIKit/UIKit.h>
@class Reminder;

@interface ReminderCell : UITableViewCell {
	Reminder *reminder;
	IBOutlet UILabel *nameLabel;
	IBOutlet UILabel *nextLabel;
	IBOutlet UILabel *lastLabel;
	
	CGPoint gestureStartPoint;
	
	BOOL cellSelected;
}

@property (nonatomic, retain) Reminder *reminder;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *nextLabel;
@property (nonatomic, retain) IBOutlet UILabel *lastLabel;

@property CGPoint gestureStartPoint;

-(void)setReminderTimeToNow;

@end

//
//  ReminderCell.m
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ReminderCell.h"
#import "Reminder.h"

@implementation ReminderCell

@synthesize reminder;
@synthesize nameLabel;
@synthesize nextLabel;
@synthesize lastLabel;

@synthesize gestureStartPoint;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


#pragma mark - 
#pragma mark Gestures
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject]; 
	gestureStartPoint = [touch locationInView:self];	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event { 
	UIAlertView *alert = [[UIAlertView alloc] 
												initWithTitle:@"Time reset!"
												message:@"blarg blarg blarg"
												delegate:nil 
												cancelButtonTitle:@"Yep, I did." 
												otherButtonTitles:nil]; 
	[alert show]; 
	[alert release];
	
	UITouch *touch = [touches anyObject]; 
	CGPoint currentPosition = [touch locationInView:self]; 
	CGFloat deltaX = fabsf(gestureStartPoint.x - currentPosition.x); 
	CGFloat deltaY = fabsf(gestureStartPoint.y - currentPosition.y); 
	if (deltaX >= kMinimumGestureLength && deltaY <= kMaximumVariance) {
		UIAlertView *alert = [[UIAlertView alloc] 
													initWithTitle:@"Time reset!"
													message:@"blarg blarg blarg"
													delegate:nil 
													cancelButtonTitle:@"Yep, I did." 
													otherButtonTitles:nil]; 
		[alert show]; 
		[alert release];
		
		[self performSelector:@selector(setReminderTimeToNow)
							 withObject:self afterDelay:2]; 
	} 
}


#pragma mark data manipulation
-(void)setReminderTimeToNow
{ 
	UIAlertView *alert = [[UIAlertView alloc] 
												initWithTitle:@"Time reset!"
												message:@"blarg blarg blarg"
												delegate:nil 
												cancelButtonTitle:@"Yep, I did." 
												otherButtonTitles:nil]; 
	[alert show]; 
	[alert release];
//	reminder.lastSet = [NSDate date];
//	reminder.save;
}


@end

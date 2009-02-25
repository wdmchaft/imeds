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
			cellSelected = NO;
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
	if(cellSelected == NO) {
		cellSelected = YES;
		
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		// button normal state
		[button setTitle:@"Set" forState:UIControlStateNormal];
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		
		UIFont *buttonFont = [UIFont boldSystemFontOfSize:12];
		[button setFont:buttonFont];
		
		
		[button setFrame:CGRectMake(0, 0, 50, 30)];
		UIImage *buttonImageNormal = [UIImage imageNamed:@"blueButton.png"];
		UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
		[button setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
		
		[self setAccessoryView:button];
	}
	else {
		cellSelected = NO;
		[self setAccessoryView:nil];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

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

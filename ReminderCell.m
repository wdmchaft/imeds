//
//  ReminderCell.m
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ReminderCell.h"
#import "Reminder.h"

@implementation ReminderCell

@synthesize reminder;
@synthesize nameLabel;
@synthesize nextLabel;
@synthesize lastLabel;
@synthesize transitioning;

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
    
    [self replaceSubview:self.accessoryView
             withSubview:button
              transition:kCATransitionReveal
               direction:kCATransitionFromLeft
                duration:1];
	}
	else {
		cellSelected = NO;
		[self setAccessoryView:nil];
	}
}

// Method to replace a given subview with another using a specified transition type, direction, and duration
- (void)replaceSubview:(UIView *)oldView
           withSubview:(UIView *)newView
            transition:(NSString *)transition
             direction:(NSString *)direction
              duration:(NSTimeInterval)duration {
	
	// If a transition is in progress, do nothing
	if(transitioning) {
		return;
	}
	
	NSArray *subViews = [self subviews];
	NSUInteger index;
	
	if ([oldView superview] == self) {
		// Find the index of oldView so that we can insert newView at the same place
		for(index = 0; [subViews objectAtIndex:index] != oldView; ++index) {}
		[oldView removeFromSuperview];
	}
	
	// If there's a new view and it doesn't already have a superview, insert it where the old view was
	if (newView && ([newView superview] == nil))
		[self insertSubview:newView atIndex:index];
	
	
	// Set up the animation
	CATransition *animation = [CATransition animation];
	[animation setDelegate:self];
	
	// Set the type and if appropriate direction of the transition, 
	if (transition == kCATransitionFade) {
		[animation setType:kCATransitionFade];
	} else {
		[animation setType:transition];
		[animation setSubtype:direction];
	}
	
	// Set the duration and timing function of the transtion -- duration is passed in as a parameter, use ease in/ease out as the timing function
	[animation setDuration:duration];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[self layer] addAnimation:animation forKey:kAnimationKey];
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

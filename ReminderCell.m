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
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
  [super dealloc];
  [medTakenButton dealloc];
}


#pragma mark - 
#pragma mark Gestures
- (UIButton *) medTakenButton {
  NSLog(@"medTakenButton class:", [medTakenButton className]);
  if(medTakenButton != nil)
  {
    return medTakenButton;
  }
  medTakenButton = [UIButton buttonWithType:UIButtonTypeCustom];
  // button normal state
  [medTakenButton setTitle:@"Set" forState:UIControlStateNormal];
  [medTakenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  
  UIFont *buttonFont = [UIFont boldSystemFontOfSize:12];
  [medTakenButton setFont:buttonFont];
  
  
  [medTakenButton setFrame:CGRectMake(0, 0, 50, 40)];
  UIImage *buttonImageNormal = [UIImage imageNamed:@"blueButton.png"];
  UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
  [medTakenButton setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
  [medTakenButton retain];
  return medTakenButton;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if(cellSelected == NO) {
		cellSelected = YES;
    [self setAccessoryView:[self medTakenButton]];
	}
	else {
		cellSelected = NO;
		[self setAccessoryView:nil];
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

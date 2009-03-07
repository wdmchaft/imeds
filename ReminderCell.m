//
//  ReminderCell.m
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ReminderCell.h"
#import "Medication.h"
#import "MedicationLog.h"

@implementation ReminderCell

@synthesize medication;
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
  if(medTakenButton != nil)
  {
    return medTakenButton;
  }
  medTakenButton = [UIButton buttonWithType:UIButtonTypeCustom];
  // button normal state
  [medTakenButton setTitle:@"Take" forState:UIControlStateNormal];
  [medTakenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  
  UIFont *buttonFont = [UIFont boldSystemFontOfSize:12];
  [medTakenButton setFont:buttonFont];
  
  
  [medTakenButton setFrame:CGRectMake(0, 0, 50, 40)];
  UIImage *buttonImageNormal = [UIImage imageNamed:@"blueButton.png"];
  UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
  [medTakenButton setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
  [medTakenButton retain];
  [medTakenButton addTarget:self action:@selector(medTaken) forControlEvents:UIControlEventTouchUpInside];
  return medTakenButton;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if(cellSelected == NO) {
		cellSelected = YES;
    
    [self setAccessoryView:[self medTakenButton]];
    [UIView beginAnimations:nil context:nil];
    [self medTakenButton].alpha = 0;
    [self medTakenButton].alpha = 100;
    [UIView commitAnimations];
	}
	else {
    [self hideMedTakenButton];
	}
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
  cellSelected = NO;
  [self setAccessoryView:nil];
}

- (void)hideMedTakenButton
{
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDelegate: self];
  [self medTakenButton].alpha = 0;
  [UIView commitAnimations];
}


#pragma mark data manipulation
-(void)medTaken
{ 
  NSLog(@"Set");
  NSDate *now = [NSDate date];
	medication.lastTaken = now;
  NSLog(@"Date: %@",  medication.lastTaken);
  NSLog(@"More Date: %@", [NSDate date]);
  NSLog(@"More Date: %@", now);
	medication.save;
  
  MedicationLog *medicationLog = [[MedicationLog alloc] init];
  medicationLog.medication = medication;
  medicationLog.createdAt = [NSDate date];
  [medicationLog save];
  [medicationLog release];
  
  [self setupLabels];
  [self hideMedTakenButton];
}

#pragma mark Labels
-(void)setupLabels
{
  nameLabel.text = medication.name;
	nextLabel.text = [medication takeAgain];
	lastLabel.text = [medication lastTakenString];
  
  if([medication overdue])
    nextLabel.textColor = [UIColor redColor];
  else
    nextLabel.textColor = [UIColor blackColor];
}

@end

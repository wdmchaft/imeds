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

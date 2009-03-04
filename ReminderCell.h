//
//  ReminderCell.h
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#define kMinimumGestureLength       25 
#define kMaximumVariance            5 
#define kAnimationKey @"transitionViewAnimation"

#import <UIKit/UIKit.h>
@class Medication;

@interface ReminderCell : UITableViewCell {
	Medication *medication;
	IBOutlet UILabel *nameLabel;
	IBOutlet UILabel *nextLabel;
	IBOutlet UILabel *lastLabel;
	
	BOOL cellSelected;
  
  UIButton *medTakenButton;
  UIButton *detailDisclosureButton;
  
@private
	BOOL transitioning;
}

@property (nonatomic, retain) Medication *medication;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *nextLabel;
@property (nonatomic, retain) IBOutlet UILabel *lastLabel;

@property (readonly, getter=isTransitioning) BOOL transitioning;

-(void)medTaken;
-(void)hideMedTakenButton;
-(void)setupLabels;
-(UIButton *)medTakenButton;
@end

//
//  MedicationDetailViewController.h
//  RegularReminder
//
//  Created by Daniel Higginbotham on 4/7/09.
//  Copyright 2009 flyingmachinestudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Medication;

@interface MedicationDetailViewController : UIViewController {
	Medication * medication;
	UILabel * nameLabel;
	UILabel * lastTakenExactLabel;
	UILabel * lastTakenRelativeLabel;
	UILabel * takeAgainExactLabel;
	UILabel * takeAgainRelativeLabel;
}

@property (nonatomic, retain) Medication *medication;
@property (nonatomic, retain) IBOutlet UILabel * nameLabel;
@property (nonatomic, retain) IBOutlet UILabel * lastTakenExactLabel;
@property (nonatomic, retain) IBOutlet UILabel * lastTakenRelativeLabel;
@property (nonatomic, retain) IBOutlet UILabel * takeAgainExactLabel;
@property (nonatomic, retain) IBOutlet UILabel * takeAgainRelativeLabel;

@end

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
	Medication *medication;
}

@property (nonatomic, retain) Medication *medication;

@end

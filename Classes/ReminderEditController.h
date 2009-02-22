//
//  ReminderEditController.h
//  RegularReminder
//
//  Created by Daniel Higginbotham on 2/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ReminderEditController : UIViewController {
	NSMutableDictionary *reminder;
}
@property (nonatomic, retain) NSMutableDictionary *reminder;

@end

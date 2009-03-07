//
//  MedicationLog.h
//  RegularReminder
//
//  Created by Daniel Higginbotham on 3/6/09.
//  Copyright 2009 flyingmachinestudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@class Medication;

@interface MedicationLog : SQLitePersistentObject {
  Medication *medication;
  NSDate *createdAt;
}

@property (nonatomic,readwrite,retain) NSDate *createdAt;
@property (nonatomic,readwrite,retain) Medication *medication;

@end

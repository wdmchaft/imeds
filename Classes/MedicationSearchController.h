//
//  MedicationSearchController.h
//  RegularReminder
//
//  Created by Daniel Higginbotham on 3/21/09.
//  Copyright 2009 flyingmachinestudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Medication;

@interface MedicationSearchController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
	IBOutlet    UITableView *tableView;
	IBOutlet    UISearchBar *searchView; 
	NSDictionary *allMedicationNames; 
	NSMutableDictionary *activeMedicationNames; 
	NSMutableArray  *medicationKeys;
	Medication * medication;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UISearchBar *searchView; 
@property (nonatomic, retain) NSDictionary *allMedicationNames;
@property (nonatomic, retain) NSMutableDictionary *activeMedicationNames;
@property (nonatomic, retain) NSMutableArray *medicationKeys;
@property (nonatomic, retain) Medication *medication;

- (void)resetSearch; 
- (void)handleSearchForTerm:(NSString *)searchTerm; 

@end

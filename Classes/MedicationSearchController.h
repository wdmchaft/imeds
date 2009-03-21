//
//  MedicationSearchController.h
//  RegularReminder
//
//  Created by Daniel Higginbotham on 3/21/09.
//  Copyright 2009 flyingmachinestudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MedicationSearchController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
	IBOutlet    UITableView *tableView;
	IBOutlet    UISearchBar *searchView; 
	NSDictionary *allMedicationNames; 
	NSMutableDictionary *activeMedicationNames; 
	NSMutableArray  *medicationKeys;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UISearchBar *searchView; 
@property (nonatomic, retain) NSDictionary *allMedicationNames;
@property (nonatomic, retain) NSMutableDictionary *activeMedicationNames;
@property (nonatomic, retain) NSMutableArray *medicationKeys;

- (void)resetSearch; 
- (void)handleSearchForTerm:(NSString *)searchTerm; 

@end

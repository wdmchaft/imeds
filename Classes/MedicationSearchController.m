//
//  MedicationSearchController.m
//  RegularReminder
//
//  Created by Daniel Higginbotham on 3/21/09.
//  Copyright 2009 flyingmachinestudios.com. All rights reserved.
//

#import "MedicationSearchController.h"
#import "MedicationEditController.h"
#import "Medication.h"
#import "NSDictionary-MutableDeepCopy.h"
#import "RegularReminderAppDelegate.h"

@implementation MedicationSearchController
@synthesize tableView, searchView, startingSearchText, allMedicationNames, activeMedicationNames, medicationKeys, medication;

- (void)resetSearch 
{ 
	self.activeMedicationNames = [self.allMedicationNames mutableDeepCopy];		
	NSMutableArray *keyArray = [[NSMutableArray alloc] init]; 
	[keyArray addObjectsFromArray:[[self.allMedicationNames allKeys] 
																 sortedArrayUsingSelector:@selector(compare:)]]; 
	self.medicationKeys = keyArray;
	[keyArray release]; 
} 

- (void)handleSearchForTerm:(NSString *)searchTerm 
{ 
	NSMutableArray *sectionsToRemove = [[NSMutableArray alloc] init]; 
	[self resetSearch]; 
	for (NSString *key in self.medicationKeys) { 
		NSMutableArray *array = [activeMedicationNames valueForKey:key]; 
		NSMutableArray *toRemove = [[NSMutableArray alloc] init]; 
		for (NSString *name in array) { 
			if ([name rangeOfString:searchTerm 
											options:NSCaseInsensitiveSearch].location != 0) 
				[toRemove addObject:name]; 
		} 
		if ([array count] == [toRemove count])
			[sectionsToRemove addObject:key];
		[array removeObjectsInArray:toRemove]; 
		[toRemove release]; 
	} 
	[self.medicationKeys removeObjectsInArray:sectionsToRemove]; 
	[sectionsToRemove release]; 
	[tableView reloadData]; 
} 

#pragma mark - 
#pragma mark UIViewController Methods 
- (void)viewDidLoad { 
	NSString *path = [[NSBundle mainBundle] pathForResource:@"medications" 
																									 ofType:@"plist"]; 
	NSDictionary *dict = [[NSDictionary alloc] 
												initWithContentsOfFile:path]; 
	self.allMedicationNames = dict; 
	[dict release]; 
	
	self.title = @"Search Medications";
	
	searchView.autocapitalizationType = UITextAutocapitalizationTypeNone; 
	searchView.autocorrectionType = UITextAutocorrectionTypeNo;
} 

- (void)viewWillAppear:(BOOL)animated {
	[self resetSearch];
	
	if(self.startingSearchText != nil && [self.startingSearchText length] > 0) {
		self.searchView.text = self.startingSearchText;
		[self handleSearchForTerm:searchView.text];
		[self.searchView becomeFirstResponder];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation: 
(UIInterfaceOrientation)interfaceOrientation { 
	// Return YES for supported orientations 
	return (interfaceOrientation == UIInterfaceOrientationPortrait); 
} 

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[tableView release];
	[searchView release];
	[allMedicationNames release];
	[activeMedicationNames release];
	[medicationKeys release];
	[medication release];
	[super dealloc];
}

#pragma mark - 
#pragma mark Table View Data Source Methods 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{ 
	return ([medicationKeys count] > 0) ? [medicationKeys count] : 1; 
} 

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section 
{ 
	if ([medicationKeys count] == 0) 
		return 0; 
	NSString *key = [medicationKeys objectAtIndex:section]; 
	NSArray *nameSection = [activeMedicationNames objectForKey:key]; 
	return [nameSection count]; 
} 

- (UITableViewCell *)tableView:(UITableView *)aTableView 
				 cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
	NSUInteger section = [indexPath section]; 
	NSUInteger row = [indexPath row]; 
	NSString *key = [medicationKeys objectAtIndex:section]; 
	NSArray *nameSection = [activeMedicationNames objectForKey:key]; 
	static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier"; 
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier: 
													 SectionsTableIdentifier ]; 
	if (cell == nil) { 
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero 
																	 reuseIdentifier: SectionsTableIdentifier ] autorelease]; 
	} 
	cell.text = [nameSection objectAtIndex:row]; 
	return cell; 
}

- (NSString *)tableView:(UITableView *)tableView 
titleForHeaderInSection:(NSInteger)section 
{ 
	if ([medicationKeys count] == 0)
		return @"";
	NSString *key = [medicationKeys objectAtIndex:section]; 
	return key; 
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView 
{ 
	return medicationKeys; 
} 

#pragma mark - 
#pragma mark Table View Delegate Methods 
- (NSIndexPath *)tableView:(UITableView *)tableView
	willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[searchView resignFirstResponder];
	return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSUInteger section = [indexPath section]; 
	NSUInteger row = [indexPath row]; 
	NSString *key = [medicationKeys objectAtIndex:section]; 
	NSArray *nameSection = [activeMedicationNames objectForKey:key]; 
	NSString * medicationName = [nameSection objectAtIndex:row]; 
	medication.name = medicationName;
	self.parentViewController.title = medicationName;
	
	RegularReminderAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 
#pragma mark Search Bar Delegate Methods 

// Live search
- (void)searchBar:(UISearchBar *)searchBar 
    textDidChange:(NSString *)searchTerm 
{ 
	if ([searchTerm length] == 0) 
	{ 
		[self resetSearch]; 
		[tableView reloadData]; 
		return; 
	} 
	[self handleSearchForTerm:searchTerm]; 
} 

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	NSString *searchTerm = [searchBar text];
	[self handleSearchForTerm:searchTerm];
	[searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	searchView.text = @"";
	[self resetSearch];
	[tableView reloadData];
	[searchBar resignFirstResponder];
}

@end

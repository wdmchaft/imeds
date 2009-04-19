//
//  CellFactory.m
//  RegularReminder
//
//  Created by Daniel Higginbotham on 4/19/09.
//  Copyright 2009 flyingmachinestudios.com. All rights reserved.
//

#import "CellFactory.h"


@implementation CellFactory
+ (UITableViewCell *)cellWithIdentifier: (NSString *)identifier tableView:(UITableView *)tableView{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero 
																	 reuseIdentifier:identifier] autorelease];
	}
	return cell;
}

@end

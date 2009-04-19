//
//  CellFactory.h
//  RegularReminder
//
//  Created by Daniel Higginbotham on 4/19/09.
//  Copyright 2009 flyingmachinestudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CellFactory : NSObject {

}

+ (UITableViewCell *)cellWithIdentifier: (NSString *)identifier tableView:(UITableView *)tableView;

@end

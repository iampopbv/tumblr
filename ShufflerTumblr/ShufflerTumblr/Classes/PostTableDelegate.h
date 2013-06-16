//
//  PostTableDelegate.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 13-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Protocol for UIViewControllers that implement the UITableViewDelegate and the UITableViewDataSource.
 *  It is used for displaying data in a table view.
 */

@protocol PostTableDelegate <NSObject, UITableViewDelegate, UITableViewDataSource>

// the chosen row in the 
@property int chosenRow;

// The data in the table
// The text in the table
@property NSMutableArray *tableText;
// The image in the table
@property NSMutableArray *tableimages;
// The data of the object that should be shown in the table
@property NSMutableArray *tableObjects;

@end

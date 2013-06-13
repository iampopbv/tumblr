//
//  PostTableDelegate.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 13-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PostTableDelegate <NSObject, UITableViewDelegate, UITableViewDataSource>

@property int chosenRow;

// the data
@property NSMutableArray *tabledata;
@property NSMutableArray *tableimages;
@property NSMutableArray *blogdata;
@property NSMutableArray *tableObjects;

@end

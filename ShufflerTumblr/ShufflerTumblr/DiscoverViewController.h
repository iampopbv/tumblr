//
//  DiscoverViewController.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 10-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostTableDelegate.h"

/**
 * Displays featured blogs for the user to explore and subscribe to.
 */
@interface DiscoverViewController : UIViewController <PostTableDelegate>

/** UI Components **/
// The tableview where the posts should be placed in.
@property (weak, nonatomic) IBOutlet UITableView *tableView;
// The label at the top
@property (weak, nonatomic) IBOutlet UILabel *topMessageLabel;


@end

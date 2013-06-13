//
//  DiscoverViewController.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 10-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostTableDelegate.h"

@interface DiscoverViewController : UIViewController <PostTableDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *topMessageLabel;


@end

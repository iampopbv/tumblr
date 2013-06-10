//
//  DiscoverViewController.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 10-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property NSMutableArray *blogs;

@property int chosenBlog;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *topMessageLabel;

// the data
@property NSMutableArray *tabledata;
@property NSMutableArray *tableimages;
@property NSMutableArray *blogdata;

@end

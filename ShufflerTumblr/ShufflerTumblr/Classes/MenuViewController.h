//
//  MenuViewController.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 11-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "BlogInfo.h"
#import "Blog.h"


/**
 * The begin page. Here we show some featured blogs and we provide a link to login.
 */
@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

// Checks if the Internet is available
@property Reachability *internetReachableChecker;
// True when there is Internet available
@property BOOL hasInternet;

// The featured blogs
@property NSMutableArray *blogs;
// The selected blog in the tableview
@property int chosenBlog;
@property UIStoryboardSegue *mainSegue;

// The data holder for the tabledata
@property NSMutableArray *tabledata;
@property NSMutableArray *tableimages;
@property NSMutableArray *blogdata;

/** UI Components **/
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *signupbutton;
@property (weak, nonatomic) IBOutlet UILabel *listento;
@property (weak, nonatomic) IBOutlet UIButton *signinButton;

- (IBAction)signInButtonPressed:(id)sender;
@end

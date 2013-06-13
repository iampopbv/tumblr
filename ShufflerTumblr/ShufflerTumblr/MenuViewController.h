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
#import "bloggetter.h"

@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property Reachability *internetReachableChecker;
@property BOOL hasInternet;

@property NSMutableArray *blogs;
@property int chosenBlog;
@property UIStoryboardSegue *mainSegue;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *signupbutton;
@property (weak, nonatomic) IBOutlet UILabel *listento;

@property NSMutableArray *tabledata;
@property NSMutableArray *tableimages;
@property NSMutableArray *blogdata;
@property (weak, nonatomic) IBOutlet UIButton *signinButton;

- (IBAction)signInButtonPressed:(id)sender;
@end
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

@property Blog *blog1;
@property Blog *blog2;
@property Blog *blog3;
@property Blog *blog4;
@property Blog *blog5;
@property Blog *segueBlog;
@property UIStoryboardSegue *mainSegue;


@property (weak, nonatomic) IBOutlet UILabel *blog1Title;
@property (weak, nonatomic) IBOutlet UILabel *blog2Title;
@property (weak, nonatomic) IBOutlet UILabel *blog3Title;
@property (weak, nonatomic) IBOutlet UILabel *blog4Title;
@property (weak, nonatomic) IBOutlet UILabel *blog5Title;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UIImageView *imageBlog1;
@property (weak, nonatomic) IBOutlet UIImageView *imageBlog2;
@property (weak, nonatomic) IBOutlet UIImageView *imageBlog3;
@property (weak, nonatomic) IBOutlet UIImageView *imageBlog4;
@property (weak, nonatomic) IBOutlet UIImageView *imageBlog5;
@property (weak, nonatomic) IBOutlet UINavigationItem *Shumblr;
@property (weak, nonatomic) IBOutlet UIButton *signupbutton;
@property (weak, nonatomic) IBOutlet UILabel *listento;

@property NSMutableArray *tabledata;
@property NSMutableArray *tableimages;
@property NSMutableArray *blogdata;
@end
//
//  DashBoardViewController.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 26-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface DashBoardViewController : UIViewController

@property NSMutableArray<Post> *posts;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *headLabel;

@property int chosenPost;

// the data
@property NSMutableArray *tabledata;
@property NSMutableArray *tableimages;
@property NSMutableArray *blogdata;


@end

//
//  DashBoardViewController.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 26-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "LazyLoader.h"
#import "PostTableDelegate.h"

/**
 * Displays the audio and video posts of the dashboard of the logged in user.
 */
@interface DashBoardViewController : UIViewController <PostTableDelegate, LazyLoader>

/** UI Components **/
// The tableview where the posts should be placed in.
@property (weak, nonatomic) IBOutlet UITableView *tableview;
// The label at the top
@property (weak, nonatomic) IBOutlet UILabel *headLabel;

@end

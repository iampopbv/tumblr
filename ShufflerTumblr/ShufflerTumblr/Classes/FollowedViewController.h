//
//  FollowedViewController.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 26-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Blog.h"
#import "PostTableDelegate.h"

/**
 * Displays the followed blogs of the logged in user.
 */
@interface FollowedViewController : UIViewController <PostTableDelegate>

/** UI Components **/
// The tableview where the posts should be placed in.
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

//
//  MyBlogsViewController.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 26-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Info.h"
#import "PostTableDelegate.h"


/**
 * Displays the blogs of the logged in user.
 */
@interface MyBlogsViewController : UIViewController <PostTableDelegate>

/** UI Components **/
// The tableview where the posts should be placed in.
@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end

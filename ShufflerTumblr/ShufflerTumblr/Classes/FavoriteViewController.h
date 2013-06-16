//
//  FavoriteViewController.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 26-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "Favourites.h"
#import "TMAPIClient.h"
#import "Video.h"
#import "Audio.h"
#import "PostTableDelegate.h"

/**
 * Displays the favorite blogs of the logged in user.
 */

@interface FavoriteViewController : UIViewController <PostTableDelegate>

/** UI Components **/
// The label at the top
@property (weak, nonatomic) IBOutlet UILabel *textfavorite;
// The tableview where the posts should be placed in.
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

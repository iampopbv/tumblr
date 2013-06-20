//
//  BlogPlaylistViewController.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 20-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostTableDelegate.h"
#import "LazyLoader.h"
#import "Blog.h"

@interface BlogPlaylistViewController : UIViewController <PostTableDelegate, LazyLoader>

// The table view
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic) Blog *blog;


@end

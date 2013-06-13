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


@interface FavoriteViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property NSMutableArray *favouriteData;
@property int chosenPost;

@end

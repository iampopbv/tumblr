//
//  SinglePostViewController.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 13-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "PostView.h"
#import "Favourites.h"

/**
 * Resposible for displaying a single post
 */
@interface SinglePostViewController : UIViewController

// The post to display
@property id<Post> post;


/** UI Components **/
// The PostView
@property (weak, nonatomic) IBOutlet PostView *postView;


// Creates a pop-up
- (IBAction)sharebuttonpressed:(id)sender;


@end

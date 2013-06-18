//
//  SinglePostViewController.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 13-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "Favourites.h"

/**
 * Resposible for displaying a single post
 */
@interface SinglePostViewController : UIViewController

// The post to display
@property (nonatomic) id<Post> post;


/** UI Components **/
// The PostView
@property UIView *postView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *videoView;
@property (weak, nonatomic) IBOutlet UITextView *captionView;

// Creates a pop-up
- (IBAction)sharebuttonpressed:(id)sender;


@end

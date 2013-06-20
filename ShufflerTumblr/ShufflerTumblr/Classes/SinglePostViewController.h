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
#import "PlayerView.h"

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
@property (weak, nonatomic) IBOutlet PlayerView *videoView;
@property (weak, nonatomic) IBOutlet UITextView *captionView;
- (IBAction)pauseButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;

@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;

// Creates a pop-up
- (IBAction)sharebuttonpressed:(id)sender;
- (IBAction)followButtonPressed:(id)sender;
- (IBAction)favoriteButtonPressed:(id)sender;

- (void)loadPreviousPost:(id)sender;
- (void)loadNewPost:(id)sender;

@end

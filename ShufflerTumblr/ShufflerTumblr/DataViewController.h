//
//  DataViewController.h
//  PageBasedAppTest
//
//  Created by Casper Eekhof on 05-05-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MediaPlayer/MediaPlayer.h"
#import "Post.h"
#import "Audio.h"
#import "postgetter.h"
#import "playerViewController.h"
#import "Favourites.h"

/**
 * Responsible for showing one specific post of a series of a blog.
 */
@interface DataViewController : UIViewController


// The implemented players
@property AVPlayer*player;
@property AVQueuePlayer * queuePlayer;
// The link to the favorites
@property Favourites *favourites;
// The post to show
@property (strong, nonatomic) id<Post> post;
// the list of posts.
@property NSMutableArray<Post> *posts;

/** UI Components **/
// Share button
@property (weak, nonatomic) IBOutlet UIButton *sharebutton;
// The loading indictor for (lazy)loading new posts
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
// The player container
@property (weak, nonatomic) IBOutlet UIView *playerContainer;
// The Descriptionview
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;
// The title label
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
// The image view for the album art if present
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
// The UIWebview for the video, if present
@property (weak, nonatomic) IBOutlet UIWebView *videoView;
// The favourite button
@property (weak, nonatomic) IBOutlet UIButton *favouriteButton;
// The follow button
@property (weak, nonatomic) IBOutlet UIButton *followBlogButton;

// Makes the user follow the blog if logged in.
- (IBAction)followButtonPressed:(id)sender;
// Makes it possible to share this post
- (IBAction)sharebuttonpressed:(id)sender;

// Used for lazyloading displaying the progress with a loading indicator
- (void) setLoading;
- (void) setDoneLoading;

@end

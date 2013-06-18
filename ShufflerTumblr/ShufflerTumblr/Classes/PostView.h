//
//  PostView.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 18-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface PostView : UIView


// The Container for the player
@property (weak, nonatomic) IBOutlet UIView *playerContainer;
// The label for the title of the post
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
// The image of the audio if attendant
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
// The UIWebView where we show the video in
@property (weak, nonatomic) IBOutlet UIWebView *videoView;
// The share button
@property (weak, nonatomic) IBOutlet UIButton *sharebutton;
// The favorite button
@property (weak, nonatomic) IBOutlet UIButton *favouriteButton;
// The description
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;

- (PostView*) createPostView;
- (void) setupPost: (id<Post>) post;

@end

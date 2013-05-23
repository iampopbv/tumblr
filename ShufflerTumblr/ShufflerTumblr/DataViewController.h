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

@interface DataViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id<Post> post;
@property NSMutableArray<Post> *posts;
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UIView *playerContainer;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIWebView *videoView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIWebView *captionView;
@property AVQueuePlayer * queuePlayer;

@property AVPlayer*player;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageheight;

@end

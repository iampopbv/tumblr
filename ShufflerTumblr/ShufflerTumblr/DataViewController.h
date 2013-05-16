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


@interface DataViewController : UIViewController

@property AVPlayer*player;


@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id<Post> post;
@property NSMutableArray<Post> *posts;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UIView *playerContainer;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property AVQueuePlayer * queuePlayer;


@end

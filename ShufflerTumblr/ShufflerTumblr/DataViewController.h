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
#import "Favourites.h"
#import <CoreMedia/CMTime.h>
#import "NextPostLoader.h"

@interface DataViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id<Post> post;
@property NSMutableArray<Post> *posts;
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UIView *playerContainer;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIWebView *videoView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIWebView *captionView;

@property Favourites *favourites;

@property id<NextPageLoader>loader;
@property AVQueuePlayer*player;

@property (weak, nonatomic) IBOutlet UIButton *favouriteButton;

- (void) setLoading;
- (void) setDoneLoading;

// player

@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *toGoLabel;
@property (weak, nonatomic) IBOutlet UIButton *playpause;
@property (weak, nonatomic) IBOutlet UISlider *seekbar;
- (IBAction)playpause:(UIButton *)sender;
- (IBAction)seek:(UISlider *)sender;


@end

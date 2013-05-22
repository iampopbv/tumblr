//
//  playerViewController.h
//  ShufflerTumblr
//
//  Created by B Al on 2013-05-16.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "postgetter.h"
#import <AVFoundation/AVFoundation.h>
#import "Post.h"
#import <CoreMedia/CMTime.h>

@interface playerViewController : UIViewController <postgetter>

@property id<Post> post;
@property (weak)id<postgetter> delegate;
@property AVPlayer*player;

@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playpause;
@property (weak, nonatomic) IBOutlet UIProgressView *seekbar;
- (IBAction)playpause:(id)sender;
@end

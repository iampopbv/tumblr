//
//  playerViewController.h
//  ShufflerTumblr
//
//  Created by B Al on 2013-05-16.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Post.h"
#import <CoreMedia/CMTime.h>

@interface PlayerViewController : UIViewController

@property id<Post> post;
@property AVPlayer*player;


@property (weak, nonatomic) IBOutlet UIButton *playpause;
@property (weak, nonatomic) IBOutlet UISlider *seekbar;
@property (weak, nonatomic) IBOutlet UILabel *upTimeCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *downCounterLabel;


- (IBAction)playpause:(id)sender;
@end

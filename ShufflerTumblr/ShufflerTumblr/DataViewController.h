//
//  DataViewController.h
//  PageBasedAppTest
//
//  Created by Casper Eekhof on 05-05-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Post.h"
#import "Audio.h"


@interface DataViewController : UIViewController

@property AVPlayer*player;

@property id<Post> post;

@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UIView *player;

@end

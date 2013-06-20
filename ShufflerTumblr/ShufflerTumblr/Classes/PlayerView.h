//
//  PlayerView.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 19-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayerView : UIView

@property (nonatomic) AVPlayer *player;
@property IBOutlet UISlider *slider;


@end

//
//  Player.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 17-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVFoundation/AVFoundation.h"
#import "Post.h"

@interface Player : NSObject


// The audio and video player
@property AVQueuePlayer *avQPlayer;
// The playlist, containing the posts
@property (nonatomic) NSMutableArray<Post> *playlist;


// Link to the singleton
+ (id) sharedInstance;
// Plays the next post in the playlist
- (void) playNextPost;
// Plays the previous post in the playlist
- (void) playPreviousPost;

@end

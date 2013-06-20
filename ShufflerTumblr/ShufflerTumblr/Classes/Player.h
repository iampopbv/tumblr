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
#import "SinglePostViewController.h"

@interface Player : NSObject



@property SinglePostViewController *viewController;


// Indicates, audio or video is playing
@property BOOL playing;
// Indicates whether the track ended or the user wanted te next song
@property BOOL trackEnded;
// The audio and video player
@property AVQueuePlayer *avQPlayer;
// The movie display
@property AVPlayerLayer* playerLayer;
// The playlist, containing the posts
@property (nonatomic) NSMutableArray<Post> *playlist;
// The playlist counter
@property int playListCounter;
// Pointer to the last item for insertion
@property AVPlayerItem *lastItem;

// Link to the singleton
+ (id) sharedInstance;
// Plays the next post in the playlist
- (id<Post>) playNextPost;
// Plays the previous post in the playlist
- (id<Post>) playPreviousPost;
// adds track to the current playlist
- (void) addToPlaylist: (NSArray<Post>*) posts;
// Register the app for background playing (NOT WORKING)
- (void) registerBackgroundMode;
- (void) clear;

// Returns the current post
- (id<Post>) currentPost;

- (void) playAV;
- (void) pauseAV;

@end

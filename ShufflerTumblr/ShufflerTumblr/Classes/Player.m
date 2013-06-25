//
//  Player.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 17-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "Player.h"
#import "DirectURLGetter.h"


//@interface Player  ()
//
//@end

@implementation Player

+ (id)sharedInstance {
    static Player *instance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{ instance = [[Player alloc] init]; });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initalization
        _avQPlayer = [[AVQueuePlayer alloc] init];
        _playlist = (NSMutableArray<Post>*) [[NSMutableArray alloc] init];
        _playListCounter = 0;
        _trackEnded = NO;
    }
    return self;
}

// Plays the next post in the playlist
- (id<Post>) playNextPost {
    //    [NSException raise:@"Unimplemented Exception" format:@"unimplemented method: playNextPost"];
    id<Post> nextPost;
    _playListCounter++;

    if (_playListCounter >= [_playlist count])
        return nextPost; // Don't let the app crash when there is no next song.
    
    nextPost = [_playlist objectAtIndex: _playListCounter];
    
    
    if(!_trackEnded) {
        [_avQPlayer advanceToNextItem];
        [self playAV];
    }
    _trackEnded = NO;
    
    return nextPost;
}

// Plays the previous post in the playlist
- (id<Post>) playPreviousPost {
    id<Post> prevPost;
    _playListCounter--;
    
    
    if(_playListCounter < 0) // Don't let the app crash when there is no previous song.
        return prevPost;
    prevPost = [_playlist objectAtIndex: _playListCounter];
    
    
    [_avQPlayer pause];
    
    // Insert the previous item after the current, and move to the next track (previous) and add the current after the previous item (we switched)
    AVPlayerItem *prevItem = [AVPlayerItem playerItemWithURL: [[NSURL alloc] initWithString: [prevPost playURL]]];
    AVPlayerItem * currentItem = [_avQPlayer currentItem];
    
    [_avQPlayer insertItem: prevItem afterItem: [_avQPlayer currentItem]];
    [_avQPlayer advanceToNextItem];
    [_avQPlayer insertItem:currentItem afterItem:prevItem];
    
    return prevPost;
}


- (void) addToPlaylist: (NSArray<Post>*) posts {
    [_playlist addObjectsFromArray: posts];
    
    for (id<Post> post in posts) {
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL: [[NSURL alloc] initWithString: [post playURL]]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
        [_avQPlayer insertItem: playerItem afterItem: _lastItem];
    }
}

-(void) setPlaylist:(NSMutableArray<Post> *)posts {
    
    // initalize the player with the new playlist
    [_playlist removeAllObjects];
    _playListCounter = 0;
    
    
    // Convert all urls to AVQueuePlayer playable URLs
    
    [_playlist addObjectsFromArray: posts];
    
    NSMutableArray *playerItems = [[NSMutableArray alloc] init];
    for (id<Post> post in posts) {
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL: [[NSURL alloc] initWithString: [post playURL]]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
        [playerItems addObject: playerItem];
        _lastItem = playerItem;
    }
    _avQPlayer = [_avQPlayer initWithItems: playerItems];
    
}

-(void)itemDidFinishPlaying {
    // Will be called when AVQueuePlayer finishes playing playerItem
    __block UIBackgroundTaskIdentifier background_task;
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground)
    {
        UIApplication *app = [UIApplication sharedApplication];
        background_task = [app beginBackgroundTaskWithExpirationHandler:^{
            [app endBackgroundTask: background_task]; // read more about background tasks.
            background_task = UIBackgroundTaskInvalid;
            
        }];

    }
    _trackEnded = YES;
    [_viewController loadNewPost: self];
    
}

- (id<Post>) currentPost {
    return _playlist[_playListCounter];
}

- (void) playAV {
    [_avQPlayer play];
    _playing = YES;
}


- (void) pauseAV {
    [_avQPlayer pause];
    _playing = NO;
}

- (void) clear {
    [_avQPlayer pause];
    [_avQPlayer removeAllItems];
    [_playlist removeAllObjects];
    _playing = NO;
}

@end

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
        _isLoadingDirectLink = 0;
        _trackEnded = NO;
    }
    return self;
}

// Plays the next post in the playlist
- (id<Post>) playNextPost {
    //    [NSException raise:@"Unimplemented Exception" format:@"unimplemented method: playNextPost"];
    id<Post> nextPost;
    _playListCounter++;
    nextPost = [_playlist objectAtIndex: _playListCounter];
    
    if(!_trackEnded) {
        [_avQPlayer advanceToNextItem];
        [self playAV];
    }
    _trackEnded = NO;
    
    NSLog(@"playing %@", [nextPost playURL]);
    
    return nextPost;
}

// Plays the previous post in the playlist
- (id<Post>) playPreviousPost {
    [NSException raise:@"Unimplemented Exception" format:@"unimplemented method: playPreviousPost"];
}


- (void) addToPlaylist: (NSArray<Post>*) posts {
    //    [_playlist addObjectsFromArray: posts];
    //
    //    // initalize the player with the new playlist
    //    NSMutableArray *playerItems = [[NSMutableArray alloc] init];
    //    __block int isLoadingDirectLink = 0;
    //
    //    // Fill the player items with the playURLs of the posts
    //    for (id<Post> post in posts) {
    //
    //        __block NSURL *postURL = [NSURL alloc];
    //        NSString *playURLS = [post playURL];
    //        if ([post type] == AUDIO) {
    //
    //            // If direct link
    //            postURL = [[NSURL alloc] initWithString: playURLS];
    //        } else if([post type] == VIDEO){
    //            if([playURLS hasPrefix:@"http://www.youtube"] || [playURLS hasPrefix:@"https://www.youtube"]){
    //                isLoadingDirectLink++;
    //                [[DirectURLGetter sharedInstance] getYoutubeLinkWithURL: playURLS withBlock:^(NSString *youtubeDirectURL) {
    //
    //                    postURL = [[NSURL alloc] initWithString: playURLS];
    //                    [playerItems addObject: [[AVPlayerItem alloc] initWithURL: postURL]];
    //
    //                    isLoadingDirectLink--;
    //                    if(!isLoadingDirectLink)
    //                        _avQPlayer = [_avQPlayer initWithItems: playerItems];
    //                }];
    //            } else
    //                postURL = [[NSURL alloc] initWithString: playURLS];
    //        }
    //        [_avQPlayer insertItem:[[AVPlayerItem alloc] initWithURL: postURL] afterItem: [[_avQPlayer items] objectAtIndex: 0]];
    //    }
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
        
    }
    _avQPlayer = [_avQPlayer initWithItems: playerItems];
    
}

// Not setting the application to background :( (yet)
-(void)registerBackgroundMode {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
}

-(void)itemDidFinishPlaying {
    // Will be called when AVQueuePlayer finishes playing playerItem
    NSLog(@"did end playing song");
    
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground)
    {
//        UIApplication *app = [UIApplication sharedApplication];
//        bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
//            [app endBackgroundTask: bgTask]; // read more about background tasks.
//            bgTask = UIBackgroundTaskInvalid;
//            // NSLog(@"bg finished with exp handler");
//        }];
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
}

@end

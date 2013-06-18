//
//  Player.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 17-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "Player.h"
#import "YoutubeURLGetter.h"

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
    }
    return self;
}

// Plays the next post in the playlist
- (void) playNextPost {
    [NSException raise:@"Unimplemented Exception" format:@"unimplemented method: playNextPost"];
}

// Plays the previous post in the playlist
- (void) playPreviousPost {
    [NSException raise:@"Unimplemented Exception" format:@"unimplemented method: playPreviousPost"];
}


- (void) addToPlaylist: (NSArray<Post>*) posts {
    [_playlist addObjectsFromArray: posts];
    
    // initalize the player with the new playlist
    NSMutableArray *playerItems = [[NSMutableArray alloc] init];
    __block int isLoadingDirectLink = 0;
    
    // Fill the player items with the playURLs of the posts
    for (id<Post> post in posts) {
        
        __block NSURL *postURL = [NSURL alloc];
        NSString *playURLS = [post playURL];
        if ([post type] == AUDIO) {
            
            // If direct link
            postURL = [[NSURL alloc] initWithString: playURLS];
        } else if([post type] == VIDEO){
            if([playURLS hasPrefix:@"http://youtube"] || [playURLS hasPrefix:@"https://youtube"]){
                isLoadingDirectLink++;
                [[YoutubeURLGetter sharedInstance] getYoutubeLinkWithURL: playURLS withBlock:^(NSString *youtubeDirectURL) {
                    
                    postURL = [[NSURL alloc] initWithString: playURLS];
                    [playerItems addObject: [[AVPlayerItem alloc] initWithURL: postURL]];
                    
                    isLoadingDirectLink--;
                    if(!isLoadingDirectLink)
                        _avQPlayer = [_avQPlayer initWithItems: playerItems];
                }];
            } else
                postURL = [[NSURL alloc] initWithString: playURLS];
        }
        [_avQPlayer insertItem:[[AVPlayerItem alloc] initWithURL: postURL] afterItem: [[_avQPlayer items] objectAtIndex: 0]];
    }
}

-(void) setPlaylist:(NSMutableArray<Post> *)posts {
    _playlist = posts;
    
    // initalize the player with the new playlist
    NSMutableArray *playerItems = [[NSMutableArray alloc] init];
    __block int isLoadingDirectLink = 0;
    
    // Fill the player items with the playURLs of the posts
    for (id<Post> post in posts) {
        
        __block NSURL *postURL = [NSURL alloc];
        NSString *playURLS = [post playURL];
        if ([post type] == AUDIO) {
            
            // If direct link
            postURL = [[NSURL alloc] initWithString: playURLS];
        } else if([post type] == VIDEO){
            if([playURLS hasPrefix:@"http://youtube"] || [playURLS hasPrefix:@"https://youtube"]){
                isLoadingDirectLink++;
                [[YoutubeURLGetter sharedInstance] getYoutubeLinkWithURL: playURLS withBlock:^(NSString *youtubeDirectURL) {
                    
                    postURL = [[NSURL alloc] initWithString: playURLS];
                    [playerItems addObject: [[AVPlayerItem alloc] initWithURL: postURL]];
                    
                    isLoadingDirectLink--;
                    if(!isLoadingDirectLink)
                        _avQPlayer = [_avQPlayer initWithItems: playerItems];
                }];
            } else
            postURL = [[NSURL alloc] initWithString: playURLS];
        }
        [playerItems addObject: [[AVPlayerItem alloc] initWithURL: postURL]];
    }
    
    if(!isLoadingDirectLink)
        _avQPlayer = [_avQPlayer initWithItems: playerItems];
}

@end

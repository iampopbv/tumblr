//
//  AppSession.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 09/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import "AppSession.h"
#import "TMAPIClient.h"
#import "Post.h"
#import "Audio.h"
#import "AudioPost.h"
#import "Video.h"
#import "Following.h"

@implementation AppSession

/**
 */
const int numToLoad = 8;

/**
 */
+(instancetype)sharedInstance {
    static AppSession* instance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/**
 */
-(id)init{
    self = [super init];
    if (self) {
        [self setUserInfo];
        [self resetOffsets];
        [self resetPosts];
    }
    return self;
}

-(void)setUserInfo{
    [[TMAPIClient sharedInstance] userInfo:^(id result, NSError *error) {
        if (!error){
            _user_name = [result valueForKeyPath:@"user.name"];
        }
    }];
}

/**
 */
-(void)resetOffsets{
    _dashboardAudioPostOffset = 0;
    _dashboardVideoPostOffset = 0;
    _sitesFollowingOffset = 0;
    _siteProfilePostOffset = 0;
    _discoveryPostOffset = 0;
    _likesPostOffset = 0;
    _currentlyPlayingIndex = 0;
    _currentluPlayingPostLocation = 0;
}

/**
 */
-(void)resetPosts{
    _dashboardPosts = (NSMutableArray<Post>*)[[NSMutableArray alloc] init];
    _siteProfilePosts = [[NSMutableArray alloc] init];
    _discoveryPosts = [[NSMutableArray alloc] init];
    _likesPosts = [[NSMutableArray alloc] init];
}

-(void)reloadDashboardPosts:(NSArray<Post>*) posts{
    _dashboardAudioPostOffset = 0;
    _dashboardVideoPostOffset = 0;
    
    [self loadDashboardPosts:^(NSArray<Post>* posts){
        [_dashboardPosts removeAllObjects];
        [_dashboardPosts addObjectsFromArray:posts];
    }];
}

-(void)addDashboardPosts{
    [self loadDashboardPosts:^(NSArray<Post>* posts){
        [self.dashboardPosts addObjectsFromArray:posts];
    }];
}

-(void)loadDashboardPosts:(callback)callback{
    NSArray * paramsKeys = [[NSArray alloc] initWithObjects:@"limit", @"offset", @"type", nil];
    NSArray * paramsVals = [[NSArray alloc] initWithObjects:
                            [[NSString alloc] initWithFormat:@"%i", numToLoad],
                            [[NSString alloc] initWithFormat:@"%i", _dashboardAudioPostOffset],
                            @"audio", nil];
    NSDictionary *paramsDict = [[NSDictionary alloc] initWithObjects: paramsVals forKeys: paramsKeys];
    NSMutableArray<Post> *posts = (NSMutableArray<Post>*)[[NSMutableArray alloc] init];
    
    [[TMAPIClient sharedInstance] dashboard:paramsDict callback:^(id response, NSError *error) {
        if (!error) {
            NSDictionary* postsDict = [response objectForKey:@"posts"];
            for(NSDictionary* post in postsDict){
                AudioPost* postItem     = [[AudioPost alloc]init];
                postItem.album          = [post valueForKeyPath:@"album"];
                postItem.album_art      = [post valueForKeyPath:@"album_art"];
                postItem.artist         = [post valueForKeyPath:@"artist"];
                postItem.audio_type     = [post valueForKeyPath:@"audio_type"];
                postItem.audio_url      = [post valueForKeyPath:@"audio_url"];
                postItem.blogName       = [post valueForKeyPath:@"blog_name"];
                postItem.can_reply      = [post valueForKeyPath:@"can_reply"];
                postItem.caption        = [post valueForKeyPath:@"caption"];
                postItem.date           = [post valueForKeyPath:@"date"];
                postItem.playerEmbed    = [post valueForKeyPath:@"embed"];
                postItem.followed       = [post valueForKeyPath:@"followed"];
                postItem.format         = [post valueForKeyPath:@"format"];
                postItem.highlighted    = [post valueForKeyPath:@"highlighted"];
                postItem.ID             = [post valueForKeyPath:@"id"];
                postItem.liked          = [post valueForKeyPath:@"liked"];
                postItem.note_count     = [post valueForKeyPath:@"note_count"];
                postItem.playerEmbed    = [post valueForKeyPath:@"player"];
                postItem.plays          = [post valueForKeyPath:@"plays"];
                postItem.postURL        = [post valueForKeyPath:@"post_url"];
                postItem.reblogKey      = [post valueForKeyPath:@"reblog_key"];
                postItem.short_url      = [post valueForKeyPath:@"short_url"];
                postItem.slug           = [post valueForKeyPath:@"slug"];
                postItem.state          = [post valueForKeyPath:@"state"];
                postItem.tags           = [post valueForKeyPath:@"album"];
                postItem.postTimestamp  = [post valueForKeyPath:@"timestamp"];
                postItem.track_name     = [post valueForKeyPath:@"track_name"];
                postItem.type           = 0;
                [posts addObject:postItem];
            }
            
            _dashboardAudioPostOffset += numToLoad;
            
            NSArray<Post> *sortedPosts;
            // Sort the posts on timestamp
            NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"postTimestamp" ascending: NO];
            sortedPosts = (NSArray<Post>*)[posts sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];
            
            callback(sortedPosts);
        }
    }];
}

-(void)loadSites:(callback)callback{
    NSArray* paramsKeys = [[NSArray alloc] initWithObjects:@"base-hostname", nil];
    NSArray* paramsVals = [[NSArray alloc] initWithObjects:
                           [[NSString alloc] initWithFormat:@"%@", _user_name], nil];
    NSDictionary *paramsDict = [[NSDictionary alloc]initWithObjects:paramsVals forKeys:paramsKeys];
    NSMutableArray* following = (NSMutableArray<Post>*)[[NSMutableArray alloc] init];
    
    [[TMAPIClient sharedInstance]following:paramsDict callback:^(id result, NSError *error) {
        if(!error){
            for(NSArray* follow in [result valueForKeyPath:@"blogs"]){
                Following* siteFollow = [[Following alloc]init];
                siteFollow.description = [follow valueForKeyPath:@"description"];
                siteFollow.name = [follow valueForKeyPath:@"name"];
                siteFollow.title = [follow valueForKeyPath:@"title"];
                siteFollow.updated = [[follow valueForKeyPath:@"updated"] integerValue];
                siteFollow.url = [follow valueForKeyPath:@"url"];
                [following addObject:siteFollow];
            }
        }
        
        callback(following);
    }];
}

@end

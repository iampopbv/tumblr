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
#import "Video.h"

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
        [self resetOffsets];
        [self resetPosts];
    }
    return self;
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
}

/**
 */
-(void)resetPosts{
    _dashboardPosts = [[NSMutableArray alloc] init];
    _siteProfilePosts = [[NSMutableArray alloc] init];
    _discoveryPosts = [[NSMutableArray alloc] init];
    _likesPosts = [[NSMutableArray alloc] init];
}

-(void)loadDashboardPosts:(callback)callback{
    __block BOOL _didLoadDashPart1 = NO;
    
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
            for(NSDictionary* item in postsDict){
                [posts addObject:[[Audio alloc]initWithDictionary:item]];
            }
            
            _dashboardAudioPostOffset += numToLoad;
            
            // if the other part(video) is already loaded, only then we can return the callback
//            if(!_didLoadDashPart1)
//                _didLoadDashPart1 = YES;
//            else {
                NSArray<Post> *sortedPosts;
                // Sort the posts on timestamp
                NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"postTimestamp" ascending: NO];
                sortedPosts = (NSArray<Post>*)[posts sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];
                
                callback(sortedPosts);
                _didLoadDashPart1 = NO;
//            }
            
        }
    }];
    
//    paramsKeys = [[NSArray alloc] initWithObjects:@"limit", @"offset", @"type", nil];
//    paramsVals = [[NSArray alloc] initWithObjects:
//                  [[NSString alloc] initWithFormat:@"%i", numToLoad],
//                  [[NSString alloc] initWithFormat:@"%i", _dashboardVideoPostOffset],
//                  @"video", nil];
//    paramsDict = [[NSDictionary alloc] initWithObjects: paramsVals forKeys: paramsKeys];
//    [[TMAPIClient sharedInstance] dashboard:paramsDict callback:^(id response, NSError *error) {
//        if (!error) {
//            NSDictionary *postsDict = [response objectForKey: @"posts"];
//            for(NSDictionary *item in postsDict){
//                [posts addObject: [[Video alloc] initWithDictionary: item]];
//            }
//            
//            _dashboardVideoPostOffset += numToLoad;
//            
//            // if the other part(audio) is already loaded, only then we can return the callback
//            if(!_didLoadDashPart1)
//                _didLoadDashPart1 = YES;
//            else {
//                NSArray<Post> *sortedPosts;
//                // Sort the posts on timestamp
//                NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"postTimestamp" ascending: NO];
//                sortedPosts = (NSArray<Post>*)[posts sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];
//                
//                callback(sortedPosts);
//                _didLoadDashPart1 = NO;
//            }
//        }
//    }];

}

@end

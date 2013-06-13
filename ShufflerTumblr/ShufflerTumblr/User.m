//
//  User.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 28-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "User.h"
#import "DataPostHandler.h"
#import "TMAPIClient.h"
#import "Audio.h"
#import "Video.h"


@implementation User

const int limitNextPage = 5;

+ (id)sharedInstance {
    static User *instance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{ instance = [[User alloc] init]; });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _dashboardOffsetAudio = 0;
        _dashboardOffsetVideo = 0;
    }
    return self;
}

- (void) resetOffsets {
    _dashboardOffsetAudio = 0;
    _dashboardOffsetVideo = 0;
}

- (void) getNextPageDashboard: (callback) callback {
    __block BOOL _didLoadDashPart1 = NO;
    
    NSArray * paramsKeys = [[NSArray alloc] initWithObjects:
                            @"limit",
                            @"offset",
                            @"type",
                            nil];
    NSArray * paramsVals = [[NSArray alloc] initWithObjects:
                            [[NSString alloc] initWithFormat:@"%i", limitNextPage],
                            [[NSString alloc] initWithFormat:@"%i", _dashboardOffsetAudio],
                            @"audio",
                            nil];
    NSDictionary *paramsDict = [[NSDictionary alloc] initWithObjects: paramsVals forKeys: paramsKeys];
    NSMutableArray<Post> *posts = (NSMutableArray<Post> *)[[NSMutableArray alloc] init];
    
    [[TMAPIClient sharedInstance] dashboard: paramsDict callback:^(id response, NSError *error) {
        if (!error) {
            NSDictionary *dashboard = response;
//            NSLog(@"response: %@", response);
            // Do the parsing
            NSDictionary *postsDict = [dashboard objectForKey:@"posts"];
            for(NSDictionary *item in postsDict){
//                NSLog(@"type: %@", [item objectForKey:@"type"]);
                [posts addObject: [[Audio alloc] initWithDictionary: item]];
            }
            
            _dashboardOffsetAudio += limitNextPage;
            
            // if the other part(video) is already loaded, only then we can return the callback
            if(!_didLoadDashPart1)
                _didLoadDashPart1 = YES;
            else {
                NSArray<Post> *sortedPosts;
                // Sort the posts on timestamp
                NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"postTimestamp" ascending: NO];
                sortedPosts = (NSArray<Post>*)[posts sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];
                
                callback(sortedPosts);
                _didLoadDashPart1 = NO;
            }
            
        } else {
            // Something went wrong try again.
        }
    }];
    
    
    
    // now the same for audio
    paramsKeys = [[NSArray alloc] initWithObjects:
                  @"limit",
                  @"offset",
                  @"type",
                  nil];
    paramsVals = [[NSArray alloc] initWithObjects:
                  [[NSString alloc] initWithFormat:@"%i", limitNextPage],
                  [[NSString alloc] initWithFormat:@"%i", _dashboardOffsetVideo],
                  @"video",
                  nil];
    paramsDict = [[NSDictionary alloc] initWithObjects: paramsVals forKeys: paramsKeys];
    [[TMAPIClient sharedInstance] dashboard: paramsDict callback:^(id response, NSError *error) {
        if (!error) {
            
            NSDictionary *dashboard = response;
            // Do the parsing
            NSDictionary *postsDict = [dashboard objectForKey: @"posts"];
            for(NSDictionary *item in postsDict){
                [posts addObject: [[Video alloc] initWithDictionary: item]];
            }
            
            _dashboardOffsetVideo += limitNextPage;
            
            // if the other part(audio) is already loaded, only then we can return the callback
            if(!_didLoadDashPart1)
                _didLoadDashPart1 = YES;
            else {
                NSArray<Post> *sortedPosts;
                // Sort the posts on timestamp
                NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"postTimestamp" ascending: NO];
                sortedPosts = (NSArray<Post>*)[posts sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];

                callback(sortedPosts);
                _didLoadDashPart1 = NO;
            }
        } else {
            // Something went wrong try again.
        }
    }];
    
}

- (NSDictionary*) retrieveUserInfo {
    
}

- (void) getNextFollowingPage: (BlogInfoRetrievalBlock) block {
    
}

@end

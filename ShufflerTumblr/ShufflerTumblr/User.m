//
//  User.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 28-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "User.h"
#import "DataPostHandler.h"

@implementation User

const int maxFollowBlogs = 5;
int followingPageOffset = 0;
static User *user;

- (id) initWithUsername: (NSString*) username
{
    if(!user){
        user = [super init];
        user.username = username;
    }
    return user;
}

- (BOOL) loginWithPassword: (NSString*) password {
    _loggedIn = NO;
    if(_username == nil)
        return _loggedIn;
    
    // Login with OAuth
    
    
    _loggedIn = YES;
    return _loggedIn;
}

- (void) retrieveUserInfo {
}

- (void) retrieveUserDashboard {
    if (!_loggedIn)
        [NSException raise:@"Authentication Error" format: @"not logged in."];
}

- (void) retrieveNextFollowingPage: (BlogInfoRetrievalBlock) block {
    [self retrieveUserFollowingWithLimit: maxFollowBlogs andOffset:followingPageOffset onCompletion: block];
    followingPageOffset += maxFollowBlogs; // increase the offset for the next time.
}

- (void) retrieveUserFollowingWithLimit: (int) limit andOffset: (int) offset onCompletion: (BlogInfoRetrievalBlock) block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSString *post = [[NSString alloc] initWithFormat: @"limit=%i&offset=%i", limit, offset];
    dispatch_async(queue, ^{
        __block NSArray<Info> *blogs;
        
        
        DataPostHandler *handler = [[DataPostHandler alloc] init];
        [handler postDataToURL:@"api.tumblr.com/v2/user/following" post: post onCompletion:^(NSData *response) {
			
            NSError *err = nil;
            NSMutableDictionary *objectDict = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &err];
        }];
        
        block(blogs);
    });
    
}

- (void) followBlog: (NSString*) blogURL {
    NSString *url = @"api.tumblr.com/v2/user/follow";
    NSString *post = [[NSString alloc] initWithFormat: @"url=%@", blogURL];
    
    DataPostHandler *handler = [[DataPostHandler alloc] init];
    // Post the request.
    [handler postDataToURL: url post: post onCompletion:^(NSData *response) {
        NSError *err = nil;
        NSMutableDictionary *objectDict = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &err];
        
    }];
}
- (void) unfollowBlog: (NSString*) blogURL {
    NSString *url = @"api.tumblr.com/v2/user/unfollow";
    NSString *post = [[NSString alloc] initWithFormat: @"url=%@", blogURL];
    
    DataPostHandler *handler = [[DataPostHandler alloc] init];
    // Post the request.
    [handler postDataToURL: url post: post onCompletion:^(NSData *response) {
        NSError *err = nil;
        NSMutableDictionary *objectDict = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &err];
        
    }];
}


- (void) likePost: (int) postId withReblogKey: (NSString*) reblogKey {
    NSString *url = @"api.tumblr.com/v2/user/like";
    NSString *post = [[NSString alloc] initWithFormat: @"id=%i&reblog_key=%@", postId, reblogKey];
    
    
    DataPostHandler *handler = [[DataPostHandler alloc] init];
    // Post the request.
    [handler postDataToURL: url post: post onCompletion:^(NSData *response) {
        NSError *err = nil;
        NSMutableDictionary *objectDict = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &err];
        
    }];
}

- (void) unlikePost: (int) postId withReblogKey: (NSString*) reblogKey {
    NSString *url = @"api.tumblr.com/v2/user/unlike";
    NSString *post = [[NSString alloc] initWithFormat: @"id=%i&reblog_key=%@", postId, reblogKey];
    
    // Post the request.
    DataPostHandler *handler = [[DataPostHandler alloc] init];
    [handler postDataToURL: url post: post onCompletion:^(NSData *response) {
        NSError *err = nil;
        NSMutableDictionary *objectDict = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error: &err];
        
    }];
}



@end

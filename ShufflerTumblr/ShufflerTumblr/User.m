//
//  User.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 28-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "User.h"

@implementation User

- (id) initWithUsername: (NSString*) username
{
    self = [super init];
    if (self) {
        self.username = username;
    }
    return self;
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
    if (_loggedIn)
        [NSException raise:@"Authentication Error" format: @"not logged in."];
}

- (void) retrieveUserFollowingWithLimit: (int) limit andOffeset: (int) offset onCompletion: (infoFollowingCompletionBlock) block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSString *post = [[NSString alloc] initWithFormat: @"limit=%i&offset=%i", limit, offset];
    dispatch_async(queue, ^{
        NSArray<Info> *blogs;
        
        [self postDataToURL:@"api.tumblr.com/v2/user/following" post: post];
        
        block(blogs);
    });
    
}

- (void) followBlog: (NSString*) blogURL {
    NSString *url = @"api.tumblr.com/v2/user/follow";
    NSString *post = [[NSString alloc] initWithFormat: @"url=%@", blogURL];
    
    // Post the request.
    [self postDataToURL: url post: post];
}
- (void) unfollowBlog: (NSString*) blogURL {
    NSString *url = @"api.tumblr.com/v2/user/unfollow";
    NSString *post = [[NSString alloc] initWithFormat: @"url=%@", blogURL];
    
    // Post the request.
    [self postDataToURL: url post: post];
}


- (void) likePost: (int) postId withReblogKey: (NSString*) reblogKey {
    NSString *url = @"api.tumblr.com/v2/user/like";
    NSString *post = [[NSString alloc] initWithFormat: @"id=%i&reblog_key=%@", postId, reblogKey];
    
    // Post the request.
    [self postDataToURL: url post: post];
}
- (void) unlikePost: (int) postId withReblogKey: (NSString*) reblogKey {
    NSString *url = @"api.tumblr.com/v2/user/unlike";
    NSString *post = [[NSString alloc] initWithFormat: @"id=%i&reblog_key=%@", postId, reblogKey];
    
    // Post the request.
    [self postDataToURL: url post: post];
}

- (void) postDataToURL: (NSString*) apiString post: (NSString*) post {
    
    NSURL *url = [[NSURL alloc] initWithString: apiString];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    [request setURL: url];
    [request setHTTPMethod: @"POST"];
    [request setValue: postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: postData];
    
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (!theConnection) {
        // Inform the user that the connection failed.
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // it is now safe to use the data.
}

@end

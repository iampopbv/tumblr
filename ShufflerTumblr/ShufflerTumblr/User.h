//
//  User.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 28-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlogInfo.h"

@interface User : NSObject

@property NSString *username;
@property NSString *tumblrShortName;
@property int likes;
@property int following;
@property NSArray<Info> *blogs;
@property BOOL loggedIn;

typedef void (^infoFollowingCompletionBlock)(NSArray<Info> *blogs);

- (void) retrieveUserDashboard;
- (void) retrieveUserInfo;
- (void) retrieveUserFollowingWithLimit: (int) limit andOffeset: (int) offset onCompletion: (infoFollowingCompletionBlock) block;

- (id) initWithUsername: (NSString*) username;
- (void) followBlog: (NSString*) blogURL;
- (void) unfollowBlog: (NSString*) blogURL;
- (void) likePost: (int) postId withReblogKey: (NSString*) reblogKey;
- (void) unlikePost: (int) postId withReblogKey: (NSString*) reblogKey;
- (BOOL) loginWithPassword: (NSString*) password;

@end

//
//  User.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 28-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Info.h"
#import "Post.h"

/**
 * Interface between TumblrSDK and Front-end.
 * Provides back-end lazyloading.
 */
@interface User : NSObject

// The user info
@property NSString *username;
@property NSString *tumblrShortName;
@property int likes;
@property int following;
@property NSArray<Info> *blogs;

// YES when logged in
@property BOOL loggedIn;

// The offset for dashboard audio posts
@property int dashboardOffsetAudio;
// The offset for dashboard video posts
@property int dashboardOffsetVideo;
// The offset for following blogs
@property int followingOffset;

// Completion blocks
typedef void (^BlogInfoRetrievalBlock)(NSArray<Info>* blogs);
typedef void (^callback) (id);
typedef void (^callbackWithBlogNames) (NSArray<Post>*, NSArray* blognames);


// Singleton reference
+ (id)sharedInstance;
// Resets the offsets
- (void) resetOffsets;
// Get the next page of the dashboard
- (void) getNextPageDashboard: (callback) callback;
// Retrieve the user info
- (NSDictionary*) retrieveUserInfo;
// Get the next page of the followed blogs
- (void) getNextFollowingPage: (BlogInfoRetrievalBlock) block;

@end

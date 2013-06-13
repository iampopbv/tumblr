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

@interface User : NSObject

@property NSString *username;
@property NSString *tumblrShortName;
@property int likes;
@property int following;
@property NSArray<Info> *blogs;
@property BOOL loggedIn;

@property int dashboardOffsetAudio;
@property int dashboardOffsetVideo;
@property int followingOffset;

typedef void (^BlogInfoRetrievalBlock)(NSArray<Info>* blogs);
typedef void (^callback) (NSArray<Post>*);
typedef void (^callbackWithBlogNames) (NSArray<Post>*, NSArray* blognames);

+ (id)sharedInstance;
- (void) resetOffsets;
- (void) getNextPageDashboard: (callback) callback;
- (NSDictionary*) retrieveUserInfo;
- (void) getNextFollowingPage: (BlogInfoRetrievalBlock) block;

@end

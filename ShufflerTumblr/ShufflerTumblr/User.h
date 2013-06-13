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

@property int dashboardOffset;
@property int followingOffset;

typedef void (^BlogInfoRetrievalBlock)(NSArray<Info>* blogs);

- (NSArray<Post>*) getNextPageDashboard;
- (NSDictionary*) retrieveUserInfo;
- (NSArray<Info>*) getNextFollowingPage: (BlogInfoRetrievalBlock) block;

@end

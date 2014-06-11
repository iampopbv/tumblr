//
//  AppSession.h
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 09/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@interface AppSession : NSObject

typedef void (^callback) (id);

@property NSString* user_name;

@property int dashboardAudioPostOffset;
@property int dashboardVideoPostOffset;
@property int sitesFollowingOffset;
@property int siteProfilePostOffset;
@property int discoveryPostOffset;
@property int likesPostOffset;

@property int currentlyPlayingIndex;
@property int currentlyPlayingPostLocation;

@property NSMutableArray* dashboardPosts;
@property NSMutableArray* siteProfilePosts;
@property NSMutableArray* discoveryPosts;
@property NSMutableArray* likesPosts;

/** @name Singleton instance */
+(instancetype)sharedInstance;

-(void)resetOffsets;
-(void)resetPosts;

-(void)reloadDashboardPosts;
-(void)loadDashboardPosts:(callback)callback;
-(void)addDashboardPosts;
-(void)loadSites:(callback)callback;

@end

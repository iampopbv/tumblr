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
@property int siteProfileAudioPostOffset;
@property int siteProfileVideoPostOffset;
@property int discoveryAudioPostOffset;
@property int discoveryVideoPostOffset;
@property int likesPostOffset;

@property int currentlyPlayingIndex;
@property int currentlyPlayingPostLocation;

@property NSTimeInterval currentTimeStamp;

@property NSMutableArray* dashboardPosts;
@property NSMutableArray* siteProfilePosts;
@property NSMutableArray* discoveryPosts;
@property NSMutableArray* likesPosts;

/** @name Singleton instance */
+(instancetype)sharedInstance;

-(void)resetOffsets;
-(void)resetPosts;

-(void)reloadDashboardPosts;
-(void)reloadSiteProfilePosts:(NSString*)blogName;
-(void)reloadDiscoveryPosts;

-(void)loadDashboardPosts:(callback)callback;
-(void)loadBlogInfo:(callback)callback;

-(void)loadSites:(callback)callback;
-(void)loadSiteProfilePosts:(callback)callback blog:(NSString*)blogName;
-(void)loadDiscoveryPosts:(callback)callback;

-(void)addDashboardPosts;
-(void)addSiteProfilePosts:(NSString*)blogName;
-(void)addDiscoveryPosts;

@end

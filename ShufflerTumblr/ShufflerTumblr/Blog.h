//
//  ShufflerTumblrDB.h
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/21/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"
#import "Video.h"
#import "Audio.h"
#import "Info.h"
#import "BlogInfo.h"

@interface Blog : NSObject

typedef void (^ShufflerTumblrTotalPostQueryCompletionBlock)(int latestPostNr, NSError *error);
typedef void (^ShufflerTumblrPostQueryCompletionBlock)(id<Post> post, NSError *error);
typedef void (^ShufflerTumblrMultiplePostQueryCompletionBlock)(NSArray<Post> *posts, NSError *error);
typedef void (^ShufflerTumblrInfoQueryCompletionBlock)(id<Info> info, NSError *error);

@property NSString * apiType;
@property NSURL * blogURL;
@property BlogInfo *blogInfo;
@property __block int offsetRecentPostsAudio;
@property __block int offsetRecentPostsVideo;
@property __block int videoPosts;
@property __block int audioPosts;
@property BOOL retrievedAllRecentAudioPosts;
@property BOOL retrievedAllRecentVideoPosts;
@property BOOL reachedTopAudioPosts;
@property BOOL reachedTopVideoPosts;

extern const NSString * apiKey;


- (id)initWithURL: (NSString*) blogURL;
- (void) getPosts: (PostType) type completionBlock: (ShufflerTumblrMultiplePostQueryCompletionBlock) block;
- (void) getInfo: (ShufflerTumblrInfoQueryCompletionBlock) block;
- (void) getNextPageLatest: (ShufflerTumblrMultiplePostQueryCompletionBlock) block;
- (void) getPreviousPageLatest: (ShufflerTumblrMultiplePostQueryCompletionBlock) block;
- (void) reset;

@end

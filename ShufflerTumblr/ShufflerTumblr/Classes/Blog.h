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


/**
 * Retrieve blog posts and blog data with this.
 */
@interface Blog : NSObject


// Completion blocks
typedef void (^ShufflerTumblrTotalPostQueryCompletionBlock)(int latestPostNr, NSError *error);
typedef void (^ShufflerTumblrPostQueryCompletionBlock)(id<Post> post, NSError *error);
typedef void (^ShufflerTumblrMultiplePostQueryCompletionBlock)(NSArray<Post> *posts, NSError *error);
typedef void (^ShufflerTumblrInfoQueryCompletionBlock)(id<Info> info, NSError *error);

// The url of the blog
@property NSURL * blogURL;
// The blog info
@property BlogInfo *blogInfo;
// The offset of the recent Audio posts
@property __block int offsetRecentPostsAudio;
// The offset of the recent Video posts
@property __block int offsetRecentPostsVideo;
// The amount of video posts (total)
@property __block int videoPosts;
// The amount of audio posts (total)
@property __block int audioPosts;
// YES when retrieved all audio posts.
@property BOOL retrievedAllRecentAudioPosts;
// YES when retrieved all video posts
@property BOOL retrievedAllRecentVideoPosts;
// Lazyloading: reached top of all recent audio posts
@property BOOL reachedTopAudioPosts;
// Lazyloading: reached top of all recent audio posts
@property BOOL reachedTopVideoPosts;

// The API key
extern const NSString * apiKey;

// Init the blog
- (id)initWithURL: (NSString*) blogURL;
// Init the blog based on a dictionary
- (void) initWithDictionary: (NSDictionary*) dict;
// Gets the posts of a specific type
#pragma DEPRECATED
- (void) getPosts: (PostType) type completionBlock: (ShufflerTumblrMultiplePostQueryCompletionBlock) block;
// Gets the info of this blog
- (void) getInfo: (ShufflerTumblrInfoQueryCompletionBlock) block;
// Gets the (next) latest page
- (void) getNextPageLatest: (ShufflerTumblrMultiplePostQueryCompletionBlock) block;
// Gets the previous latest page
- (void) getPreviousPageLatest: (ShufflerTumblrMultiplePostQueryCompletionBlock) block;
// Resets the offsets
- (void) reset;

@end

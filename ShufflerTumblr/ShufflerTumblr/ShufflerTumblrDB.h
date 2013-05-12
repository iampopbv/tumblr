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

@interface ShufflerTumblrDB : NSObject

typedef void (^ShufflerTumblrPostQueryCompletionBlock)(id<Post> post, NSError *error);
typedef void (^ShufflerTumblrMultiplePostQueryCompletionBlock)(NSArray<Post> *posts, NSError *error);
typedef void (^ShufflerTumblrInfoQueryCompletionBlock)(id<Info> info, NSError *error);

extern const NSString * apiKey;
@property NSString * apiType;
@property NSURL * blogURL;
extern NSString *apiURL;

-(void) getPosts: (PostType) type completionBlock: (ShufflerTumblrMultiplePostQueryCompletionBlock) block;
-(void) getInfo: (ShufflerTumblrInfoQueryCompletionBlock) block;
@end

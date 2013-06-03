//
//  FavouriteBlog.h
//  ShufflerTumblr
//
//  Created by Sem Wong on 5/31/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"
#import "Info.h"
#import "BlogInfo.h"
#import "Favourites.h"

@interface FavouriteBlog : NSObject

typedef void (^ShufflerTumblrPostQueryCompletionBlock)(id<Post> post, NSError *error);
typedef void (^ShufflerTumblrMultiplePostQueryCompletionBlock)(NSArray<Post> *posts, NSError *error);
typedef void (^ShufflerTumblrInfoQueryCompletionBlock)(id<Info> info, NSError *error);

@property NSString * apiType;
@property NSURL * blogURL;
@property BlogInfo *blogInfo;
extern const NSString * apiKey;
@property Favourites *favourites;

-(void) getPosts: (PostType) type completionBlock: (ShufflerTumblrMultiplePostQueryCompletionBlock) block;
-(void) getInfo: (ShufflerTumblrInfoQueryCompletionBlock) block;

@end

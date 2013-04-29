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
typedef void (^ShufflerTumblrMultiplePostQueryCompletionBlock)(NSArray *posts, NSError *error);
typedef void (^ShufflerTumblrInfoQueryCompletionBlock)(id<Info> info, NSError *error);

extern const NSString * apiURL;
extern const NSString * apiKey;
@property NSString * apiType;

-(void) getPosts: (NSString*) type;
-(void) getInfo;
-(id<Post>) parseJSONtoAudio: (NSString*) jsonString;
-(id<Post>) parseJSONtoVideo: (NSString*) jsonString;
-(id<Info>) parseJSONtoInfo: (NSString*) jsonString;
@end

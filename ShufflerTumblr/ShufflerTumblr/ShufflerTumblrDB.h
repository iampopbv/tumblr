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

@interface ShufflerTumblrDB : NSObject

typedef void (^ShufflerTumblrSingleQueryCompletionBlock)(id<Post> post, NSError *error);
typedef void (^ShufflerTumblrMultipleQueryCompletionBlock)(NSArray *posts, NSError *error);

extern const NSString * apiURL;
extern const NSString * apiKey;
@property NSString * apiType;

-(void) getPosts: (NSString*) type;
-(id<Post>) parseJSONtoPost: (NSString*) jsonString;
@end

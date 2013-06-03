//
//  FavouriteBlog.m
//  ShufflerTumblr
//
//  Created by Sem Wong on 5/31/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "FavouriteBlog.h"

@implementation FavouriteBlog

-(id) init {
    self = [super init];
    if (self) {
        _favourites = [[Favourites alloc] initLoad];
    }
    return self;
}

-(void) getPosts: (PostType) type completionBlock: (ShufflerTumblrMultiplePostQueryCompletionBlock) block {
    NSArray<Post> *returnPosts = (NSArray<Post> *)[[NSArray alloc] initWithArray: [_favourites getFavourites]];
    NSError *err = nil;
    block(returnPosts, err);
}

-(void) getInfo: (ShufflerTumblrInfoQueryCompletionBlock) block {
    
}

@end

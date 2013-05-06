//
//  BlogInfo.m
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/29/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "BlogInfo.h"

@implementation BlogInfo


@synthesize blog;

-(id) initWithDictionary:(NSDictionary *) data {
    self = [super init];
    if (self) {
        self.blog = [data objectForKey: @"blog"];
        self.title = [self.blog objectForKey: @"title"];
        self.name = [self.blog objectForKey:@"name"];
        self.posts = [self.blog objectForKey:@"posts"];
        self.blogURL = [self.blog objectForKey:@"url"];
        self.updated = [self.blog objectForKey:@"updated"];
        self.description = [self.blog objectForKey:@"description"];
        self.ask = [self.blog objectForKey:@"ask"];
        self.askAnon = [self.blog objectForKey:@"ask_anon"];
        self.nsfw = [self.blog objectForKey:@"is_nsfw"];
        self.shareLikes = [self.blog objectForKey:@"share_likes"];
    }
    return self;
}

@end

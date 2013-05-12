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
        self.blogURL = [[NSURL alloc] initWithString:[self.blog objectForKey:@"url"]];
        self.updated = [self.blog objectForKey:@"updated"];
        self.description = [self.blog objectForKey:@"description"];
        self.ask = [self.blog objectForKey:@"ask"];
        self.askAnon = [self.blog objectForKey:@"ask_anon"];
        self.likes = [self.blog objectForKey:@"share_likes"];
        
        // Download the blog image
        NSString *imageURLString = [[NSString alloc] initWithFormat: @"http://api.tumblr.com/v2/blog/%@/avatar/512",
                                    [self.blogURL path]];
        NSURL * imageURL = [[NSURL alloc] initWithString: imageURLString];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL: imageURL];
        self.image = [[UIImage alloc] initWithData: imageData];
    }
    return self;
}

@end

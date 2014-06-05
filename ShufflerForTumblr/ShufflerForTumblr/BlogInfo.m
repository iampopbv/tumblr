//
//  BlogInfo.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 05/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import "BlogInfo.h"

@implementation BlogInfo


@synthesize blog;

// Fill the object with a response dictionary from the Tumblr API
-(id) initWithDictionary:(NSDictionary *) data {
    self = [super init];
    if (self) {
        NSDictionary * dict = [data objectForKey: @"response"];
        self.blog = [dict objectForKey: @"blog"];
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
        NSString *skinnyBlogURL = [[self.blogURL description] hasPrefix:@"http"] ? [[self.blogURL description] substringFromIndex:7]: [[self.blogURL description] substringFromIndex:8];
        NSString *imageURLString = [[NSString alloc] initWithFormat: @"http://api.tumblr.com/v2/blog/%@avatar/512",
                                    skinnyBlogURL];
        
        NSURL * imageURL = [[NSURL alloc] initWithString: imageURLString];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL: imageURL];
        self.image = [[UIImage alloc] initWithData: imageData];
    }
    return self;
}

// Fill the object with a blog dictionary from the Tumblr API
-(id) initWithBlogDictionary:(NSDictionary *) blogDict {
    self = [super init];
    if (self) {
        self.blog = blogDict;
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
        NSString *skinnyBlogURL = [[self.blogURL description] hasPrefix:@"http"] ? [[self.blogURL description] substringFromIndex:7]: [[self.blogURL description] substringFromIndex:8];
        NSString *imageURLString = [[NSString alloc] initWithFormat: @"http://api.tumblr.com/v2/blog/%@avatar/512",
                                    skinnyBlogURL];
        
        NSURL * imageURL = [[NSURL alloc] initWithString: imageURLString];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL: imageURL];
        self.image = [[UIImage alloc] initWithData: imageData];
    }
    return self;
}

@end
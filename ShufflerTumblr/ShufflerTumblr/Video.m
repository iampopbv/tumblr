//
//  Video.m
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/24/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "Video.h"

@implementation Video

@synthesize posts;
@synthesize response;
@synthesize blog;

-(id) initWithDictionary:(NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        self.response = [dictionary objectForKey:@"response"];
        self.posts = [self.response objectForKey:@"post"];
        self.blog = [self.response objectForKey:@"blog"];
        self.playURL = [self.posts objectForKey:@"permalink_url"];
        self.playerEmbed = [self.posts objectForKey:@"player"];
        self.ID = [self.posts objectForKey:@"id"];
        self.date = [self.posts objectForKey:@"date"];
        self.caption = [self.posts objectForKey:@"caption"];
        self.thumbnailURL = [self.posts objectForKey:@"thumbnail_url"];
        self.thumbnailWidth = [self.posts objectForKey:@"thumbnail_width"];
        self.thumbnailHeight =  [self.posts objectForKey:@"thumbnail_height"];
    }
    return self;
}

@end

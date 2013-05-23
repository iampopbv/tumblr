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
@synthesize caption;
@synthesize date;
@synthesize ID;
@synthesize playerEmbed;
@synthesize playURL;
@synthesize thumbnailHeight;
@synthesize thumbnailURL;
@synthesize thumbnailWidth;
@synthesize type;

-(id) initWithDictionary:(NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        self.response = [dictionary objectForKey:@"response"];
        self.posts = [dictionary objectForKey:@"post"];
        self.blog = [self.response objectForKey:@"blog"];
        self.playURL = [dictionary objectForKey:@"permalink_url"];
        self.playerEmbed = [dictionary objectForKey:@"player"];
        self.ID = [self.posts objectForKey:@"id"];
        self.date = [self.posts objectForKey:@"date"];
        self.sourceTitle = [dictionary objectForKey: @"source_title"];
        self.caption = [dictionary objectForKey:@"caption"];
        self.caption = [[NSString alloc] initWithFormat: @"%@%@%@", @"<html><body style='font-family:Lucida Sans Unicode;'>",self.caption , @"</body></html>"];
        self.thumbnailURL = [self.posts objectForKey:@"thumbnail_url"];
        self.thumbnailWidth = [self.posts objectForKey:@"thumbnail_width"];
        self.thumbnailHeight =  [self.posts objectForKey:@"thumbnail_height"];
        self.type = VIDEO;
    }
    return self;
}

@end

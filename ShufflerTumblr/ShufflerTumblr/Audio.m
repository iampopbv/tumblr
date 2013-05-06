//
//  Audio.m
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/24/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "Audio.h"

@implementation Audio

@synthesize blog;
@synthesize response;
@synthesize posts;
@synthesize playURL;
@synthesize playerEmbed;
@synthesize ID;
@synthesize date;
@synthesize caption;
@synthesize trackName;
@synthesize artist;
@synthesize album;
@synthesize albumArt;

-(id) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.response = [dictionary objectForKey:@"response"];
        self.posts = [self.response objectForKey:@"post"];
        //[self.response objectForKey:@"post"];
        self.blog = [self.response objectForKey:@"blog"];
        self.playURL = [dictionary objectForKey:@"audio_url"];
        self.playerEmbed = [self.posts objectForKey:@"player"];
        self.ID = [self.posts objectForKey:@"id"];
        self.date = [self.posts objectForKey:@"date"];
        self.caption = [self.posts objectForKey:@"caption"];
        self.trackName = [self.posts objectForKey:@"track_name"];
        self.artist = [self.posts objectForKey:@"artist"];
        self.album = [self.posts objectForKey:@"album"];
        self.albumArt = [self.posts objectForKey:@"album_art"];
        NSLog(@"made %@ from %@ ( not %@ ) with %@",self.playURL, [dictionary objectForKey:@"audio_url"], [self.response objectForKey:@"audio_url"], dictionary);
    }
    return self;
}

@end

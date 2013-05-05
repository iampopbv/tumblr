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

-(id) initWithDictionairy:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.response = [dictionary objectForKey:@"response"];
        NSData* data = [self.response objectForKey:@"post"];
        self.posts = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //[self.response objectForKey:@"post"];
        self.blog = [self.response objectForKey:@"blog"];
        self.playURL = [self.posts objectForKey:@"audio_url"];
        self.playerEmbed = [self.posts objectForKey:@"player"];
        self.ID = [self.posts objectForKey:@"id"];
        self.date = [self.posts objectForKey:@"date"];
        self.caption = [self.posts objectForKey:@"caption"];
        self.trackName = [self.posts objectForKey:@"track_name"];
        self.artist = [self.posts objectForKey:@"artist"];
        self.album = [self.posts objectForKey:@"album"];
        self.albumArt = [self.posts objectForKey:@"album_art"];
    }
    return self;
}

@end

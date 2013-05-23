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
@synthesize albumArtURL;
@synthesize type;

-(id) initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if (self) {
		self.posts = [dictionary objectForKey:@"post"];
		//[self.response objectForKey:@"post"];
		self.blog = [dictionary objectForKey:@"blog"];
		self.playURL = [dictionary objectForKey:@"audio_url"];
		self.playerEmbed = [dictionary objectForKey:@"player"];
		self.embed=[dictionary objectForKey: @"embed"];
		self.ID = [dictionary objectForKey:@"id"];
		self.date = [dictionary objectForKey:@"date"];
		self.caption = [dictionary objectForKey:@"caption"];
		{
			NSString*namehtml = [dictionary objectForKey:@"track_name"];
			if(namehtml)
			{
				self.trackName = [[NSAttributedString alloc] initWithString:namehtml];
			}
		}
		self.artist = [dictionary objectForKey:@"artist"];
		self.album = [dictionary objectForKey:@"album"];
		self.albumArtURL = [NSURL URLWithString: [dictionary objectForKey:@"album_art"]];
		
		NSData *imageData = [[NSData alloc] initWithContentsOfURL: albumArtURL];
		self.albumArt = [[UIImage alloc] initWithData: imageData];
		
		
		self.type = AUDIO;
		NSLog(@"made %@ from %@ ( not %@ ) with %@",self.playURL, [dictionary objectForKey:@"audio_url"], [self.response objectForKey:@"audio_url"], dictionary);
	}
	return self;
}

-(void)parseResponse:(NSDictionary*)dict
{
	
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@ [ %@ ] %@", self.artist, self.trackName, self.playURL, self.caption];
}

@end

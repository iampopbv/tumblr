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
@synthesize latestPostNr;
@synthesize postTimestamp;

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
		self.latestPostNr = [[self.blog objectForKey:@"total_posts"] intValue] - 1;
		self.postTimestamp = [dictionary objectForKey:@"timestamp"];
		
		
		self.type = AUDIO;
//		NSLog(@"made %@ from %@ ( not %@ ) with %@",self.playURL, [dictionary objectForKey:@"audio_url"], [self.response objectForKey:@"audio_url"], dictionary);
//		NSLog(@"latest post nr: %i", latestPostNr);
	}
	return self;
}

-(NSString *)getName {
	NSString *name = [NSString stringWithFormat:@"Audio - %@", self.ID];
	
	return name;
}

-(NSString *) getListName {
	return [NSString stringWithFormat:@"Audio - %@ - %@", self.artist , self.album];
}

-(id)getPostId {
	return self.ID;
}

-(id)initWithCoder:(NSCoder*) coder {
	self = [super init];
	if(self) {
		self.type = AUDIO;
		self.posts = [coder decodeObjectForKey:@"post"];
		self.blog = [coder decodeObjectForKey:@"blog"];
		self.playURL = [coder decodeObjectForKey:@"playurl"];
		self.playerEmbed = [coder decodeObjectForKey:@"playerembed"];
		self.embed = [coder decodeObjectForKey:@"embed"];
		self.ID = [coder decodeObjectForKey:@"id"];
		self.date = [coder decodeObjectForKey:@"date"];
		self.caption = [coder decodeObjectForKey:@"caption"];
		self.trackName = [coder decodeObjectForKey:@"trackname"];
		self.artist = [coder decodeObjectForKey:@"artist"];
		self.album = [coder decodeObjectForKey:@"album"];
		self.albumArtURL = [coder decodeObjectForKey:@"albumarturl"];
		self.albumArt = [coder decodeObjectForKey:@"albumart"];
		self.latestPostNr = [[coder decodeObjectForKey:@"latestPostNr"] intValue];
		self.postTimestamp = [coder decodeObjectForKey:@"timestamp"];

	}
	return self;
}

-(void)encodeWithCoder:(NSCoder*) coder {
	[coder encodeObject:self.posts forKey:@"post"];
	[coder encodeObject:self.blog forKey:@"blog"];
	[coder encodeObject:self.playURL forKey:@"playurl"];
	[coder encodeObject:self.playerEmbed forKey:@"playerembed"];
	[coder encodeObject:self.embed forKey:@"embed"];
	[coder encodeObject:self.ID forKey:@"id"];
	[coder encodeObject:self.date forKey:@"date"];
	[coder encodeObject:self.caption forKey:@"caption"];
	[coder encodeObject:self.trackName forKey:@"trackname"];
	[coder encodeObject:self.artist forKey:@"artist"];
	[coder encodeObject:self.album forKey:@"album"];
	[coder encodeObject:self.albumArtURL forKey:@"albumarturl"];
	[coder encodeObject:self.albumArt forKey:@"albumart"];
	NSNumber *tmp = [[NSNumber alloc] initWithInt: self.latestPostNr];
	[coder encodeObject:tmp forKey:@"latestPostNr"];
	[coder encodeObject: self.postTimestamp forKey:@"timestamp"];
}

-(void)parseResponse:(NSDictionary*)dict
{
	
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@ [ %@ ] %@", self.artist, self.trackName, self.playURL, self.caption];
}

@end

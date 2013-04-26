//
//  Album.m
//  DJBroadcast
//
//  Created by Justin Oud on 3/20/13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "Album.h"


@implementation Album

@synthesize type;
@synthesize genres;
@synthesize artists;
@synthesize title;
@synthesize embeddable;
@synthesize organisationOwner;
@synthesize webpage;
@synthesize releaseId;
@synthesize covers;
@synthesize smallCovers;
@synthesize hugeCovers;
@synthesize releaseDate;
@synthesize playtime;
@synthesize descriptiontext;

@synthesize image;
@synthesize imageBigURL;
@synthesize imageSmallURL;
@synthesize tracklist;


-(id)initWithData:(NSDictionary *)data
{
	self = [super init];
	
	if( self )
	{
		self.artists = [data objectForKey:@"artists"];
		
		self.type = ALBUM;
		
		self.releaseId = [data objectForKey:@"release_id"];
		self.releaseDate = [data objectForKey:@"release_date"];
		self.webpage = [data objectForKey:@"url"];
		self.title = [data objectForKey:@"title"];
		self.playtime = [(NSString*)[data objectForKey:@"playtime"] intValue];
		self.descriptiontext = [data objectForKey:@"text"];
		self.genres = [NSArray arrayWithObject:[[data objectForKey:@"genre1"] objectForKey:@"genre"]];
		self.hugeCovers = [data objectForKey:@"cover_huge"];
		self.covers = [data objectForKey:@"cover"];
		self.smallCovers = [data objectForKey:@"cover_small"];
		NSDictionary *coverDictSmall = [data objectForKey:@"cover_small"];
		self.imageSmallURL = [[NSURL alloc] initWithString: [coverDictSmall objectForKey: @"fm_main_small"]];

		// build a tracklist
		NSMutableArray* tracks = [NSMutableArray arrayWithCapacity:[[data objectForKey:@"tracklist"] count ]];
		for (NSDictionary *track in [data objectForKey:@"tracklist"]) {
			[tracks addObject: [NSURL URLWithString: [track objectForKey:@"file"]]];
		}
		self.tracklist = tracks;
	}
	return self;
}

-(id)initFromJSON:(NSString *)json
{
	self = [self initWithData: [self parseJSON: json]];
	
	return self;
}

-(NSDictionary*)parseJSON:(NSString *)data
{
	SBJSON *parser = [[SBJSON alloc] init];
	NSDictionary *results = [parser objectWithString:data error:nil];
	
	return results;
}

@end

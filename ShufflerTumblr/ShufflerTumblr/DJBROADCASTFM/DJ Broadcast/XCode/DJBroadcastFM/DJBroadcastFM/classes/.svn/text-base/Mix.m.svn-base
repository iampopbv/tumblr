//
//  Mix.m
//  DJBroadcast
//
//  Created by Justin Oud on 3/20/13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "Mix.h"

@implementation Mix


@synthesize type;
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
@synthesize genres;

@synthesize image;
@synthesize imageBigURL;
@synthesize imageSmallURL;
@synthesize tracklist;

-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
	
	if(self)
	{
		self.type = MIX;
		
		self.title = [data objectForKey:@"title"];
		self.playtime = [(NSString*)[data objectForKey:@"playtime"] intValue];
		
		// Mixes do not have a descriptiontext.
		self.descriptiontext = @"";
		
		self.artists = [NSArray arrayWithObject: [[data objectForKey:@"artist"] objectForKey:@"artist_name"]];
		
		self.genres = [NSArray arrayWithObject: [[data objectForKey:@"genre1"] objectForKey:@"genre"]];
    
		// the plethora of covers
		self.hugeCovers = [data objectForKey:@"cover_huge"];
		self.covers = [data objectForKey:@"cover"];
		self.smallCovers = [data objectForKey:@"cover_small"];

		NSDictionary *coverDict = [data objectForKey:@"cover_small"];
		self.imageSmallURL = [NSURL URLWithString: [coverDict objectForKey: @"fm_main_small"]];

		self.releaseId = [data objectForKey:@"release_id"];
		self.releaseDate = [data objectForKey:@"release_date"];
		
		self.webpage = [data objectForKey:@"url"];

    
		// build a tracklist
		NSMutableArray* tracks = [NSMutableArray arrayWithCapacity:[[data objectForKey:@"tracklist"] count ]];
		for (NSDictionary *track in [data objectForKey:@"tracklist"])
		{
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
	return [[[SBJSON alloc] init] objectWithString:data error:nil];
}

@end

//
//  Search.m
//  DJBroadcastFM
//
//  Created by B Al on 2013-03-29.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "Search.h"

@implementation Search

NSString *const separatorstring = @" ,";

-(id)initWithGenres:(NSArray *)genres
{
	return [self initSearch:genres keys:@""];
}

-(id)initWithFilter:(NSString *)keys
{
	return [self initSearch:[[NSArray alloc] initWithObjects:nil] keys:keys];
}

-(id)initSearch:(NSArray *)genres keys:(NSString *)keys;
{
	self = [super init];
	if( self )
	{
		self.genres = genres;
		NSCharacterSet *const separators = [NSCharacterSet characterSetWithCharactersInString:separatorstring];
		keys = [keys stringByTrimmingCharactersInSet:separators];
		if([keys isEqualToString:@""])
		{
			self.filters = [[NSArray alloc] initWithObjects: nil];
		}
		else
		{
			self.filters = [keys componentsSeparatedByCharactersInSet:separators];
		}
	}
	return self;
}

-(NSString *const)APIquery
{
	NSString *const query = [DJBroadcastDB APIURI];
	// TODO: append query
	return query;
}

@end

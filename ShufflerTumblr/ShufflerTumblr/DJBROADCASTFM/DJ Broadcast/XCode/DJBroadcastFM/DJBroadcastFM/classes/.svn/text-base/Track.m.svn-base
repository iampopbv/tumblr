//
//  Track.m
//  DJBroadcast
//
//  Created by Justin Oud on 3/20/13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "Track.h"

@implementation Track

@synthesize title;
@synthesize artists;
@synthesize hugeCovers;
@synthesize covers;
@synthesize smallCovers;
@synthesize releaseId;
@synthesize releaseDate;
@synthesize webpage;
@synthesize playtime;
@synthesize organisationOwner;
@synthesize embeddable;
@synthesize type;
@synthesize image;
@synthesize imageBigURL;
@synthesize imageSmallURL;
@synthesize streamurl;

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

-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
	self.artists = [data objectForKey:@"artists"];

    NSString * typeString =[data objectForKey:@"type"];
    if([typeString isEqualToString:@"album"]){
        self.type = ALBUM;
    } else if ([typeString isEqualToString:@"playlist"]){
        self.type = PLAYLIST;
    } else if([typeString isEqualToString:@"mix"]){
        self.type = MIX;
    }
    
    
	self.hugeCovers = [data objectForKey:@"cover_huge"];
	self.covers = [data objectForKey:@"cover"];
	self.smallCovers = [data objectForKey:@"cover_small"];
	self.releaseId = [data objectForKey:@"release_id"];
	self.releaseDate = [data objectForKey:@"release_date"];
	self.webpage = [data objectForKey:@"url"];
	self.title = [data objectForKey:@"title"];
    //NSLog(@"%@" , self.title);
	
	NSDictionary *coverDict = [data objectForKey:@"cover_small"] ;
	
	
	self.imageSmallURL = [[NSURL alloc] initWithString: [coverDict objectForKey: @"fm_main_small"]];
    
    //NSLog(@"%@" , self.imageURL);
	
    NSDictionary *tempTracklist = [[data objectForKey:@"tracklist"] objectAtIndex:0];
    
    return self;
}

@end

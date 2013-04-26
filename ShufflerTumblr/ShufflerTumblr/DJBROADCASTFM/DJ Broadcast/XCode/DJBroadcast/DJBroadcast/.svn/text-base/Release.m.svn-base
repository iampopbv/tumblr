//
//  Release.m
//  DJBroadcast
//
//  Created by Casper Eekhof on 20-03-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "Release.h"

@implementation Release

- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)initRelease:(NSString*)data
{
	self = [super init];
	if(self)
	{
		NSDictionary *result = [self parseJSON: data];
	}
	return self;
}

-(NSDictionary*)parseJSON: (NSString*) data {
    SBJSON *parser = [[SBJSON alloc] init];
    NSDictionary *results = [parser objectWithString:data error:nil];
    
    return results;
}

@end


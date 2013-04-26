//
//  Release.h
//  DJBroadcast
//
//  Created by Casper Eekhof on 20-03-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"

typedef enum ReleaseType
{
	TRACK,
	ALBUM,
	MIX
} ReleaseType;

@interface Release : NSObject

@property ReleaseType* type;
@property NSMutableArray* genres;
@property NSMutableArray* artists;
@property NSString* title;
@property BOOL* embeddable;
@property NSString* organisationOwner;
@property NSURL* webpage;
@property int* releaseId;
@property NSMutableArray* covers;
@property NSMutableArray* smallCovers;
@property NSMutableArray* hugeCovers;
@property NSDate* releaseDate;
@property double playtime;

-(NSDictionary*) parseJSON: (NSString*) data;


@end

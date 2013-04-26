//
//  Release.h
//  DJBroadcast
//
//  Created by Casper Eekhof on 20-03-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"


@protocol Release


@required
typedef enum ReleaseType
{
	TRACK,
	ALBUM,
    PLAYLIST,
	MIX
} ReleaseType;
@property NSArray *artists;
@property ReleaseType type;
@property NSString* title;
@property BOOL* embeddable;
@property NSString* organisationOwner;
@property NSURL* webpage;
@property id releaseId;
@property NSMutableArray* covers;
@property NSMutableArray* smallCovers;
@property NSMutableArray* hugeCovers;
@property NSDate* releaseDate;
@property int playtime;
@property NSString* descriptiontext;
@property NSArray* genres;

@property UIImage *image;
@property NSURL *imageBigURL;
@property NSURL *imageSmallURL;

@property NSArray* tracklist;

-(NSDictionary*) parseJSON: (NSString*) data;
-(id)initFromJSON:(NSString*)json;
-(id)initWithData: (NSDictionary*) data;

@end

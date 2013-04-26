//
//  Genre.h
//  DJBroadcast
//
//  Created by Berend Al on 2013-03-22.
//  Copyright (c) 2013 Casper. All rights reserved.
//

typedef enum GenreType
{
	UNKNOWN,
	HOUSE = 2,
	TECHNO = 3,
    ELECTRONIC = 5,
    BASS = 8,
    DISCO = 9
} GenreType;

@interface Genre : NSObject

@end
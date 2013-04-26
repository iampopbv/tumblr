//
//  Track.h
//  DJBroadcast
//
//  Created by Justin Oud on 3/20/13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"
#import "Genre.h"

@interface Track : NSObject <Single>

@property GenreType* genre;

@end
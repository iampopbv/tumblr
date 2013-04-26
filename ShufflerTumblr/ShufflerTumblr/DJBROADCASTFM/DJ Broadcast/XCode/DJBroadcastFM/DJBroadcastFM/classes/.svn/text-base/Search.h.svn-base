//
//  Search.h
//  DJBroadcastFM
//
//  Created by B Al on 2013-03-29.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJBroadcastDB.h"
#import "Genre.h"

@interface Search : NSObject

@property NSArray *filters;
@property NSArray *genres;

-(id)initWithFilter:(NSString *)keys;
-(id)initWithGenres:(NSArray *)genres;
-(id)initSearch:(NSArray *)genres keys:(NSString *)keys;

-(NSString *)APIquery;

@end

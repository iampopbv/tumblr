//
//  Favourites.h
//  ShufflerTumblr
//
//  Created by Sem Wong on 5/30/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

/**
 * The Favorites mangager.
 * It writes and reads the
 */
@interface Favourites : NSObject

// The loaded favorites.
@property NSMutableArray *favouriteObjects;
// The root directory
@property NSString *root;
@property BOOL gotFavourite;

// the Singleton manager
+(Favourites *)sharedManager;
// Adds a favorite
-(void)addFavourite: (id<Post>) post;
// Removes a favorite
-(void)removeFavourite: (id<Post>) post;
// Checks whether a fav exist or not
-(BOOL)checkFavourite: (id) ID;
-(NSMutableArray*)getFavourites;

@end

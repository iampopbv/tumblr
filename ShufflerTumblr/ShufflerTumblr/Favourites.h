//
//  Favourites.h
//  ShufflerTumblr
//
//  Created by Sem Wong on 5/30/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@interface Favourites : NSObject

@property NSMutableArray *favouriteObjects;
@property NSString *root;

+(Favourites *)sharedManager;
-(void)addFavourite: (id<Post>) post;
-(void)removeFavourite: (id<Post>) post;
-(BOOL)checkFavourite: (id) ID;
-(NSArray*)getFavourites;

@end

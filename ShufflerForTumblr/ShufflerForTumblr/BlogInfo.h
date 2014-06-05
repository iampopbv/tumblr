//
//  BlogInfo.h
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 05/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Info.h"

/**
 * Stores info of the blog
 */
@interface BlogInfo : NSObject <Info>

// The title of the blog
@property NSString* title;
// the blog name
@property NSString* name;
// the blog posts
@property NSString* posts;
// the blog url
@property NSURL* blogURL;
// the last updated date
@property NSString* updated;
// the description
@property NSString* description;
// Other API stuff
@property NSString* ask;
@property NSString* askAnon;
@property NSNumber* likes;
@property UIImage *image;

@end
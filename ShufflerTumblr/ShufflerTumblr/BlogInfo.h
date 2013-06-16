//
//  BlogInfo.h
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/29/13.
//  Copyright (c) 2013 stud. All rights reserved.
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

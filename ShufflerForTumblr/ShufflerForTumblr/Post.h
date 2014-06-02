//
//  Post.h
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 01/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <Foundation/Foundation.h>

// Enum of post types
typedef enum {
    AUDIO = 0,
    VIDEO,
    NONE
} PostType;


/**
 * Protocol for posts.
 * Specifies certain data/methods that all posts have in common.
 */
@protocol Post

@required
// The response dictionary
@property NSDictionary* response;
// The blog dictionary
@property NSDictionary* blog;
// The posts dictionary
@property NSDictionary* posts;
// The url for playing
@property NSString* playURL;
// The embed code
@property NSString* playerEmbed;
// The post ID
@property NSNumber* ID;
// The date of the post
@property NSString* date;
// The description provided by the user
@property NSString* caption;
// The post type
@property PostType type;
@property int latestPostNr;
// The timestamp of the post
@property NSNumber *postTimestamp;
// The blog name
@property NSString *blogName;
// The post URL
@property NSString *postURL;
// The reblog key
@property NSString *reblogKey;

// Fills the object with data of a dictionary
-(id)initWithDictionary: (NSDictionary*) dictionary;
// Title of the post object
-(NSString*)getName;
// the list name
-(NSString*) getListName;
-(id)getPostId;
-(PostType) getType;

@end
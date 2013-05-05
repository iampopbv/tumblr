//
//  Post.h
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/24/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol Post

@required
typedef enum {
    AUDIO,
    VIDEO
} postType;
@property NSDictionary* response;
@property NSDictionary* blog;
@property NSDictionary* posts;
@property NSString* playURL;
@property NSString* playerEmbed;
@property NSNumber* ID;
@property NSString* date;
@property NSString* caption;
@property NSString* trackName;
@property NSString* artist;
@property NSString* album;
@property NSString* albumArt;


-(id)initWithDictionairy: (NSDictionary*) dictionary;

@end

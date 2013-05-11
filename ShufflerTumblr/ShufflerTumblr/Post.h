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
} PostType;
@property NSDictionary* response;
@property NSDictionary* blog;
@property NSDictionary* posts;
@property NSString* playURL;
@property NSString* playerEmbed;
@property NSNumber* ID;
@property NSString* date;
@property NSString* caption;
@property PostType type;

-(id)initWithDictionary: (NSDictionary*) dictionary;

@end

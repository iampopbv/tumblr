//
//  Post.h
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/24/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    AUDIO = 0,
    VIDEO,
    NONE
} PostType;

@protocol Post

@required
@property NSDictionary* response;
@property NSDictionary* blog;
@property NSDictionary* posts;
@property NSString* playURL;
@property NSString* playerEmbed;
@property NSNumber* ID;
@property NSString* date;
@property NSString* caption;
@property PostType type;
@property int latestPostNr;
@property NSNumber *postTimestamp;
@property NSString *blogName;


-(id)initWithDictionary: (NSDictionary*) dictionary;
-(NSString*)getName;
-(NSString*) getListName;
-(id)getPostId;

@end

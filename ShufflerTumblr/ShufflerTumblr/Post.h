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


-(id)initWithDictionary: (NSDictionary*) dictionary;

@end

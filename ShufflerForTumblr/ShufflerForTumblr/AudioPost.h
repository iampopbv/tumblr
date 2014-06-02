//
//  AudioPost.h
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 01/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@interface AudioPost : NSObject <Post>

@property NSString* album;
@property NSString* album_art;
@property UIImage* albumImage;
@property NSURL* albumArtURL;
@property NSString* artist;
@property NSString* audio_type;
@property NSString* audio_url;
//@property NSString* blog_name;
@property NSNumber* can_reply;
//@property NSString* caption;
//@property NSString* date;
//@property NSString* embed;
@property NSNumber* followed;
@property NSString* format;
@property NSArray* highlighted;
//@property NSNumber* post_id;
@property NSNumber* liked;
@property NSNumber* note_count;
//@property NSString* player;
@property NSNumber* plays;
//@property NSString* post_url;
//@property NSString* reblog_key;
@property NSString* short_url;
@property NSString* slug;
@property NSString* state;
@property NSArray* tags;
//@property NSNumber* timestamp;
@property NSAttributedString* track_name;
//@property PostType type;

@end

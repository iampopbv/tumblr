//
//  Audio.h
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/24/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@interface Audio : NSObject <Post>

@property NSAttributedString* trackName;
@property NSString* artist;
@property NSString* album;
@property NSURL* albumArtURL;
@property UIImage* albumArt;
@property NSString*embed;

@end

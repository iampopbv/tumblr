//
//  Audio.h
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 05/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

/**
 * Audio object.
 */
@interface Audio : NSObject <Post>

// The track name
@property NSAttributedString* trackName;
// The artis name
@property NSString* artist;
// The album name
@property NSString* album;
// The album art URL
@property NSURL* albumArtURL;
// The album art
@property UIImage* albumArt;
// The embed URL
@property NSString*embed;

@end
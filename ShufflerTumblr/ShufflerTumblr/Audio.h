//
//  Audio.h
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/24/13.
//  Copyright (c) 2013 stud. All rights reserved.
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

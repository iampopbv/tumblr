//
//  Video.h
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 05/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

/**
 * Video object.
 */
@interface Video : NSObject <Post>

// ThumbnailURL
@property NSString* thumbnailURL;
// Thumbnail width
@property NSString* thumbnailWidth;
// Thumbnail height
@property NSString* thumbnailHeight;
// Source title
@property NSString* sourceTitle;

@end
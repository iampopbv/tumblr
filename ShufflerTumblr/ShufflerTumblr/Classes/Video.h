//
//  Video.h
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/24/13.
//  Copyright (c) 2013 stud. All rights reserved.
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

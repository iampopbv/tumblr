//
//  Video.h
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/24/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"
#import "YoutubeURLGetter.h"

@interface Video : NSObject <Post>

@property NSString* thumbnailURL;
@property NSString* thumbnailWidth;
@property NSString* thumbnailHeight;
@property NSString* sourceTitle;

@end

//
//  Post.h
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/24/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"

@protocol Post

@required
typedef enum {
    AUDIO,
    VIDEO
} postType;

-(id)initWithData: (NSDictionary*) data;

@end

//
//  PostSorter.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 04-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@interface PostSorter : NSObject

-(void) sortPostsOnTime: (NSArray<Post>*) posts;

@end

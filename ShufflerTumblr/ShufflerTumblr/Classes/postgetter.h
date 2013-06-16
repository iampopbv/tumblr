//
//  postgetter.h
//  ShufflerTumblr
//
//  Created by B Al on 2013-05-16.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

/**
 * Protocol for showing a post.
 */
@protocol postgetter <NSObject>

-(void)getPost:(id<Post>)post;
-(void)hidePost;
-(void)showPost;

@property id<Post> post;

@end

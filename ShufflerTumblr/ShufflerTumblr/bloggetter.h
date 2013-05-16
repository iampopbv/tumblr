//
//  bloggetter.h
//  ShufflerTumblr
//
//  Created by B Al on 2013-05-16.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Blog.h"

@protocol bloggetter <NSObject>

-(void)getBlog:(Blog*)blog;

@end

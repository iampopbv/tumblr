//
//  Video.m
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/24/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "Video.h"

@implementation Video

@synthesize posts;
@synthesize response;
@synthesize blog;

-(id) initWithDictionary:(NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        self.response = [dictionary objectForKey:@"response"];
        self.posts = [self.response objectForKey:@"post"];
        self.blog = [self.response objectForKey:@"blog"];
    }
    return self;
}

@end

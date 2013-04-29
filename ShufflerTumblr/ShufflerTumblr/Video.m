//
//  Video.m
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/24/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "Video.h"

@implementation Video

-(id) initWithData:(NSDictionary *) data {
    self = [super init];
    if (self) {
        self.response = [data objectForKey:@"response"];
        self.posts = [self.response objectForKey:@"post"];
        self.blog = [self.response objectForKey:@"blog"];
    }
    return self;
}

@end

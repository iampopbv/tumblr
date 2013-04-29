//
//  BlogInfo.m
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/29/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "BlogInfo.h"

@implementation BlogInfo

-(id) initWithData:(NSDictionary *) data {
    self = [super init];
    if (self) {
        self.blog = [data objectForKey: @"blog"];
    }
    return self;
}

@end

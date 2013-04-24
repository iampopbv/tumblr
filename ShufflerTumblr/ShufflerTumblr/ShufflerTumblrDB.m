//
//  ShufflerTumblrDB.m
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/21/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "ShufflerTumblrDB.h"

@implementation ShufflerTumblrDB

const NSString * apiURL = @"api.tumblr.com/v2/blog/mute-sic.tumblr.com/";
const NSString * apiKey = @"9DTflrfaaL6XIwUkh1KidnXFUX0EQUZFVEtjwcTyOLNsUPoWLV";
static ShufflerTumblrDB * shufflerDB = nil;
NSString * apiGET = @"";

-(id) init {
    if (shufflerDB == nil) {
        if ((shufflerDB = [super init])) {
            return shufflerDB;
        }
    }
    return shufflerDB;
}

@end

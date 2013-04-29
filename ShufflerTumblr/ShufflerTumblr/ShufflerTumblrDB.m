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
const NSString * apiKey = @"?api_key=9DTflrfaaL6XIwUkh1KidnXFUX0EQUZFVEtjwcTyOLNsUPoWLV";
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

-(void) getPosts: (NSString*) type completionBlock: (ShufflerTumblrPostQueryCompletionBlock) block {
    NSString* apiType = type;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *url = [[NSString alloc] initWithFormat: @"%@%@%@%@", apiURL, @"posts/", apiType, apiKey];
        NSURL *urlRequest = [NSURL URLWithString:url];
		NSError *err = nil;
		
		NSString *response = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
        
        switch([apiType characterAtIndex:0]) {
            case 'a':
                [self parseJSONtoAudio: response];
            break;
            case 'v':
                [self parseJSONtoVideo: response];
            break;
        }
    });
}

-(void) getInfo: completionBlock: (ShufflerTumblrInfoQueryCompletionBlock) block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *url = [[NSString alloc] initWithFormat: @"%@%@%@", apiURL, @"info", apiKey];
        NSURL *urlRequest = [NSURL URLWithString:url];
		NSError *err = nil;
		
		NSString *response = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
        
        [self parseJSONtoInfo:response];
    });
}

-(id<Info>) parseJSONtoInfo: (NSString *) jsonString {
    SBJSON *parser = [[SBJSON alloc] init];
    
    NSDictionary *results = [parser objectWithString:jsonString error:nil];
    id<Info> r = [BlogInfo alloc];
    
    return [r initWithData: results];
}

-(id<Post>) parseJSONtoAudio:(NSString *) jsonString {
    SBJSON *parser = [[SBJSON alloc] init];
	// TODO: add code for parsing
	
	NSDictionary *results = [parser objectWithString:jsonString error:nil];
    id<Post> r = [Audio alloc];

    return [r initWithData: results];
}

-(id<Post>) parseJSONtoVideo:(NSString *) jsonString {
    SBJSON *parser = [[SBJSON alloc] init];
	// TODO: add code for parsing
	
	NSDictionary *results = [parser objectWithString:jsonString error:nil];
    id<Post> r = [Video alloc];
    
    return [r initWithData: results];
}

@end

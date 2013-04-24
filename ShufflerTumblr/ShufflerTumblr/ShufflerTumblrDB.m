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

-(void) getPosts: (NSString*) type {
    NSString* apiType = type;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *url = [[NSString alloc] initWithFormat: @"%@%@%@", apiURL, apiType, apiKey];
        NSURL *urlRequest = [NSURL URLWithString:url];
		NSError *err = nil;
		
		NSString *response = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
        
        NSArray *JSONObjects = [response componentsSeparatedByString:@"},{"];
        
        for(int i = 0; i < JSONObjects.count; i++) {
			NSMutableString *tempResult = [JSONObjects objectAtIndex: i];
			if (i == 0) {
				tempResult = [NSMutableString stringWithFormat: @"%@%@", [tempResult substringFromIndex:1] , @"}"];
			} else if (i == JSONObjects.count - 1) {
				tempResult = [NSMutableString stringWithFormat:@"{%@" , [tempResult substringWithRange: NSMakeRange(0, [tempResult length] - 2)]];
			}
			else {
				tempResult = [NSMutableString stringWithFormat:@"{%@%@" , tempResult , @"}"];
			}
        }
    });
}

-(id<Post>) parseJSONtoPost:(NSString *) jsonString {
    SBJSON *parser = [[SBJSON alloc] init];
	// TODO: add code for parsing
	
	NSDictionary *results = [parser objectWithString:jsonString error:nil];
	
	NSString *type = [results objectForKey:@"type"];
    id<Post> r;
    switch ([type characterAtIndex:0])
	{
		case 'v':
			r = [Video alloc];
			break;
		case 'a':
			r = [Audio alloc];
			break;
	}
    return [r initWithData: results];
}

@end

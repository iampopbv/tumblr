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


-(void) getPosts: (NSString*) type completionBlock: (ShufflerTumblrMultiplePostQueryCompletionBlock) block {
    NSString* apiType = type;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *url = [[NSString alloc] initWithFormat: @"%@%@%@%@", apiURL, @"posts/", apiType, apiKey];
        NSURL *urlRequest = [NSURL URLWithString:url];
		NSError *err = nil;
		
		NSData *response = [NSData dataWithContentsOfURL: urlRequest];
        NSArray *objectDict = [NSJSONSerialization JSONObjectWithData:response options: NSJSONReadingMutableContainers error:nil];
        NSMutableArray<Post> * posts = (NSMutableArray<Post> *)[[NSMutableArray alloc] init];
        
        for(NSDictionary *item in objectDict) {
            id<Post> post;
            switch([apiType characterAtIndex:0]) {
                case 'a':
                    post = [Audio alloc];
                    post = [post initWithDictionary: item];
                    break;
                case 'v':
                    post = [Video alloc];
                    post = [post initWithDictionary: item];
                    break;
            }
            if(post != nil)
                [posts addObject: post];
        }
        ;
        NSArray<Post> * returnPosts = (NSArray<Post> *)[[NSArray alloc] initWithArray: posts];
        
        
        block(returnPosts, err);
    });
}

-(void) getInfo: (ShufflerTumblrInfoQueryCompletionBlock) block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *url = [[NSString alloc] initWithFormat: @"%@%@%@", apiURL, @"info", apiKey];
        NSURL *urlRequest = [NSURL URLWithString:url];
		NSError *err = nil;
		
//		NSString *response = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
        NSData *response = [NSData dataWithContentsOfURL: urlRequest];
        NSArray *objectDict = [NSJSONSerialization JSONObjectWithData:response options: NSJSONReadingMutableContainers error:nil];
        
        id<Info> blogInfo = [BlogInfo alloc];
        blogInfo = [blogInfo initWithDictionary: [objectDict objectAtIndex: 0]];
        
        block(blogInfo, err);
    });
}


@end

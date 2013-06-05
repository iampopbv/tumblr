//
//  ShufflerTumblrDB.m
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/21/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "Blog.h"

@implementation Blog

const NSString * apiKey = @"?api_key=9DTflrfaaL6XIwUkh1KidnXFUX0EQUZFVEtjwcTyOLNsUPoWLV";

- (id)init
{
    [NSException raise:@"NoURLException" format:@"No url passed. Use initWithURL instead"];
    return nil;
}


- (id)initWithURL: (NSString*) blogURL {
    self = [super init];
    if (self) {
        if([blogURL hasPrefix: @"http://"])
            blogURL = [blogURL substringFromIndex: 7];
        else
            if ([blogURL hasPrefix: @"https://"])
                blogURL = [blogURL substringFromIndex: 8];
        
        
        
        if(![blogURL hasSuffix: @"/"])
            blogURL = [[NSString alloc] initWithFormat:@"%@/", blogURL];
        _blogURL = [[NSURL alloc] initWithString: [[NSString alloc] initWithFormat:@"http://api.tumblr.com/v2/blog/%@", blogURL]];
        
        [self queryLastPostNrOfType: AUDIO onCompletion:^(int latestPostNr, NSError *error) {
            _offsetRecentPostsAudio = latestPostNr;
            NSLog(@"AUDIO: %i", _offsetRecentPostsAudio);
        }];
        [self queryLastPostNrOfType: VIDEO onCompletion:^(int latestPostNr, NSError *error) {
            _offsetRecentPostsVideo = latestPostNr;
            NSLog(@"VIDEO: %i", _offsetRecentPostsVideo);
        }];
        
    }
    return self;
}


-(void) getPosts: (PostType) type completionBlock: (ShufflerTumblrMultiplePostQueryCompletionBlock) block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSString *apiType = (type == VIDEO ? @"video" : @"audio");
    dispatch_async(queue, ^{
        NSString *url = [[NSString alloc] initWithFormat: @"%@%@%@%@", _blogURL, @"posts/", apiType, apiKey];
        NSLog(@"URL: %@", url);
        NSURL *urlRequest = [NSURL URLWithString:url];
		NSError *err = nil;
        
		NSData *response = [NSData dataWithContentsOfURL:urlRequest];
        NSDictionary *objectDict = [NSJSONSerialization JSONObjectWithData:response options: NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray<Post> * posts = (NSMutableArray<Post> *)[[NSMutableArray alloc] init];
        NSDictionary *responseDict = nil;
        NSArray *postsDict = nil;
        
        responseDict = [objectDict objectForKey:@"response"];
        
        if(responseDict != nil) {
            
            postsDict = [responseDict objectForKey:@"posts"];
            NSLog(@"Amount of post objects: %d" , [postsDict count]);
            
            if(postsDict != nil) {
                for(NSDictionary *item in postsDict) {
                    id<Post> post;
                    switch(type) {
                        case AUDIO:
                            post = [Audio alloc];
                            post = [post initWithDictionary: item];
                            break;
                        case VIDEO:
                            post = [Video alloc];
                            post = [post initWithDictionary: item];
                            break;
                            
                    }
                    if(post != nil)
                        [posts addObject: post];
                }
            }
        }
        
        
        
        NSArray<Post> * returnPosts = (NSArray<Post> *)[[NSArray alloc] initWithArray: posts];
        
        
        block(returnPosts, err);
    });
}

- (void) getNextPageLatest: (ShufflerTumblrMultiplePostQueryCompletionBlock) block {
    _offsetRecentPostsAudio -= 10;
    _offsetRecentPostsVideo -= 10;
    
    [self getLatestPosts: block];
}

-(void) getLatestPosts: (ShufflerTumblrMultiplePostQueryCompletionBlock) block {
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_async(queue, ^{
        NSError *err;
        NSMutableArray<Post> *postsMA;
        NSString *url = [[NSString alloc] initWithFormat: @"%@%@%@%@%i%@%i", _blogURL, @"posts/audio", apiKey, @"&offset=", _offsetRecentPostsAudio, @"&limit=", 10];
        
        // Issue the audio request
        NSURL *urlRequest = [NSURL URLWithString: url];
		NSData *response = [NSData dataWithContentsOfURL:urlRequest];
        NSDictionary *objectDict = [NSJSONSerialization JSONObjectWithData:response options: NSJSONReadingMutableContainers error:nil];
        NSDictionary *responseDict = [objectDict objectForKey:@"response"];
        
        postsMA = (NSMutableArray<Post> *)[[NSMutableArray alloc] init];
        responseDict = [responseDict objectForKey:@"posts"];
        if(responseDict != nil) {
            for(NSDictionary *item in responseDict) {
                    [postsMA addObject: [[Audio alloc] initWithDictionary: item]];
                }
            }
        
        
        // Issue the video request
        url = [[NSString alloc] initWithFormat: @"%@%@%@%@%i%@%i", _blogURL, @"posts/video", apiKey, @"&offset=", _offsetRecentPostsVideo, @"&limit=", 10];
        urlRequest = [NSURL URLWithString: url];
		response = [NSData dataWithContentsOfURL:urlRequest];
        objectDict = [NSJSONSerialization JSONObjectWithData:response options: NSJSONReadingMutableContainers error:nil];
        
        responseDict = [objectDict objectForKey:@"response"];
        responseDict = [responseDict objectForKey:@"posts"];
        if(responseDict != nil) {
            for(NSDictionary *item in responseDict) {
                [postsMA addObject: [[Video alloc] initWithDictionary: item]];
            }
        }

        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"postTimestamp" ascending: YES];
        NSArray<Post> *sortedArr = (NSArray<Post>*)[postsMA sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];

        
        
        block(sortedArr, err);
    });
}

-(void) getInfo: (ShufflerTumblrInfoQueryCompletionBlock) block {
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_async(queue, ^{
		NSString *url = [[NSString alloc] initWithFormat: @"%@%@%@", _blogURL, @"info", apiKey];
		NSURL *urlRequest = [NSURL URLWithString:url];
        
	    NSError *err = nil;
        
		//		NSString *response = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
		NSData *response = [NSData dataWithContentsOfURL: urlRequest];
		if(!response)
		{
			block(nil,[NSError errorWithDomain:@"No connection" code:1 userInfo:nil]);
			return;
		}
		NSMutableDictionary *objectDict = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error:nil];
        
        
		id<Info> blogInfo = [BlogInfo alloc];
		blogInfo = [blogInfo initWithDictionary: objectDict];
		_blogInfo = blogInfo;
		block(blogInfo, err);
	});
}


- (void) queryLastPostNrOfType: (PostType) type onCompletion: (ShufflerTumblrTotalPostQueryCompletionBlock) block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_async(queue, ^{
        NSError *err;
        NSString *apiType = ((type == VIDEO) ? @"video" : (type == AUDIO) ? @"audio" : @"");
        int lastPostNr;
        
        NSString *url = [[NSString alloc] initWithFormat: @"%@%@%@%@%@", _blogURL, @"posts/", apiType, apiKey, @"&limit=1"]; // we only want one post of this type.
		NSURL *urlRequest = [NSURL URLWithString:url];
        
		NSData *response = [NSData dataWithContentsOfURL: urlRequest];
		if(!response)
		{
			block(-1, [NSError errorWithDomain:@"No connection" code:1 userInfo:nil]);
			return;
		}
		NSMutableDictionary *objectDict = [NSJSONSerialization JSONObjectWithData: response options: NSJSONReadingMutableContainers error:nil];
        lastPostNr = [[[objectDict objectForKey: @"response"] objectForKey:@"total_posts"] intValue];
        
        block(lastPostNr, err);
    });
}

@end
//
//  ShufflerTumblrDB.m
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/21/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "ShufflerTumblrDB.h"

@implementation ShufflerTumblrDB

const NSString *apiURL = @"http://api.tumblr.com/v2/blog/";
const NSString * apiKey = @"?api_key=9DTflrfaaL6XIwUkh1KidnXFUX0EQUZFVEtjwcTyOLNsUPoWLV";


-(id) init {
    [NSException raise:@"NoblogURLException" format:@"caused by not passing any blog url"];
    return nil;
}

- (id)initWithURL: (NSString*) blogURL
{
    self = [super init];
    if (self) {
        if(![blogURL hasSuffix:@"/"]){
            blogURL = [[NSString alloc] initWithFormat: @"%@/", blogURL];
        }
        
        NSString * totalURL = [[NSString alloc] initWithFormat:@"%@%@", apiURL, blogURL];
        _blogURL = [[NSURL alloc] initWithString: totalURL];
    }
    return self;
}

-(void) getPosts: (PostType) postType completionBlock: (ShufflerTumblrMultiplePostQueryCompletionBlock) block {
    NSString* apiType = postType == AUDIO ? @"audio": @"video";
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *url = [[NSString alloc] initWithFormat: @"%@%@%@%@", _blogURL, @"posts/", apiType, apiKey];
        NSURL *urlRequest = [NSURL URLWithString:url];
		NSError *err = nil;
		
		NSData *response = [NSData dataWithContentsOfURL:urlRequest];
        NSArray *objectDict = [NSJSONSerialization JSONObjectWithData:response options: NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray<Post> * posts = (NSMutableArray<Post> *)[[NSMutableArray alloc] init];
        NSDictionary *responseDict = nil;
        NSArray *postsDict = nil;
        NSLog(@"Object Dict: %@" , objectDict);
        for(NSDictionary *item in objectDict) {
            if ([item respondsToSelector: @selector( objectForKey: )]) {
                NSLog(@"Item name: %@" , item);
                responseDict = item;
            }
        }
        
        if(responseDict != nil) {
            
            if([responseDict objectForKey:@"posts"]) {
                postsDict = [responseDict objectForKey:@"posts"];
            }
            
            if(postsDict != nil) {
                for(NSDictionary *item in postsDict) {
                    id<Post> post;
                    switch(postType) {
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

-(void) getInfo: (ShufflerTumblrInfoQueryCompletionBlock) block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *url = [[NSString alloc] initWithFormat: @"%@%@%@", _blogURL, @"info", apiKey];
        NSURL *urlRequest = [NSURL URLWithString:url];
		NSError *err = nil;
		
        NSData *response = [NSData dataWithContentsOfURL: urlRequest];
        NSArray *objectDict = [NSJSONSerialization JSONObjectWithData:response options: NSJSONReadingMutableContainers error:nil];
        
        id<Info> blogInfo = [BlogInfo alloc];
        blogInfo = [blogInfo initWithDictionary: [objectDict objectAtIndex: 0]];
        
        block(blogInfo, err);
    });
}


@end

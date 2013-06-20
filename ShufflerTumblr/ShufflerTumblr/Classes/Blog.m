//
//  ShufflerTumblrDB.m
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/21/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "Blog.h"

@implementation Blog

// The API key
const NSString * apiKey = @"?api_key=9DTflrfaaL6XIwUkh1KidnXFUX0EQUZFVEtjwcTyOLNsUPoWLV";
// The maximum number of new posts
const int maxNewPosts = 4;
BOOL hasSetOffset = NO;

/**
 * Discourage initing a blog without a URL.
 */
- (id)init
{
    [NSException raise:@"NoURLException" format:@"No url passed. Use initWithURL instead"];
    return nil;
}

/**
 * Init all variables, validate and set the blog URL.
 */
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
        
        
        _offsetRecentPostsVideo = 0;
        _offsetRecentPostsVideo = 0;
        _retrievedAllRecentAudioPosts = NO;
        _retrievedAllRecentVideoPosts = NO;
        _reachedTopAudioPosts = YES;
        _reachedTopVideoPosts = YES;
    }
    return self;
}


// resets the offsets of the audiopost. Usefull to call when the user is done viewing this blog.
- (void) reset {
    _offsetRecentPostsAudio = 0;
    _offsetRecentPostsVideo = 0;
}

/**
 * Download the offsets from the API.
 */
-(void) setOffsets {
    [self queryLastPostNrOfType: AUDIO onCompletion:^(int latestPostNr, NSError *error) {
        _audioPosts = latestPostNr;
    }];
    [self queryLastPostNrOfType: VIDEO onCompletion:^(int latestPostNr, NSError *error) {
        _videoPosts = latestPostNr;
    }];
    hasSetOffset = YES;
}


/**
 * Downloads the next latest page
 */
- (void) getNextPageLatest: (ShufflerTumblrMultiplePostQueryCompletionBlock) block {
    // If the offsets are not set yet, download them
    if (!hasSetOffset) {
        [self setOffsets];
    }
    
    int audioLimit = maxNewPosts;
    int videoLimit = maxNewPosts;
    
    // Do some checks
    if(_retrievedAllRecentAudioPosts && !_retrievedAllRecentVideoPosts){
        if((_videoPosts - _offsetRecentPostsVideo ) > 5){
            videoLimit = maxNewPosts * 2;
        } else {
            videoLimit = _offsetRecentPostsVideo;
        }
    }
    
    if(_retrievedAllRecentVideoPosts && !_retrievedAllRecentAudioPosts){
        if((_audioPosts - _offsetRecentPostsAudio ) > 5){
            audioLimit = maxNewPosts * 2;
        } else {
            audioLimit = _offsetRecentPostsAudio;
        }
    }
    
//    Debug info
//    NSLog(@"===============================");
//    NSLog(@"%@", _blogURL);
//    NSLog(@"Video limit: %i", videoLimit);
//    NSLog(@"Audio limit: %i", audioLimit);
//    NSLog(@"Video offset: %i", _offsetRecentPostsVideo);
//    NSLog(@"Audio offset: %i", _offsetRecentPostsAudio);
//    NSLog(@"Video posts: %i", _audioPosts);
//    NSLog(@"Audio posts: %i", _videoPosts);
//    NSLog(@"===============================");
    
    // Get the posts
    [self getLatestPosts: block withAudioOffset: _offsetRecentPostsAudio AndVideoOffset: _offsetRecentPostsVideo AndAudioLimit:
     audioLimit AndVideoLimit: videoLimit];
    
    // Do some after checks and set the offsets
    if((_offsetRecentPostsAudio - _audioPosts) <= maxNewPosts) {
        _offsetRecentPostsAudio += audioLimit; // increase the offset with the amount of retrieved audio posts (limit)
    } else {
        _offsetRecentPostsAudio = _audioPosts;
    }
    if((_offsetRecentPostsVideo - _videoPosts) <= maxNewPosts) {
        _offsetRecentPostsVideo += videoLimit;
    } else {
        _offsetRecentPostsVideo = _videoPosts;
    }
}


/**
 * Downloads the previous latest page
 */
- (void) getPreviousPageLatest: (ShufflerTumblrMultiplePostQueryCompletionBlock) block {
    int audioLimit = maxNewPosts;
    int videoLimit = maxNewPosts;
    
    if((_audioPosts - _offsetRecentPostsAudio) < maxNewPosts){
        _offsetRecentPostsAudio -= _audioPosts - _offsetRecentPostsAudio;
        audioLimit = (_audioPosts - _offsetRecentPostsAudio);
    } else
        _offsetRecentPostsAudio -= maxNewPosts;
    if((_videoPosts - _offsetRecentPostsVideo) < maxNewPosts) {
        _offsetRecentPostsVideo -= _videoPosts - _offsetRecentPostsVideo;
        videoLimit = (_videoPosts - _offsetRecentPostsVideo);
    } else
        _offsetRecentPostsVideo -= maxNewPosts;
    
    
    [self getLatestPosts: block withAudioOffset:_offsetRecentPostsAudio AndVideoOffset:_offsetRecentPostsVideo AndAudioLimit:
     audioLimit AndVideoLimit: videoLimit];
    
}

/**
 * Downloads posts based on an offset and limit
 */
-(void) getLatestPosts: (ShufflerTumblrMultiplePostQueryCompletionBlock) block withAudioOffset: (int) audioOffset AndVideoOffset: (int) videoOffset AndAudioLimit: (int) audioLimit AndVideoLimit: (int) videoLimit {
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_async(queue, ^{
        NSError *err;
        NSMutableArray<Post> *postsMA;
        
        NSString *url;
        NSURL *urlRequest;
        NSData *response;
        NSDictionary *objectDict;
        NSDictionary *responseDict;
        
        
        // Issue the audio request
        if(audioLimit != 0) {
            url = [[NSString alloc] initWithFormat: @"%@%@%@%@%i%@%i", _blogURL, @"posts/audio", apiKey, @"&offset=", audioOffset, @"&limit=", audioLimit];
            NSLog(@"QUERY: %@", url);
            urlRequest = [NSURL URLWithString: url];
            response = [NSData dataWithContentsOfURL:urlRequest];
            objectDict = [NSJSONSerialization JSONObjectWithData:response options: NSJSONReadingMutableContainers error:nil];
            responseDict = [objectDict objectForKey:@"response"];
            
            postsMA = (NSMutableArray<Post> *)[[NSMutableArray alloc] init];
            responseDict = [responseDict objectForKey:@"posts"];
            if(responseDict != nil) {
                for(NSDictionary *item in responseDict) {
                    [postsMA addObject: [[Audio alloc] initWithDictionary: item]];
                }
            }
            if ([responseDict count] == 0) {
                _retrievedAllRecentAudioPosts = YES;
            }
        }
        
        if(videoLimit != 0) {
            // Issue the video request
            url = [[NSString alloc] initWithFormat: @"%@%@%@%@%i%@%i", _blogURL, @"posts/video", apiKey, @"&offset=", videoOffset, @"&limit=", videoLimit];
            urlRequest = [NSURL URLWithString: url];
            response = [NSData dataWithContentsOfURL: urlRequest];
            objectDict = [NSJSONSerialization JSONObjectWithData:response options: NSJSONReadingMutableContainers error:nil];
            
            responseDict = [objectDict objectForKey:@"response"];
            responseDict = [responseDict objectForKey:@"posts"];
            if(responseDict != nil) {
                for(NSDictionary *item in responseDict) {
                    [postsMA addObject: [[Video alloc] initWithDictionary: item]];
                }
            }
            if ([responseDict count] == 0) {
                _retrievedAllRecentVideoPosts = YES;
            }
        }
        
        // Sort the posts on timestamp
        NSArray<Post> *sortedArr;
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"postTimestamp" ascending: NO];
        sortedArr = (NSArray<Post>*)[postsMA sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];
        
        block(sortedArr, err);
    });
}

/**
 * Downloads blog info.
 */
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


/**
 * Returns the total post number of a specific type of posts.
 */
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
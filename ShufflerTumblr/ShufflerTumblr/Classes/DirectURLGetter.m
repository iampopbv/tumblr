//
//  YoutubeURLGetter.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 23-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "DirectURLGetter.h"

@implementation DirectURLGetter

NSString * ytDirectURLConverterURL = @"http://shuffler.fm/youtube/magic?key=Q29yaXRpYmEgbWVsaG9yIHRpbWUgZG8gYnJhc2ls";
UIWebView *webHelper;

+ (id)sharedInstance {
    static DirectURLGetter *instance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{ instance = [[DirectURLGetter alloc] init]; });
    return instance;
}

- (id)init
{
    if(self = [super init]){
        if (!webHelper) { // load the page if never loaded before
            NSURL *url = [[NSURL alloc] initWithString: ytDirectURLConverterURL];
            webHelper = [[UIWebView alloc] init];
            [webHelper loadRequest:[[NSURLRequest alloc] initWithURL: url]];
        }
    }
    return self;
}

// Get the ID of a youtube url
- (NSString*) getYTID: (NSString*) youtubeURL {
    return (NSString*)[[youtubeURL componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"="] ]objectAtIndex:1];
}

// Get the raw YouTube link
- (void) getYoutubeLinkWithURL: (NSString*) youtubeURL withBlock: (PageLoadingCompletionBlock) block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        int countErrors = 0;
        NSString * youtubeId = [self getYTID:youtubeURL];
        
        NSString *function = [NSString stringWithFormat:@"getYTVideoInfo('%@');", youtubeId];
        __block NSString *result;
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            result = [webHelper stringByEvaluatingJavaScriptFromString: function];
        });
        
        NSError* error;
        NSString *infoString;
        while (countErrors < 5 && (infoString == nil || error)) //in case of fail do it 5 times
        {
            countErrors++;
            error = nil;
            infoString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString: result] encoding:NSUTF8StringEncoding error: nil];
        }
        
        
        function = [NSString stringWithFormat:@"getYTDirectLinkFromData('%@','medium');", infoString];
        __block NSString *youtubeURL;
        dispatch_sync(dispatch_get_main_queue(), ^{
            youtubeURL = [webHelper stringByEvaluatingJavaScriptFromString: function];
        });
        block(youtubeURL);
    });
}



- (void) getDirectURLS: (NSArray<Post>*) posts withBlock: (callback) block{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        for (id<Post> post in posts) {
            NSString *playURL = [post playURL];
            
            // Hack YouTube :)
            if ([playURL hasPrefix:@"http://www.youtube."]) {
                [self getYoutubeLinkWithURL: playURL withBlock:^(NSString *youtubeDirectURL) {
                    [post setPlayURL: youtubeDirectURL];
                }];
            } else
                
                // Hack Tumblr :)
                if([playURL hasPrefix:@"http://www.tumblr.com/"]) {
                    [post setPlayURL: [[NSString alloc] initWithFormat: @"%@%@", playURL, @"?plead=please-dont-download-this-or-our-lawyers-wont-let-us-host-audio"]];
                }else
                    
                    // Soundcloud
                    if ([playURL hasPrefix:@""]) {
                        
                    } else
                        
                        // Vimeo
                        if ([playURL hasPrefix:@""]) {
                            
                        }
        }
        block(posts);
    });
}

@end
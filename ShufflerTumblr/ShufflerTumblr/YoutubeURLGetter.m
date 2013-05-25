//
//  YoutubeURLGetter.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 23-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "YoutubeURLGetter.h"

@implementation YoutubeURLGetter

NSString * ytDirectURLConverterURL = @"http://shuffler.fm/youtube/magic?key=Q29yaXRpYmEgbWVsaG9yIHRpbWUgZG8gYnJhc2ls";
static YoutubeURLGetter * youtubeURLGetter;
UIWebView *webHelper;

- (id)init
{
    if(youtubeURLGetter == nil){
        youtubeURLGetter = [super init];
        if (self) {
            if (!webHelper) { // load the page if never loaded before
                NSURL *url = [[NSURL alloc] initWithString: ytDirectURLConverterURL];
                webHelper = [[UIWebView alloc] init];
                [webHelper loadRequest:[[NSURLRequest alloc] initWithURL: url]];
            }
        }
    }
    return youtubeURLGetter;
}

+ (NSString*) getYTID: (NSString*) youtubeURL {
    return (NSString*)[[youtubeURL componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"="] ]objectAtIndex:1];
}

+ (void) getYoutubeLinkWithURL: (NSString*) youtubeURL withBlock: (PageLoadingCompletionBlock) block {
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

@end

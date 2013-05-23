//
//  YoutubeURLGetter.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 23-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YoutubeURLGetter : NSObject


typedef void (^PageLoadingCompletionBlock)(NSString* youtubeDirectURL);
extern UIWebView *webHelper;
extern NSString *ytDirectURLConverterURL;

- (void) getYoutubeLinkWithURL: (NSString*) youtubeURL withBlock: (PageLoadingCompletionBlock) block;

@end

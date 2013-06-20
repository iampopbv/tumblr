//
//  DirectURLGetter.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 18-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@interface DirectURLGetter : NSObject


typedef void (^PageLoadingCompletionBlock)(NSString* youtubeDirectURL);
typedef void (^callback)(id);
extern UIWebView *webHelper;
extern NSString *ytDirectURLConverterURL;

// Shared manager (Singleton)
+ (id) sharedInstance;
// Get the raw Youtube link
- (void) getYoutubeLinkWithURL: (NSString*) youtubeURL withBlock: (PageLoadingCompletionBlock) block;

- (void) getDirectURLS: (NSArray<Post>*) posts withBlock: (callback) block;

@end
//
//  DataPostHandler.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 30-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataPostHandler : NSObject

typedef void (^DataRetrievalCompletionBlock)(NSData *response);

@property NSURLConnection *urlConnection;
@property NSMutableData *responseData;
@property (nonatomic,strong) DataRetrievalCompletionBlock block;

- (void) postDataToURL: (NSString*) apiString post: (NSString*) post onCompletion: (DataRetrievalCompletionBlock) block;

@end

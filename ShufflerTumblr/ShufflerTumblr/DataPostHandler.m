//
//  DataPostHandler.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 30-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "DataPostHandler.h"

@implementation DataPostHandler

- (id)init
{
    self = [super init];
    if (self) {
        _responseData = [[NSMutableData alloc] init];
    }
    return self;
}

- (void) postDataToURL: (NSString*) apiString post: (NSString*) post onCompletion: (DataRetrievalCompletionBlock) block {
    
    NSURL *url = [[NSURL alloc] initWithString: apiString];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL: url];
    [request setHTTPMethod: @"POST"];
    [request setValue: postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: postData];
    _block = block;
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate: self];
    if (!theConnection) {
        // Inform the user that the connection failed.
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData: data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // it is now safe to use the data elsewhere.
    _block(_responseData);
    [_responseData setData: nil];
}

@end

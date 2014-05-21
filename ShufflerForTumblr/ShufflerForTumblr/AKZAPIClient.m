//
//  AKZAPIClient.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 20/05/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import "AKZAPIClient.h"
#import "TMAPIClient.h"

@implementation AKZAPIClient

+(NSString*)userInfoDescription{
    
    __block NSMutableString* returnVal;
    
    [[TMAPIClient sharedInstance] userInfo:^(id result, NSError *error) {
        if (!error){
            NSString* userDescription = [[result valueForKeyPath:@"user.blogs.description"]firstObject];
            returnVal =  [NSMutableString stringWithString:userDescription];
        }else{
            returnVal = [NSMutableString stringWithString:@"?empty?"];
        }
    }];
    
    return returnVal;
}

@end

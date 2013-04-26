//
//  DJBroadcastDB.m
//  DJBroadcast
//
//  Created by Casper Eekhof on 20-03-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "DJBroadcastDB.h"

@implementation DJBroadcastDB

const NSString * apiURL = @"http://www.djbroadcast.fm/fmapi/";

static DJBroadcastDB * djBroadcastDB = nil;

- (id)init
{
    if(djBroadcastDB == nil)
        if ((djBroadcastDB = [super init])) {
            return djBroadcastDB;
        } else {
            return nil;
        }
    return djBroadcastDB;
}



-(Release*) getRelease: (int) releaseId {
    Release * release = nil;
    
    NSString *url = [[NSString alloc] initWithFormat: @"%@%@%d", apiURL, @"release/", releaseId];
    NSURL *urlRequest = [NSURL URLWithString:url];
    NSError *err = nil;
    
    NSString *response = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
    
    NSLog(@"Response: %@", response);
    if(err)
    {
        NSLog(@"An error has occured %@", err  );
        //Handle
    }
    
    Release * rl = [[Release alloc] init];
    
    return release;
}

-(NSMutableArray*) getListData: (int) page {
    Release * release = nil;
    NSString *url = [[NSString alloc] initWithFormat: @"%@%@%d", apiURL, @"listdata/", page];
    NSURL *urlRequest = [NSURL URLWithString:url];
    NSError *err = nil;
    
    NSString *response = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
    
    
    if(!err)
    {
        NSLog(@"Response: %@", response);
    } else {
        NSLog(@"An error has occured %@", err  );
    }
    
    return release;
}
-(NSMutableArray*) getBlockedData: (int) page {
    Release * release = nil;
    NSString *url = [[NSString alloc] initWithFormat: @"%@%@%d", apiURL, @"blockdata/", page];
    NSURL *urlRequest = [NSURL URLWithString:url];
    NSError *err = nil;
    
    NSString *response = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
    
    
    if(!err)
    {
        NSLog(@"Response: %@", response);
    } else {
        NSLog(@"An error has occured %@", err  );
    }
    
    return release;
}
-(NSMutableArray*) getSearch: (NSString*) searchString {
    Release * release = nil;
    NSString *url = [[NSString alloc] initWithFormat: @"%@%@%@", apiURL, @"search/", searchString];
    NSURL *urlRequest = [NSURL URLWithString:url];
    NSError *err = nil;
    
    NSString *response = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
    
    
    if(!err)
    {
        NSLog(@"Response: %@", response);
    } else {
        NSLog(@"An error has occured %@", err  );
    }
    
    return release;
}


@end

//
//  User.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 28-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "User.h"
#import "DataPostHandler.h"

@implementation User

const int limitNextPage = 5;

- (id)init
{
    self = [super init];
    if (self) {
        _dashboardOffset = 0;
    }
    return self;
}


- (NSArray<Post>*) getNextPageDashboard {
    
}

- (NSDictionary*) retrieveUserInfo {
    
}

- (NSArray<Info>*) getNextFollowingPage: (BlogInfoRetrievalBlock) block {
    
}

@end

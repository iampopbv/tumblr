//
//  LazyLoader.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 19-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * An object that implements LazyLoader loads pages lazy.
 * A page is a number of Posts.
 */
@protocol LazyLoader <NSObject>

@required
-(void) loadNextPage;

@end

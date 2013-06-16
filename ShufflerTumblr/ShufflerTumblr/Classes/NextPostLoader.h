//
//  NextPostLoader.h
//  ShufflerTumblr
//
//  Created by B Al on 2013-06-10.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Protocol for showing the next post.
 */
@protocol NextPageLoader <NSObject>

-(void)loadNextPage;

@end

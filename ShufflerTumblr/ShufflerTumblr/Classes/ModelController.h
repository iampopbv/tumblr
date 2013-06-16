//
//  ModelController.h
//  PageBasedAppTest
//
//  Created by Casper Eekhof on 05-05-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Blog.h"
#import "RootViewController.h"

@class DataViewController;

/**
 * The model for the data that needs displaying int DataViewController
 */

@interface ModelController : NSObject <UIPageViewControllerDataSource>

// The blog to display
@property Blog *blog;
// The link to the RootViewController used for loading new data
@property RootViewController *rootVC;
// True if loading new posts
@property BOOL isLoadingPosts;

// UIPageViewControlelr Delegates
- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

// Inits with the blogs specified
-(id)initWithBlog:(Blog*)blog;


@end

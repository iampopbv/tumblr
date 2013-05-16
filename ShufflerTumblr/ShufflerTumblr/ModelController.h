//
//  ModelController.h
//  PageBasedAppTest
//
//  Created by Casper Eekhof on 05-05-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Blog.h"

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

@property Blog*blog;

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

-(id)initWithBlog:(Blog*)blog;

@end

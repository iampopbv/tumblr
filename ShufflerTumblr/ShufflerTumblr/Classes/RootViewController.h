//
//  RootViewController.h
//  PageBasedAppTest
//
//  Created by Casper Eekhof on 05-05-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bloggetter.h"

/**
 * The RootView of the PageViewController. It creates the pages(iOS).
 */
@interface RootViewController : UIViewController <UIPageViewControllerDelegate,bloggetter>

/** UI Components **/
// The pageViewcontroller
@property (strong, nonatomic) UIPageViewController *pageViewController;

// The blog that it should show
@property Blog*blog;

@end

//
//  RootViewController.h
//  PageBasedAppTest
//
//  Created by Casper Eekhof on 05-05-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bloggetter.h"

@interface RootViewController : UIViewController <UIPageViewControllerDelegate,bloggetter>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property Blog*blog;

@end

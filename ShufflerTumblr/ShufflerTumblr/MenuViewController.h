//
//  MenuViewController.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 11-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface MenuViewController : UIViewController

@property Reachability *internetReachableChecker;
@property BOOL hasInternet;
@end

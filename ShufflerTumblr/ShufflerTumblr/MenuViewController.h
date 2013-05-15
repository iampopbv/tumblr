//
//  MenuViewController.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 11-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "BlogInfo.h"
#import "ShufflerTumblrDB.h"

@interface MenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *blog1;
@property (weak, nonatomic) IBOutlet UIImageView *blog2;
@property Reachability *internetReachableChecker;
@property BOOL hasInternet;
@end

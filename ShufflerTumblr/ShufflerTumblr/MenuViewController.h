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
#import "Blog.h"

@interface MenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *blog1;
@property (weak, nonatomic) IBOutlet UIImageView *blog2;
@property Reachability *internetReachableChecker;
@property BOOL hasInternet;
@property (weak, nonatomic) IBOutlet UIImageView *imageBlog1;
@property (weak, nonatomic) IBOutlet UIImageView *imageBlog2;
@property (weak, nonatomic) IBOutlet UIImageView *imageBlog3;
@property (weak, nonatomic) IBOutlet UIImageView *imageBlog4;
@end

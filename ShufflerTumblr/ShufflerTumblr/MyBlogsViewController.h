//
//  MyBlogsViewController.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 26-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Info.h"
#import "PostTableDelegate.h"

@interface MyBlogsViewController : UIViewController <PostTableDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end

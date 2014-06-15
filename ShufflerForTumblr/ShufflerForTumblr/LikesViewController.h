//
//  LikesViewController.h
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 06/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LikesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (strong, nonatomic) NSString* blogName;

@end

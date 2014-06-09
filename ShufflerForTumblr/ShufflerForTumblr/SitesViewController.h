//
//  SitesViewController.h
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 19/05/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SitesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

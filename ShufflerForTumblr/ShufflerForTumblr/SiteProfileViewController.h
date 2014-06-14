//
//  SiteProfileViewController.h
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 05/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiteProfileViewController : UIViewController<UIScrollViewDelegate, UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString* blogName;

@end

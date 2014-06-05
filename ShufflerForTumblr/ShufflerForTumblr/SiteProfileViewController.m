//
//  SiteProfileViewController.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 05/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import "SiteProfileViewController.h"

@interface SiteProfileViewController ()

@end

@implementation SiteProfileViewController

@synthesize blogName = _blogName;

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:44/255.0 green:71/255.0 blue:98/255.0 alpha:1.0];
    self.title = [[NSString stringWithFormat:@"%@", _blogName] uppercaseString];
    
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{}

@end

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
    
    NSLog(@"%@", _blogName);
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{}

@end

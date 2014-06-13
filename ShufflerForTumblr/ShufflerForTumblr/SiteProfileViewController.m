//
//  SiteProfileViewController.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 05/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import "SiteProfileViewController.h"

@interface SiteProfileViewController ()
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@end

@implementation SiteProfileViewController

/**
 */
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = [[NSString stringWithFormat:@"%@", _blogName] uppercaseString];
    
    self.scrollView.contentSize = CGSizeMake(320.0, 455.0);
    self.scrollView.autoresizesSubviews = NO;
}

/**
 */
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

/**
 */
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{}

@end

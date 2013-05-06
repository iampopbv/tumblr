//
//  WebViewController.m
//  ShufflerTumblr
//
//  Created by stud on 4/24/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end


@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSURL *TumblrURL = [NSURL URLWithString:@"https://www.tumblr.com/login?from_splash=1"];
    
    NSURLRequest *TumblrRequest = [NSURLRequest requestWithURL:TumblrURL];
    
    [_TumblrLogin loadRequest:TumblrRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

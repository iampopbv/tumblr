//
//  MenuViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 11-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

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
	// Do any additional setup after loading the view.
    [self testInternetConnection];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// Checks if we have an internet connection or not

- (void)testInternetConnection
{
    _internetReachableChecker = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    _internetReachableChecker.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            _hasInternet = YES;
        });
    };
    
    // Internet is not reachable
    _internetReachableChecker.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            _hasInternet = NO;
        });
    };
    
    [_internetReachableChecker startNotifier];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    // a segue from here should only result in a popup if there is no internet
    if(!_hasInternet){
        UIAlertView *cellularData = [[UIAlertView alloc] initWithTitle: @"Geen internet" message:@"U heeft een active internetverbinding nodig om Shumbler te kunnen gebruiken"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
        [cellularData show];
        return NO;
    }
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *segueName = [segue identifier];
    
}

@end

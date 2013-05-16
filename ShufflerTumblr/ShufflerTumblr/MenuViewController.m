//
//  MenuViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 11-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "MenuViewController.h"
#import "Blog.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _hasInternet = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self testInternetConnection];
    
    // load the 4 featured blogs
    //    Blog *blog1 = [[Blog alloc] initWithURL: @"http://tuneage.tumblr.com/"];
    //    [blog1 getInfo:^(id<Info> info, NSError *error) {
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            BlogInfo * blogInfo = info;
    //            [_imageBlog1 setImage: [blogInfo image]];
    //        });
    //    }];
    //
    //    Blog *blog2 = [[Blog alloc] initWithURL: @"http://tracks.ffffine.com/"];
    //    [blog2 getInfo:^(id<Info> info, NSError *error) {
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            BlogInfo * blogInfo = info;
    //            [_imageBlog2 setImage: [blogInfo image]];
    //        });
    //    }];
    //
    //    Blog *blog3 = [[Blog alloc] initWithURL: @"http://songsyouusedtolove.tumblr.com/"];
    //    [blog3 getInfo:^(id<Info> info, NSError *error) {
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            BlogInfo * blogInfo = info;
    //            [_imageBlog3 setImage: [blogInfo image]];
    //        });
    //    }];
    //
    //    Blog *blog4 = [[Blog alloc] initWithURL: @"http://myuuzikk.tumblr.com/"];
    //    [blog4 getInfo:^(id<Info> info, NSError *error) {
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            BlogInfo * blogInfo = info;
    //            [_imageBlog4 setImage: [blogInfo image]];
    //        });
    //    }];
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
    if([segueName isEqualToString: @"segue_blog1"]){
    } else if([segueName isEqualToString: @"segue_blog2"]) {
    } else if([segueName isEqualToString: @"segue_blog3"]){
    } else if([segueName isEqualToString: @"segue_blog4"]) {
    }
    
}

- (void)viewDidUnload {
    [self setImageBlog1:nil];
    [self setImageBlog2:nil];
    [self setImageBlog3:nil];
    [self setImageBlog4:nil];
    [super viewDidUnload];
}
@end

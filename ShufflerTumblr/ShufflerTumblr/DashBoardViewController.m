//
//  DashBoardViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 26-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "DashBoardViewController.h"
#import "MPOAuthURLRequest.h"
#import "MPOAuthURLResponse.h"
#import "keys.h"
#import "MPOAuthSignatureParameter.h"

@interface DashBoardViewController ()

@end

@implementation DashBoardViewController

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
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    NSURL * url = [[NSURL alloc] initWithString: @"http://api.tumblr.com/v2/user/dashboard"];
    NSMutableURLRequest *urlMutableRequest = [[NSMutableURLRequest alloc] initWithURL: url];
    [urlMutableRequest setHTTPMethod: @"GET"];
    MPOAuthURLRequest *request = [[MPOAuthURLRequest alloc] initWithURLRequest: urlMutableRequest];
    NSURLRequest *urlRequest = [request urlRequestSignedWithSecret:kConsumerSecret usingMethod: kMPOAuthSignatureMethodHMACSHA1];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate: self];
}

@end
